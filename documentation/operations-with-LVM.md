- [Remove extra disks from the logical volume](#remove-extra-disks-from-the-logical-volume)
- [Change EBS volumes size](#change-ebs-volumes-size)
- [Resize the logical volume](#resize-the-logical-volume)



# Most common operations with LVM

## Remove extra disks from the logical volume
1. Connect to the EC2 instance.
2. Display available physical volumes:
```shell
   pvscan
```
3. Let’s assume you want to delete the physical volume `/dev/nvme2n1` from the logical volume.
-  Unmount the logical volume:
```shell
   umount /dev/raid-vg/raid-lv
```
-  Delete the logical volume:
```shell
   lvremove /dev/raid-vg/raid-lv
```
-  Remove the physical volume from the volume group:
```shell
   vgreduce raid-vg /dev/nvme2n1 /dev/nvme1n1
```
-  Create the new logical volume based on the volume group:
```shell
   lvcreate -i4 -I128 -l100%FREE -n"raid-lv" "raid-vg"
```
-  Create filesystem on the logical volume:
 ```shell
   mkfs.xfs -L "LOCAL_RAID" /dev/raid-vg/raid-lv
```
-  Mount the filesystem to the selected mount point:
```shell
   mount LABEL="LOCAL_RAID" /mnt/raid
```

![image (4).png](png%2Fimage%20%284%29.png)


## Change EBS volumes size

1. Clone the [filecoin-iac](https://github.com/glifio/filecoin-iac) repository and open it in your text editor of choice.
2. Go to the aws module:
```shell
   cd aws
```
3. Initialize the module:
```shell
   terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl
```
4. Select the appropriate workspace:
```shell
   terraform workspace select filecoin-glif-mainnet-apn1
````
4. Open the `ebs.tf` file and edit the volumes (refer to the [official documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volumes.html)).
 - Extend the ebs volumes use the parameter `size` for all volumes the node.

##### NB! Due to how large the archival nodes are, the rules of extending the volumes are as follows:
Extend the volumes when at least 95% of storage is occupied and not earlier.
Extend each volume by 250 GB. It may not sound like much, but it’s a 1TB increase if we have 4 volumes.

5. Plan and Apply changes

```shell
   terraform plan -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars
```

```shell
   terraform apply -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars
```

## Resize the logical volume

1. Connect to the EC2 instance.
2. Display the physical volumes:
 ```shell
   pvscan
````
![image.png](png%2Fimage.png)
3. Run the physical volume resize command on all physical volumes:
```shell
   pvresize /dev/sdf /dev/sdg /dev/sdh /dev/sdi
```
![image (1).png](png%2Fimage%20%281%29.png)
4. Extend the logical volume to occupy all available space:
```shell
   lvextend -l +100%FREE "/dev/raid-vg/raid-lv"
```
![image (2).png](png%2Fimage%20%282%29.png)
5. Extend the filesystem of the logical volume:
```shell
   xfs_growfs /dev/raid-vg/raid-lv
```
