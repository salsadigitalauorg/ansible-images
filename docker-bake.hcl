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

group "default" {
    targets = ["ansible-runner"]
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
