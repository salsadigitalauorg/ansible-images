target "ansible" {
    contexts = {
        "ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION}" = "target:python-crossbuild"
    }
}

target "ansible-runner" {
    contexts = {
        "ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION}" = "target:python-crossbuild"
        "ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION}" = "target:ansible"
    }
}

target "ansible-runner-php" {
    contexts = {
        "ghcr.io/salsadigitalauorg/ansible-runner:${PYTHON_VERSION}" = "target:ansible-runner"
    }
}

target "awx-resources" {
    contexts = {
        "ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION}" = "target:ansible"
    }
}
