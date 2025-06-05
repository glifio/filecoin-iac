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


# Creates a RAID on the volumes specified in the globally defined $ARRAY
#
# Returns 1 if a filesystem is present on any volumes of the $ARRAY
# Returns 0 is the RAID was successfully created
make_lvm_raid() {
    # Check if filesystem already exists on the volumes
    local is_filesistem_exists
    
    is_filesistem_exists=$(blkid "$${ARRAY[@]}");
    if [ -n "$is_filesistem_exists" ]; then
        echo "Filesystem already exists on those volumes: $${ARRAY[*]}";

        return 1;
    fi

    # Mark volumes as Physical Volumes
    pvcreate "$${ARRAY[@]}";
    # Create a Volume Group using the Physical Volumes
    vgcreate "$vg_name" "$${ARRAY[@]}";
    # Create a Logical Volume using the Volume Group
    lvcreate -i"$${#ARRAY[@]}" -I128 -l100%FREE -n"$lv_name" "$vg_name";

    # Make filesystem on the Logical Volume
    mkfs.xfs -L "$fs_label" "/dev/$vg_name/$lv_name";
    # Mount the Logical Volume to the globally defined mount path
    mount LABEL="$fs_label" "$mount_path";

    return 0;
}

get_instance_id() {
    local api_token;
    local instance_id;

    api_token=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600");
    instance_id=$(curl -s -H "X-aws-ec2-metadata-token: $${api_token}" http://169.254.169.254/latest/meta-data/instance-id);

    echo "$instance_id";
}

get_instance_region() {
    local api_token;
    local instance_region;

    api_token=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600");
    instance_region=$(curl -s -H "X-aws-ec2-metadata-token: $${api_token}" http://169.254.169.254/latest/meta-data/placement/region);

    echo "$instance_region";
}

# Takes numeric index and returns corresponding lowercase letter
int_to_char() {
    # The first lowercase letter index in ASCII
    local first_index;
    # The current letter index by given argument
    local current_index;

    # Start with the letter 'f'
    # For more information: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
    first_index=102;
    current_index=$((first_index+$1));
    
    # TODO: Replace with something less problematic
    printf "\x$(printf %x $current_index)";
}

get_raid_suitable_devices() {
    # List of all disks
    local disks;
    # Root disk (the disk where / is mounted)
    local root_disk;

    disks="$(lsblk -dpno name)";

    root_disk=$(findmnt -n -o SOURCE /);

    # Echo disk name if it isn't rood disk
    for disk in $disks; do
        if [[ "$root_disk" != $disk* ]]; then
            echo "$disk";
        fi
    done
}

has_raid_fs() {
    # List of all filesystem labels
    local labels;

    labels=$(lsblk -o label);

    for label in $labels; do
        if [[ "$label" == *$fs_label* ]]; then
            return 0;
        fi
    done

    return 1;
}

# Find and attach EBS volumes by Tenant tag value supplied
attach_ebs() {
    # Tag value to filter EBS volumes by. Supplied by Terraform template
    local ebs_tenant;
    # EBS volume IDs to mount
    local volumes;
    # ID of the current instance
    local instance_id;
    # Region where instance is placed
    local instance_region;
    # Index of the current device
    local device_index;
    # Volumes response converted to array
    local volumes_arr;
    # State of the volume attached
    local volume_state;
    # Error has been thrown (true or false)
    local error;
    # API response
    local attachment_status;

    ebs_tenant="${tpl_tenant}";

    instance_id=$(get_instance_id);
    instance_region=$(get_instance_region);
    instance_az=$(aws ec2 describe-instances \
        --instance-ids "$instance_id" \
        --region "$instance_region" \
        --query "Reservations[0].Instances[0].Placement.AvailabilityZone" \
        --output text);

    volumes=$(aws ec2 describe-volumes \
    --filter "Name=tag:Tenant,Values=$ebs_tenant" \
    --query "Volumes[*].VolumeId" \
    --output text \
    --region "$instance_region");

    
    # Convert space separated string to array
    read -ra volumes_arr -d '' <<< "$volumes";

    for i in "$${!volumes_arr[@]}"; do
        volume_id="$${volumes_arr[$i]}"
        device_index=$(int_to_char "$i");
        device_name="/dev/sd$device_index";

        echo "Preparing to attach volume $volume_id to $device_name";

        # Check volume AZ
        volume_az=$(aws ec2 describe-volumes \
            --volume-ids "$volume_id" \
            --region "$instance_region" \
            --query "Volumes[0].AvailabilityZone" \
            --output text);
        
        if [ "$volume_az" != "$instance_az" ]; then
            echo "ERROR: Volume $volume_id is in AZ $volume_az, but instance is in AZ $instance_az"
            continue
        fi

        # Detach volume if still attached
        echo "Detaching volume $volume_id if needed..."
        aws ec2 detach-volume --volume-id "$volume_id" --region "$instance_region" || true;

        # Wait until volume is available
        echo "Waiting for volume $volume_id to be available..."
        aws ec2 wait volume-available --volume-ids "$volume_id" --region "$instance_region";

        # Attach volume
        echo "Attaching volume $volume_id to $instance_id on $device_name"
        aws ec2 attach-volume \
            --device "$device_name" \
            --instance-id "$instance_id" \
            --volume-id "$volume_id" \
            --region "$instance_region";
        
        # Wait for attachment to complete
        echo "Waiting for volume $volume_id to attach..."
        volume_state="attaching"
        while [ "$volume_state" != "attached" ]; do
            volume_state=$(aws ec2 describe-volumes \
                --volume-ids "$volume_id" \
                --region "$instance_region" \
                --query "Volumes[0].Attachments[0].State" \
                --output text)

            echo "Volume $volume_id state: $volume_state"
            sleep 5
        done

        echo "Volume $volume_id successfully attached to $device_name"
    done
}

# Execute in case one of Physical volumes was extended
resize_lvm() {
    # Physical volumes in the Volume group
    local pvs;

    pvs=$(vgdisplay -v "$vg_name" 2> /dev/null | awk '/PV Name/ {print $3}')
    for pv in $pvs; do
        pvresize "$pv";
    done
    
    lvextend -l +100%FREE "/dev/$vg_name/$lv_name";
}

# Execute in case new EBS volume was attached
extend_lvm() {
    # Physical volumes in the Volume group
    local pvs;
    # Disks that are not in Volume group that can be added
    local disks;
    # Create physical volumes from the following disks
    local pvs_new;
    # Error message
    local error_message;

    pvs=$(vgdisplay -v "$vg_name" 2> /dev/null | awk '/PV Name/ {print $3}')
    disks=$(get_raid_suitable_devices);

    pvs_new=();
    for disk in $disks; do
        if [[ $pvs != *$disk* ]]; then
            pvs_new+=( "$disk" );
        fi
    done

    for pv in "$${pvs_new[@]}"; do
        pvcreate "$pv";
        vgextend "$vg_name" "$pv";
        echo "Create pv from $pv";
    done

    error_message=$(lvextend -l +100%FREE "/dev/$vg_name/$lv_name");
    
    # If resizing of the Logical Volume failed
    if [[ $error_message == *"unchanged"* ]]; then
        lvextend -i1 -l+100%FREE "/dev/$vg_name/$lv_name";
    fi
}

# Increase UDP buffers
# See https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes for details.
sysctl -w net.core.rmem_max=7500000
sysctl -w net.core.rmem_default=2097152
sysctl -w net.core.wmem_max=7500000
sysctl -w net.core.wmem_default=2097152

# Attach EBS disks before proceeding
attach_ebs;

# Arbitrary names of Volume Group and Logical Volume to create
vg_name='raid-vg';
lv_name='raid-lv';

# Arbitrary label to mark the Logical Volume with
fs_label="LOCAL_RAID";

# Validation logic allows for detection filesystem is mounted in the system
mount_path="/mnt/raid"
if has_raid_fs; then
  echo "RAID is present, mounting...";
  mkdir -p "$mount_path";
  mount LABEL="$fs_label" "$mount_path";

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
if [ $${#ARRAY[@]} -eq 0 ]; then
  echo "There are no volumes to create RAID from, exit.";
  exit 0;
else
  make_lvm_raid;
fi
--//--
