# How to update mainnet /calibration/ spacenet


### General information

- What releases are acceptable for the upgrade? (No release candidates unless explicitly demanded)
with tag `v*.*.*` - v1.20.0

- Where to find the releases? (mainnet/calibnet/spacenet)

   - for mainnet and calibnet [https://github.com/filecoin-project/lotus](https://github.com/filecoin-project/lotus)
   - for spacenet [https://github.com/consensus-shipyard/lotus](https://github.com/consensus-shipyard/lotus)

- Why do we use two separate CodeBuild instances?\
   We have 2 separate CodeBuild for amd and arm images, because of Lotus has a huge requirements for building images
   AWS doesn't manage to a lot of capacity on area

- Where the resulting image is pushed to?\
   Pushed images stored in the [Docker Hub](https://hub.docker.com/r/glif/lotus/tags)

- What's our naming convention for the images?\
   You can find about naming convention [Use pre-built images](https://github.com/glifio/filecoin-docker#use-pre-built-images)


### Pre-build steps

1. What should I do if I want to add methods to Lotus Gateway? (use this one and that one fork (make that a clickable link))

- You have to create a new branch in our fork [protofire/lotus](https://github.com/protofire/lotus) from the tag or the last commit

```` 
 git remote -v  
 git remote add upstream git@github.com:filecoin-project/lotus.git
 git fetch upstream
 git switch --detach e6e5599ajfjfjflahs (last commit or tag)
 git switch -c ${name your branch}
 ````
- You have to add new methods to the new branch, you can find steps [here](https://github.com/glifio/filecoin-iac/blob/main/documentation/add-methods-to-lotus.md)


2. Codebuild naming

for mainnet and calibration:
- create *amd64* image, codebuild
  `filecoin-mainnet-apn1-glif-api-read-amd64-codebuild-deploy`
- create *arm64* image, codebuild
  `filecoin-mainnet-apn1-glif-api-read-arm64-codebuild-deploy`

for spacenet:
- create *amd64* image, codebuild
  `filecoin-mainnet-apn1-glif-spacenet-amd64-codebuild-deploy`


### How running codebuild

#### Edit source

What data is required to build the image? What should I change if I want to do this and that? That's related to the docker repository.


 - Repository - enter a repo with Lotus `filecoin-project/lotus` or `protofire/lotus `
 - Source version - Enter a branch or tag from which the image will be collected

  ![Screenshot 2023-07-28 at 10.07.33.png](png%2FScreenshot%202023-07-28%20at%2010.07.33.png)

#### Edit Buildspec

**For mainnet changes**
- ${CUSTOM_TAG} - enter you source branch from which the image will be collected
Example: `v.1.23.0-mainnet-arm64`

**For calibration changes**
 - ${IMAGE_NAME} - enter value for name of image `calibnet`
 - ${IMAGE_NETWORK} - value is used by [Makefile](https://github.com/glifio/filecoin-docker/blob/master/Makefile) to build Lotus from secondary source filecoin-docker repo\
`'lotus' --> 'calibnet'`
 - ${CUSTOM_TAG} - enter you source branch from which the image will be collected
 Example: `v.1.23.0-mainnet-arm64`

**For spacenet changes**
- ${CUSTOM_TAG} - enter you source branch from which the image will be collected
  Example: `v.1.23.0-spacenet-amd64`
