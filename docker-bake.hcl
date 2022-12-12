variable "ANSIBLE_IMAGES_REPO" {
    default = "https://github.com/salsadigitalauorg/ansible-images"
}

variable "IMAGE_REGISTRY" {
    default = "ghcr.io"
}

variable "IMAGE_ORG" {
    default = "salsadigitalauorg"
}

variable "DEFAULT_PYTHON_VERSION" {
    default = "3.10"
}

variable "PYTHON_VERSION" {
    default = DEFAULT_PYTHON_VERSION
}

group "default" {
    targets = ["ansible-runner"]
}

target "python-crossbuild" {
    labels = {"org.opencontainers.image.source": "${ANSIBLE_IMAGES_REPO}"}
    context = "python-crossbuild"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/python-crossbuild:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/python-crossbuild:latest": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}

target "ansible-images-base" {
    labels = {"org.opencontainers.image.source": "${ANSIBLE_IMAGES_REPO}"}
    platforms = ["linux/amd64", "linux/arm64"]
}

target "ansible" {
    inherits = ["ansible-images-base"]
    context = "ansible"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible:latest": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}

target "ansible-test" {
    inherits = ["ansible-images-base"]
    context = "ansible-test"
    tags = ["${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-test:latest"]
}

target "ansible-runner" {
    inherits = ["ansible-images-base"]
    context = "ansible-runner"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-runner:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-runner:latest": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}

target "ansible-runner-php" {
    inherits = ["ansible-images-base"]
    context = "ansible-runner-php"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-runner-php:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-runner-php:latest": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}

target "awx-resources" {
    inherits = ["ansible-images-base"]
    context = "awx-resources"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/awx-resources:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/awx-resources:latest": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}
