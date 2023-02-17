ARG PYTHON_VERSION

FROM ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION}

RUN set -eux; \
    pip install awxkit; \
    ansible-galaxy collection install ansible.utils awx.awx;

COPY playbooks /playbooks
