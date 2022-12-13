ARG PYTHON_VERSION

FROM ghcr.io/salsadigitalauorg/ansible-runner:latest

COPY --from=quay.io/ansible/receptor:devel /usr/bin/receptor /usr/bin/receptor
COPY --from=quay.io/ansible/awx-ee:latest /run.sh /run.sh

RUN set -eux; \
    mkdir -p /var/run/receptor; \
    git lfs install;

CMD /run.sh
USER 1000
LABEL ansible-execution-environment=true
