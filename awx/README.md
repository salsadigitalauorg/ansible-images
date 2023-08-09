# AWX arm64 image

## Building the image

Create the Dockerfile:
```sh
AWX_VERSION=22.6.0 ./create-dockerfile.sh
```

Build and push:
```sh
cd ..
AWX_VERSION=22.6.0 docker buildx bake awx --progress=plain --load
AWX_VERSION=22.6.0 docker buildx bake awx --progress=plain --push
```
