# Ansible images

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
