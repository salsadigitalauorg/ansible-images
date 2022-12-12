ARG PYTHON_VERSION

FROM ghcr.io/salsadigitalauorg/ansible-runner:${PYTHON_VERSION}

RUN set -eux; \
    curl -sSL https://packages.sury.org/php/README.txt | bash -x; \
    apt-get update && apt-get install -y \
        php8.1-cli \
        php8.1-gd \
        php8.1-zip; \
    rm -rf /var/lib/apt/lists/*;
