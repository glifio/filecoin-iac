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

# Validation logic allows for detection filesystem is mounted in the system
mount_path="/nvme/disk"
if mount | grep -q $mount_path; then
  echo "Already mounted, exiting ..."
  exit 0
fi

# Retrieve instance metadata from IMDSv2
token=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
instance_type=$(curl -H "X-aws-ec2-metadata-token: $token" -v http://169.254.169.254/latest/meta-data/instance-type)

# Filter instance type. The goal is to detect i3 instance.
# The i3 instance has nvme, which we need to format and mount.
[[ "$instance_type" =~  "i3" ]] && EXCEPTION="nvme0" || exit 0
disks="$(find /dev -maxdepth 1 ! -type l -name 'xvd[b-z]' -o -name 'nvme?n?' | grep -v $EXCEPTION)"
if [ -z "$disks" ]; then
  mkdir -p $mount_path
  nvme_volume="$(find /dev -maxdepth 1 ! -type l -name 'xvd[b-z]' -o -name 'nvme?n?' | grep $EXCEPTION)"
  check_filesystem="$(blkid "$nvme_volume")"

# A soft validation of detecting existing filesystem on nvme. It is helpful if the instance has rebooted.
  [ -z "$check_filesystem" ] && mkfs -t xfs "$nvme_volume" || echo "fs exists"
  mount "$nvme_volume" "$mount_path"
else exit 0;
fi
--//--
