ARG PYTHON_VERSION

FROM --platform=$TARGETPLATFORM python:${PYTHON_VERSION} AS target_python

FROM --platform=$BUILDPLATFORM python:${PYTHON_VERSION} AS cross_builder

ARG PYTHON_VERSION

COPY --from=target_python /usr/local/bin/python${PYTHON_VERSION} /usr/local/bin/target_python

ARG TARGETPLATFORM
ARG TARGETARCH

ENV PATH="/root/.cargo/bin:$PATH"

RUN set -eux; \
    \
    # Rust is required for building wheels for certain dependencies (e.g, cryptography).
    curl https://sh.rustup.rs -sSf | sh -s -- -y; \
    \
    cd /; \
    python3 -m pip install crossenv; \
    python3 -m crossenv /usr/local/bin/target_python /cross_venv; \
    . /cross_venv/bin/activate; \
    # The following steps are required otherwise further install fail.
    build-pip install --upgrade pip setuptools wheel; \
    pip install --upgrade pip setuptools wheel;
