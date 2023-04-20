## Guide how to extend lvm for archive nodes

### First step change size to ebs

1. Go to repo [terraform](https://github.com/glifio/filecoin-iac)
  - cd **aws**/
  - Create initial check
```
   terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl
``` 
```
   terraform workspace list
```
```
   terraform workspace select ${workspace}
```
2. select file **ebs**

   Change `size` (GB) Needs to add ` +1TB`  to every ebs volume of archive node
  
![Screenshot 2023-04-21 at 15.07.22.png](png%2FScreenshot%202023-04-21%20at%2015.07.22.png)

3. Plan and Apply changes

```
terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```

```
terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```

### Manually resize volumes

1. Go to AWS account --> EC2
 
2. Should connect to archive nodes (space00, space07)

3. check the blocks run the command
        ```Lsblk -l```
4. check the physical volumes the command
     ```pvscan```
![image.png](png%2Fimage.png)
5. Should do physical volume resize the command
```pvresize /dev/sdf /dev/sdg /dev/sdh /dev/sdi```
   ![image (1).png](png%2Fimage%20%281%29.png)

6. Should to expand lmv
 ```lvextend -l +100%FREE "/dev/raid-vg/raid-lv"```
![image (2).png](png%2Fimage%20%282%29.png)
 
7. Should to expand xfs
 ```xfs_growfs /dev/raid-vg/raid-lv```