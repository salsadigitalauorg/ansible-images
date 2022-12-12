ARG PYTHON_VERSION

FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION} AS cross_builder

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible; \
    mkdir /ansible-bins; \
    cp /cross_venv/cross/bin/ansible* /ansible-bins/; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /ansible-bins/*;

FROM --platform=$TARGETPLATFORM python:${PYTHON_VERSION}

ARG PYTHON_VERSION

COPY --from=cross_builder /cross_venv/cross/lib/python${PYTHON_VERSION}/site-packages/ /usr/local/lib/python${PYTHON_VERSION}/site-packages/
COPY --from=cross_builder /ansible-bins/ /usr/local/bin/

RUN mkdir /playbooks

WORKDIR /playbooks

ENTRYPOINT [ "ansible-playbook" ]
