target "ansible" {
    contexts = {
        "ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION}" = "target:python-crossbuild"
    }
}

target "ansible-test" {
    contexts = {
        "ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION}" = "target:python-crossbuild"
    }
}

target "awx-resources" {
    contexts = {
        "ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION}" = "target:ansible"
    }
}
