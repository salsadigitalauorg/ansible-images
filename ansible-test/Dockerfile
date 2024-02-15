FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:3.8 AS cross_builder_38

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible multidict pytest pytest-forked yarl; \
    rm -rf /cross_venv/cross/lib/python3.8/site-packages/__pycache__; \
    cd /cross_venv/cross/bin && rm -rf __pycache__ activate* python* && cd /; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /cross_venv/cross/bin/*;

FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:3.9 AS cross_builder_39

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible multidict pytest pytest-forked yarl; \
    rm -rf /cross_venv/cross/lib/python3.9/site-packages/__pycache__; \
    cd /cross_venv/cross/bin && rm -rf __pycache__ activate* python* && cd /; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /cross_venv/cross/bin/*;

FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:3.10 AS cross_builder_310

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible multidict pytest pytest-forked yarl; \
    rm -rf /cross_venv/cross/lib/python3.10/site-packages/__pycache__; \
    cd /cross_venv/cross/bin && rm -rf __pycache__ activate* python* && cd /; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /cross_venv/cross/bin/*;

FROM --platform=$BUILDPLATFORM ghcr.io/salsadigitalauorg/python-crossbuild:3.11 AS cross_builder_311

RUN set -eux; \
    . /cross_venv/bin/activate; \
    pip install ansible multidict pytest pytest-forked yarl; \
    rm -rf /cross_venv/cross/lib/python3.11/site-packages/__pycache__; \
    cd /cross_venv/cross/bin && rm -rf __pycache__ activate* python* && cd /; \
    sed -i 's#/cross_venv/cross/bin/python3#/usr/local/bin/python3#' /cross_venv/cross/bin/*;

FROM --platform=$TARGETPLATFORM python:3.8 AS python_38
FROM --platform=$TARGETPLATFORM python:3.9 AS python_39
FROM --platform=$TARGETPLATFORM python:3.10 AS python_310
FROM --platform=$TARGETPLATFORM python:3.11 AS python_311

FROM buildpack-deps:stable

RUN mkdir -p /opt/pythons/3.8 /opt/pythons/3.9 /opt/pythons/3.10

COPY --from=python_38 /usr/local/bin/ /opt/pythons/3.8/bin/
COPY --from=python_38 /usr/local/lib/ /usr/local/lib/
COPY --from=cross_builder_38 /cross_venv/cross/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=cross_builder_38 /cross_venv/cross/bin/ /opt/pythons/3.8/bin/

COPY --from=python_39 /usr/local/bin/ /opt/pythons/3.9/bin/
COPY --from=python_39 /usr/local/lib/ /usr/local/lib/
COPY --from=cross_builder_39 /cross_venv/cross/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=cross_builder_39 /cross_venv/cross/bin/ /opt/pythons/3.9/bin/

COPY --from=python_310 /usr/local/bin/ /opt/pythons/3.10/bin/
COPY --from=python_310 /usr/local/lib/ /usr/local/lib/
COPY --from=cross_builder_310 /cross_venv/cross/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages/
COPY --from=cross_builder_310 /cross_venv/cross/bin/ /opt/pythons/3.10/bin/

COPY --from=python_311 /usr/local/bin/ /opt/pythons/3.11/bin/
COPY --from=python_311 /usr/local/lib/ /usr/local/lib/
COPY --from=cross_builder_311 /cross_venv/cross/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=cross_builder_311 /cross_venv/cross/bin/ /opt/pythons/3.11/bin/

ENV PATH="/opt/pythons/3.8/bin:$PATH"
ENV PATH="/opt/pythons/3.9/bin:$PATH"
ENV PATH="/opt/pythons/3.11/bin:$PATH"
ENV PATH="/opt/pythons/3.10/bin:$PATH"

RUN set -eux; \
    ldconfig; \
    python3.8 --version; \
    python3.9 --version; \
    python3.10 --version; \
    python3.11 --version; \
    ln -s /opt/pythons/3.10/bin/python3 /usr/local/bin/python3; \
    /usr/local/bin/python3 --version;

ENTRYPOINT [ "ansible-test" ]
