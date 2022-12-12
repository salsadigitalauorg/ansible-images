ARG PYTHON_VERSION

FROM ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION}

RUN set -eux; \
    pip install awxkit; \
    ansible-galaxy collection install awx.awx;

COPY awx-resources /playbooks
