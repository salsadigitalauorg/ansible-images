# Ansible images
A set of images to make it easier to work with Ansible, AWX and so on, on ARM.

Python versions:
  - 3.8
  - 3.9
  - 3.10
  - 3.11

## python-crossbuild
A base python image with crossenv installed, providing the ability to
cross-compile python packages for multiarch (commonly amd64 & arm64).
Using this method significantly reduces the time required to build multiarch
images that require building Python packages from source as opposed to

More information & usage [here](python-crossbuild).

## ansible
Starts from the **python-crossbuild** image and installs Ansible.

More information & usage [here](ansible).

## ansible-test
Starts from the **python-crossbuild** image and installs Ansible, pytest and
their dependencies for all the above support versions of python.

More information & usage [here](ansible-test).

## ansible-runner
Building from the **python-crossbuild** and **ansible** images and using the
official Docker python base image, while also taking bits and pieces from the
official [ansible-runner](quay.io/ansible/ansible-runner) to create a base for
AWX Execution Environments that are multiarch and more versatile.

More information & usage [here](ansible-runner).

## ansible-runner-php
Builds on **ansible-runner** and installs PHP 8.1.

More information & usage [here](ansible-runner-php).

## awx-resources
Builds on the **ansible** image, installs awxkit and the playbooks for importing
and exporting AWX resources. Handy for tracking your inventories, job templates
and so on in code.

More information & usage [here](awx-resources).
