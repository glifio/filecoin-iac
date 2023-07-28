# How to update mainnet

- [](#)
- [](#)

### General information

1. What releases are acceptable for the upgrade? (No release candidates unless explicitly demanded)
with tag `v*.*.*` - v1.20.0

2. Where to find the releases? (mainnet/calibnet/spacenet)

- for mainnet (https://github.com/filecoin-project/lotus)[https://github.com/filecoin-project/lotus]
- for calibnet ()[]
- for spacenet (https://github.com/consensus-shipyard/lotus)[https://github.com/consensus-shipyard/lotus]


- Why do we use two separate CodeBuild instances?
   We have 2 separate CodeBuild for amd and arm images, because of Lotus has a huge requirements for building images
   AWS doesn't manage to a lot of capacity on area


3. What should I do if I want to add methods to Lotus Gateway? (use this one and that one fork (make that a clickable link))

 - You have to create a new branch in our fork [protofire/lotus](https://github.com/protofire/lotus) from the tag or the last commit

```` 
 git remote -v  
 git remote add upstream git@github.com:filecoin-project/lotus.git
 git fetch upstream
 git switch --detach e6e5599ajfjfjflahs (last commit or tag)
 git switch -c ${name your branch}
 ````
 - You have to add new methods to the new branch, you can find steps [here](https://github.com/glifio/filecoin-iac/blob/main/documentation/add-methods-to-lotus.md) 


4. Where to build?

for mainnet and calibration:
- create *amd64* image, codebuild
`filecoin-mainnet-apn1-glif-api-read-amd64-codebuild-deploy`
- create *arm64* image, codebuild
`filecoin-mainnet-apn1-glif-api-read-arm64-codebuild-deploy`

for spacenet:
- create *amd64* image, codebuild
`filecoin-mainnet-apn1-glif-spacenet-amd64-codebuild-deploy`



5. What data is required to build the image? What should I change if I want to do this and that? That's related to the docker repository.

- Follow the codebuild , e.g `filecoin-mainnet-apn1-glif-api-read-arm64-codebuild-deploy`
- Make sure that your source path is correct
  ![Screenshot 2023-07-28 at 10.07.33.png](png%2FScreenshot%202023-07-28%20at%2010.07.33.png)
- click on edit `Buildspec`
 ${CUSTOM_TAG} - you source branch




7. Where the resulting image is pushed to?\
Pushed images stored in the [Docker Hub](https://hub.docker.com/r/glif/lotus/tags)

8. What's our naming convention for the images?\
You can find about naming convention [Use pre-built images](https://github.com/glifio/filecoin-docker#use-pre-built-images)
