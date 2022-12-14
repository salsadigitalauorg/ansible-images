# Ansible images
A set of images to make it easier to work with Ansible, AWX and so on, on ARM.

Python versions:
  - 3.8
  - 3.9
  - 3.10
  - 3.11

> Quick note about using `docker buildx bake` for building single arch images locally.
> Any of the images can be built using the command
> ```sh
> docker buildx bake [image=name] \
>   --progress=plain --set "*.platform=linux/$(uname -m)" --load
> ```
> By default `bake` will use the `docker-container` driver, which uses a
> BuildKit container under the hood. That comes with the side effect of built
> images not being available in docker. If you're building an image which has no
> other image dependency, or if you're fine with using a remote image, then
> nothing else should be done.
>
> However if you want to build images while reusing local built docker images
> then you need to switch the driver used by `bake`. Run the following command
> to do that:
> ```sh
> # List available drivers.
> docker buildx ls
> # Pick one that says `docker` under DRIVER/ENDPOINT and in the 'running' STATUS.
> docker buildx use default
> # or
> docker buildx use colima
> ```

## [python-crossbuild](python-crossbuild)
A base python image with crossenv installed, providing the ability to
cross-compile python packages for multiarch (commonly amd64 & arm64).
Using this method significantly reduces build time for multiarch images that
require building Python packages from source, as opposed to using qemu emulation
for building the whole image.

## [ansible](ansible)
Starts from the **python-crossbuild** image and installs Ansible.

## [ansible-test](ansible-test)
Starts from the **python-crossbuild** image and installs Ansible, pytest and
their dependencies for all the supported versions of python.

## [ansible-runner](ansible-runner)
Building from the **python-crossbuild** and **ansible** images and using the
official Docker python base image, while also taking bits and pieces from the
official [ansible-runner](https://github.com/ansible/ansible-runner/blob/devel/Dockerfile) image to create a base for AWX Execution Environments that are multiarch and more versatile.

## [ansible-runner-php](ansible-runner-php)
Builds on **ansible-runner** and installs PHP 8.1.

## [awx-resources](awx-resources)
Builds on the **ansible** image, installs awxkit and the playbooks for importing
and exporting AWX resources. Handy for tracking your inventories, job templates
and so on in code.
