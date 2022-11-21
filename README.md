# Ansible images

## ansible-runner
Use as the base image for building AWX Execution Environment images. It is notoriously hard to build PHP 8.1 images that are ARM-compatible on Centos 8, on which the official [ansible-runner](https://github.com/ansible/ansible-runner) is based. Starting with the official Docker `php:8.1-cli` instead, and borrowing some of the code from the official runner allow us to efficiently build multiarch images.

When running locally, you can simply build for your platform:
```sh
# For arm64 only.
docker buildx bake ansible-runner --progress=plain --set "ansible-runner.platform=linux/arm64" --print
docker buildx bake ansible-runner --progress=plain --set "ansible-runner.platform=linux/arm64" --load

# For amd64 only.
docker buildx bake ansible-runner --progress=plain --set "ansible-runner.platform=linux/amd64" --print
docker buildx bake ansible-runner --progress=plain --set "ansible-runner.platform=linux/amd64" --load
```

An EE image can be built by creating a Dockerfile as you would:
```Dockerfile
FROM ghcr.io/salsadigitalauorg/ansible-runner:latest

ADD bindep.txt requirements.txt requirements.yml /build/

RUN bindep -f /build/bindep.txt && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install -r /build/requirements.txt \
    && ansible-galaxy role install -r /build/requirements.yml --roles-path /usr/share/ansible/roles \
    && ansible-galaxy collection install -r /build/requirements.yml --collections-path /usr/share/ansible/collections

RUN install-php-extensions @composer

ENV COMPOSER_ALLOW_SUPERUSER=1
```

## ansible-test
An alpine-based image for running `ansible-test` containing pyenv and the following python versions:
  - 3.8
  - 3.9
  - 3.10
  - 3.11

Build the image:
```sh
# For arm64 only.
docker buildx bake ansible-test --progress=plain --set "ansible-test.platform=linux/arm64" --print
docker buildx bake ansible-test --progress=plain --set "ansible-test.platform=linux/arm64" --load

# For amd64 only.
docker buildx bake ansible-test --progress=plain --set "ansible-test.platform=linux/amd64" --print
docker buildx bake ansible-test --progress=plain --set "ansible-test.platform=linux/amd64" --load
```

Use the image as follows from the source directory of an ansible collection you want to test:
```sh
docker run --rm -it -v \
    $PWD/api:/usr/share/collections/ansible_collections/${namespace}/${collection} \
    -w /usr/share/collections/ansible_collections/${namespace}/${collection} \
    ghcr.io/salsadigitalauorg/ansible-test:latest units -v --requirements
```

For example, to test the [Lagoon Ansible collection](https://github.com/salsadigitalauorg/lagoon_ansible_collection):
```sh
git clone git@github.com:salsadigitalauorg/lagoon_ansible_collection.git
cd lagoon_ansible_collection
namespace=lagoon
collection=api
docker run --rm -it -v \
    $PWD/api:/usr/share/collections/ansible_collections/${namespace}/${collection} \
    -w /usr/share/collections/ansible_collections/${namespace}/${collection} \
    ghcr.io/salsadigitalauorg/ansible-test:latest units -v --requirements
```
