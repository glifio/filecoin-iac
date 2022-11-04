Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash

#set -ux

is_instance_type_nvme() {
  #list of NMVE types
  NMVE_INSTANCES=(c6gd g4ad g4dn g5 i3 i3en i4i i4i im4gn is4gen m5d m5dn m6gd m6id r5ad r5dn r6gd r6id)
  # Retrieve instance metadata from IMDSv2
  token=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
  current_type=$(curl -H "X-aws-ec2-metadata-token: ${token}" -v http://169.254.169.254/latest/meta-data/instance-type)
  # Filter instance type. The goal is to detect NVME instance, which we need to format and mount.
  # Link to check NVMEs - https://instances.vantage.sh/?region=ap-northeast-1
  for instance in "${NMVE_INSTANCES[@]}"; do
    if [[ "$current_type" =~  ${instance} ]]; then
      return 0
    fi
  done
  # if there is no match in $NMVE_INSTANCES list exit code is 1`
  return 1
}

# making_nvme_file_system makes filesystem from nvme volume.
making_nvme_file_system() {
  mkfs -t xfs $1
}

# making_nvme_raid_file_system makes a raid filesystem from i3 intance 1+n nvme volumes.
making_nvme_raid_file_system() {
  get_array_count=${#ARRAY[@]}
  yum -y install mdadm.x86_64
  mdadm --create --verbose $2 --level=0 --name=$1 --raid-devices="$get_array_count" $(echo "$nvme_volumes_count")
  mkfs.xfs -L $1 $2
  dracut -H -f /boot/initramfs-$(uname -r).img $(uname -r)
}

# making_nvme_volume allows to make a soft validation of detecting existing
# filesystem on nvme. It is helpful if an i3 instance has rebooted or for spot instances.
making_nvme_volume() {
  check_filesystem=$(blkid ${ARRAY[0]})
  [ -z "$check_filesystem" ] && making_nvme_file_system "${ARRAY[0]}" || echo "fs exists"
  mount "${ARRAY[0]}" "$mount_path"
}

# making_nvme_raid_volume created raid from 1+n nvme volumes, where n is digital and n>=1
making_nvme_raid_volume() {
  making_label=LOCAL_RAID
  check_filesystem=$(blkid $(echo "${ARRAY[@]}"))
  [ -z "$check_filesystem" ] && making_nvme_raid_file_system "$making_label" /dev/md0 || echo "fs exists"
  mount LABEL=$making_label "$mount_path"
}


# Validation logic allows for detection filesystem is mounted in the system
mount_path="/nvme/disk"
if mount | grep -q $mount_path; then
  echo "Already mounted, exiting ..."
  exit 0
fi

is_instance_type_nvme && EXCEPTION="nvme" || exit 0
mkdir -p $mount_path
nvme_volumes_count="$(find /dev -maxdepth 1 ! -type l -name 'xvd[b-z]' -o -name 'nvme?n?' | grep $EXCEPTION)"
ARRAY=()
for i in $(echo "$nvme_volumes_count"); do
  ARRAY+=("$i")
done

# we ahve to validate how many nvme volumes we have. Based on that logic we will create fs for nvme disk or
# for fs on a raid of nvme disks
if [ ${#ARRAY[@]} -eq 0 ]; then
  echo "The nvme volume count is equil 0"
  exit 0
elif [ ${#ARRAY[@]} -eq 1 ]; then
  making_nvme_volume
else
  making_nvme_raid_volume
fi
--//--
