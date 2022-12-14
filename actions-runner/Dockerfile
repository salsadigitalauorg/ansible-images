ARG RUNNER_VERSION=2.299.1

FROM ghcr.io/actions/actions-runner:${RUNNER_VERSION} AS runner

FROM ghcr.io/salsadigitalauorg/ansible:latest

ARG RUNNER_VERSION
ARG RUNNER_RELEASE_HASH=debe1cc9656963000a4fbdbb004f475ace5b84360ace2f7a191c1ccca6a16c00

RUN set -eux;\
    mkdir /actions-runner && cd /actions-runner; \
    chown 1000:1000 /actions-runner;

USER 1000

WORKDIR /actions-runner

RUN set -eux;\
    curl -o actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz \
        -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz; \
    echo "${RUNNER_RELEASE_HASH}  actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c; \
    tar xzf actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz; \
    rm actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz;

COPY --from=runner /actions-runner/k8s /actions-runner/k8s

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
