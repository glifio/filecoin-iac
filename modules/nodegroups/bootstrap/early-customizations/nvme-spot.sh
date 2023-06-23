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

# Determine if the current instance type supports nvme. Return 0 if it does, otherwise return 1
is_nvme_supported() {
    # Manually update the list if neccessary, refer to: https://instances.vantage.sh/?region=ap-northeast-1
    nvme_supported_instance_types=(c6gd g4ad g4dn g5 i3 i3en i4i i4i im4gn is4gen m5d m5dn m6gd m6id r5ad r5dn r6gd r6id);

    # Retreive the instance type from metadata
    api_token=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600");
    instance_type=$(curl -H "X-aws-ec2-metadata-token: ${api_token}" -v http://169.254.169.254/latest/meta-data/instance-type);

    # Return 0 if the instance type is in the NVMe supported list
    for instance in "${nvme_supported_instance_types[@]}"; do
      if [[ "$instance_type" =~  ${instance} ]]; then
        echo "true";
        return 0;
      fi
    done

    echo "false";

    return 1;
}

# making_nvme_file_system makes filesystem from nvme volume.
making_nvme_file_system() {
  mkfs -t xfs $1
}

# making_nvme_raid_file_system makes a raid filesystem from i3 intance 1+n nvme volumes.
making_nvme_raid_file_system() {
  yum -y install mdadm.x86_64
  mdadm --create --verbose $2 --level=0 --name=$1 --raid-devices="${#ARRAY[@]}" "${ARRAY[@]}"
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
  check_filesystem=$(blkid "${ARRAY[@]}")
  [ -z "$check_filesystem" ] && making_nvme_raid_file_system "$making_label" /dev/md0 || echo "fs exists"
  mount LABEL=$making_label "$mount_path"
}

# Creates a RAID on the volumes specified in the globally defined $ARRAY
#
# Returns 1 if a filesystem is present on any volumes of the $ARRAY
# Returns 0 is the RAID was successfully created
make_lvm_raid() {
    # Check if filesystem already exists on the volumes
    is_filesistem_exists=$(blkid "${ARRAY[@]}");
    if [ -n "$is_filesistem_exists" ]; then
        echo "Filesystem already exists on those volumes: ${ARRAY[*]}";

        return 1;
    fi

    # Arbitrary names of Volume Group and Logical Volume to create
    local vg_name='raid-vg';
    local lv_name='raid-lv';

    # Arbitrary label to mark the Logical Volume with
    local fs_label="LOCAL_RAID";

    # Mark volumes as Physical Volumes
    pvcreate "${ARRAY[@]}";
    # Create a Volume Group using the Physical Volumes
    vgcreate "$vg_name" "${ARRAY[@]}";
    # Create a Logical Volume using the Volume Group
    lvcreate -i"${#ARRAY[@]}" -I4 -l100%FREE -n"$lv_name" "$vg_name";

    # Make filesystem on the Logical Volume
    mkfs.xfs -L "$fs_label" "/dev/$vg_name/$lv_name";
    # Mount the Logical Volume to the globally defined mount path
    mount LABEL="$fs_label" "$mount_path";

    return 0;
}

# Validation logic allows for detection filesystem is mounted in the system
mount_path="/nvme/disk"
if mount | grep -q $mount_path; then
  echo "RAID already mounted, exiting ...";
  exit 0
fi

# Create mounpoint
mkdir -p "$mount_path";

# Get list of disks
disks="$(lsblk -dpno name)";

# Get root disk (the disk where / is mounted)
root_disk=$(findmnt -n -o SOURCE /);

# Remove rood disk from the disks list
ARRAY=()
for disk in $disks; do
    if [[ "$root_disk" != $disk* ]]; then
        ARRAY+=( "$disk" );
    fi
done

# We have to validate how many volumes we have. Based on this count,
# the filesystem will be created either on one volume
# or on a RAID array.
# Exit if there aren't volumes except for root.
if [ ${#ARRAY[@]} -eq 0 ]; then
  echo "There are no volumes to create RAID from, exit.";
  exit 0
elif [ ${#ARRAY[@]} -eq 1 ]; then
  if [ "$(is_nvme_supported)" == "true" ]; then making_nvme_volume; else make_lvm_raid; fi;
else
  if [ "$(is_nvme_supported)" == "true" ]; then making_nvme_raid_volume; else make_lvm_raid; fi;
fi
--//--
