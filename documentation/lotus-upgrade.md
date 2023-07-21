# How to update mainnet

- [](#)
- [](#)

### General information

1. What releases are acceptable for the upgrade? (No release candidates unless explicitly demanded)


2. Where to find the releases? (mainnet/calibnet/spacenet)

- for mainnet 
- for calibnet
- for spacenet


3. What should I do if I want to add methods to Lotus Gateway? (use this one and that one fork (make that a clickable link))


4. Where to build?


5. Why do we use two separate CodeBuild instances?
   We have 2 separate CodeBuild for amd and arm images, because of Lotus has a huge requirements for building images
   AWS doesn't manage to a lot of capacity on area


6. What data is required to build the image? What should I change if I want to do this and that? That's related to the docker repository.


7. Where the resulting image is pushed to?\
Pushed images stored in the [Docker Hub](https://hub.docker.com/r/glif/lotus/tags)

8. What's our naming convention for the images?\
You can find about naming convention [Use pre-built images](https://github.com/glifio/filecoin-docker#use-pre-built-images)
