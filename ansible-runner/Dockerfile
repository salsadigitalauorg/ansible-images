ARG PYTHON_VERSION

FROM --platform=$TARGETPLATFORM ghcr.io/salsadigitalauorg/ansible:${PYTHON_VERSION} AS built_ansible

FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:${PYTHON_VERSION} AS cross_builder

ARG PYTHON_VERSION

COPY --from=built_ansible /usr/local/lib/python${PYTHON_VERSION}/site-packages/ /cross_venv/cross/lib/python${PYTHON_VERSION}/site-packages/
COPY --from=built_ansible /usr/local/bin/ansible* /cross_venv/cross/bin/

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible-runner bindep; \
    rm -rf /cross_venv/cross/lib/python${PYTHON_VERSION}/site-packages/__pycache__; \
    cd /cross_venv/cross/bin && rm -rf __pycache__ activate* python* && cd /; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /cross_venv/cross/bin/*;

FROM --platform=$TARGETPLATFORM python:${PYTHON_VERSION}

ARG PYTHON_VERSION

COPY --from=cross_builder /cross_venv/cross/lib/python${PYTHON_VERSION}/site-packages/ /usr/local/lib/python${PYTHON_VERSION}/site-packages/
COPY --from=cross_builder /cross_venv/cross/bin/ /usr/local/bin/

COPY --from=quay.io/ansible/ansible-runner:latest /bin/entrypoint /bin/entrypoint

RUN set -eux; \
    apt-get update && apt-get install -y \
        dumb-init \
        git git-lfs \
        jq \
        rsync \
        zip unzip; \
    rm -rf /var/lib/apt/lists/*;

# In Kubernetes, container will run as a random uid number and gid 0. Make sure things
# are writeable by the root group.
RUN for dir in \
    /home/runner \
    /home/runner/.ansible \
    /home/runner/.ansible/tmp \
    /runner \
    /home/runner \
    /runner/env \
    /runner/inventory \
    /runner/project \
    /runner/artifacts ; \
    do mkdir -m 0775 -p $dir ; chmod -R g+rwx $dir ; chgrp -R root $dir ; done && \
    for file in \
    /home/runner/.ansible/galaxy_token \
    /etc/passwd \
    /etc/group ; \
    do touch $file ; chmod g+rw $file ; chgrp root $file ; done

WORKDIR /runner

ENV HOME=/home/runner

ENTRYPOINT ["entrypoint"]
CMD ["ansible-runner", "run", "/runner"]
