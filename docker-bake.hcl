variable "ANSIBLE_IMAGES_REPO" {
    default = "https://github.com/salsadigitalauorg/ansible-images"
}

variable "IMAGE_REGISTRY" {
    default = "ghcr.io"
}

variable "IMAGE_ORG" {
    default = "salsadigitalauorg"
}

variable "IMAGE_TAG" {
    default = "latest"
}

variable "DEFAULT_PYTHON_VERSION" {
    default = "3.11"
}

variable "PYTHON_VERSION" {
    default = DEFAULT_PYTHON_VERSION
}

variable "ANSIBLE_IMAGE_VERSION" {
    default = "latest"
}

group "default" {
    targets = ["ansible-runner"]
}

target "python-crossbuild" {
    labels = {"org.opencontainers.image.source": "${ANSIBLE_IMAGES_REPO}"}
    dockerfile = "Dockerfile.python-crossbuild"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/python-crossbuild:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/python-crossbuild:${IMAGE_TAG}": "",
    ]
}

target "ansible-images-base" {
    labels = {"org.opencontainers.image.source": "${ANSIBLE_IMAGES_REPO}"}
    platforms = ["linux/amd64", "linux/arm64"]
}

target "ansible" {
    inherits = ["ansible-images-base"]
    dockerfile = "Dockerfile.ansible"
    tags = [
        "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible:${PYTHON_VERSION}",
        equal(DEFAULT_PYTHON_VERSION,PYTHON_VERSION) ? "${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible:${IMAGE_TAG}": "",
    ]
    args = {
        PYTHON_VERSION = "${PYTHON_VERSION}"
    }
}

target "ansible-test" {
    inherits = ["ansible-images-base"]
    dockerfile = "Dockerfile.ansible-test"
    tags = ["${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-test:${IMAGE_TAG}"]
}

target "ansible-runner" {
    inherits = ["ansible-images-base"]
    dockerfile = "Dockerfile.ansible-runner"
    tags = ["${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-runner:${IMAGE_TAG}"]
}

target "awx-resources" {
    inherits = ["ansible-images-base"]
    dockerfile = "Dockerfile.awx-resources"
    tags = ["${IMAGE_REGISTRY}/${IMAGE_ORG}/awx-resources:${IMAGE_TAG}"]
    args = {
        ANSIBLE_IMAGE_VERSION = "${ANSIBLE_IMAGE_VERSION}"
    }
}
