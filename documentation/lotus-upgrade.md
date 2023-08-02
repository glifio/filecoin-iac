# How to update mainnet /calibration/ spacenet


### General information

Q: **What releases are acceptable for the upgrade?**\
A: We accept only stable releases unless explicitly demanded otherwise.

Q: **Where to find the releases?**\
A: You can find the releases for `mainnet and calibnet` in this repository: https://github.com/filecoin-project/lotus and the releases for `spacenet` in this one: https://github.com/consensus-shipyard/lotus

Q: **Why do we use two separate CodeBuild instances?**\
A: We’ve tried to use buildx to build multi-architectural images but with no avail. It takes hours to build such an image on the largest CodeBuild instance available, whereas it takes only ~7 minutes to build the image for one CPU architecture.

Q: **Where the resulting image is pushed to?**\
A: The resulting images are pushed to [DockerHub](https://hub.docker.com/r/glif/lotus/tags) using the credentials from AWS Secret Manager.

Q: **What's our naming convention for the images?**\
A: You can find out about our naming convention in this doc in the [Use pre-built images](https://github.com/glifio/filecoin-docker/blob/master/README.md#use-pre-built-images) section.

Q: **What should I do if I want to add methods to Lotus Gateway?**\
A:  You have to create a fork of the [lotus](https://github.com/protofire/lotus) or [eudico](https://github.com/protofire/eudico) repo, clone the fork and do the following:

```
git remote -v  
git remote add upstream git@github.com:filecoin-project/lotus.git (Add the original repo as a remote named upstream)
git fetch upstream
git switch --detach e6e5599ajfjfjflahs (The commit or tag you want to add the methods on top of)
git switch -c ${name your custom branch}
```
Then you can follow the documentation on how to add new methods keeping in mind that you have to point CodeBuild to your fork instead of the source repo.
### How to Use CodeBuild

The main purpose of using CodeBuild is to build and push the Docker image to DockerHub. 
Therefore, the build specification is configured through the [Dockerfile](https://github.com/glifio/filecoin-docker/blob/master/Dockerfile) and what’s left for CodeBuild is to pass arguments for the build command, tag the image and push it.
Therefore, the only CodeBuild source that matters is the secondary source – `glifio/filecoin-docker`. The primary source is needed only when we want to trigger CodeBuild using GitHub events of the primary source repo.

#### Edit Sources

The secondary source branch has to be the following:
- master – for mainnet and calibnet.
- ntwk/spacenet – for spacenet.

![Screenshot 2023-07-28 at 10.07.33.png](png%2FScreenshot%202023-07-28%20at%2010.07.33.png)



#### Edit Buildspec

In order to configure the CodeBuild instance you have to set environment variables.
Environment variables that are used for building:


| Name       | Description                      | Values                                                                                                                                                           |
|------------|----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| IMAGE_NETWORK | Makefile command to build lotus  | lotus – for mainnet;<br/>calibnet – for calibnet;<br/>spacenet – for spacenet.                                                                                   |
| REPO     | GitHub repository to build that contains lotus source code | filecoin-project/lotus – for mainnet/calibnet original releases<br/> protofire/lotus – for releases modified by Protofire<br/> consensus-shipyard – for spacenet releases  |
| SOURCE_BRANCH    | Tag or branch to build from                          | In most cases that would be a tag, but for modified releases that will be a branch with the -custom postfix.                                                               |

Tagging has the following convention: `${SOURCE_BRANCH}-${IMAGE_NAME}-${ARCH}`, where:
- `IMAGE_NAME` is the image network name (mainnet, calibnet, spacenet)
- ARCH is the CPU architecture which the image is built for (arm64, amd64).
Keep in mind that spacenet can only be built for amd64 architecture. That’s because it’s hosted on OVH which only supports amd64-based instances.
