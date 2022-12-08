target "ansible" {
    contexts = {
        "ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION}" = "target:python-crossbuild"
    }
}

target "awx-resources" {
    contexts = {
        "ghcr.io/salsadigitalauorg/ansible:${ANSIBLE_IMAGE_VERSION}" = "target:ansible"
    }
}
