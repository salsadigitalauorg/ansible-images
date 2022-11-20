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

group "default" {
    targets = ["ansible-test"]
}

target "ansible-images-base" {
    labels = {"org.opencontainers.image.source": "${ANSIBLE_IMAGES_REPO}"}
    platforms = ["linux/amd64", "linux/arm64"]
}

target "ansible-test" {
    inherits = ["ansible-images-base"]
    dockerfile = "Dockerfile.ansible-test"
    tags = ["${IMAGE_REGISTRY}/${IMAGE_ORG}/ansible-test:${IMAGE_TAG}"]
}
