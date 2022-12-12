# ansible-runner-php

When running locally, you can simply build for your platform:
```sh
# For arm64 only.
docker buildx bake ansible-runner-php --progress=plain --set "*.platform=linux/arm64" --print
docker buildx bake ansible-runner-php --progress=plain --set "*.platform=linux/arm64" --load

# For amd64 only.
docker buildx bake ansible-runner-php --progress=plain --set "*.platform=linux/amd64" --print
docker buildx bake ansible-runner-php --progress=plain --set "*.platform=linux/amd64" --load
```

An EE image can be built by creating a Dockerfile as you would:
```Dockerfile
FROM ghcr.io/salsadigitalauorg/ansible-runner-php:latest

ADD bindep.txt requirements.txt requirements.yml /build/

RUN bindep -f /build/bindep.txt && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install -r /build/requirements.txt \
    && ansible-galaxy role install -r /build/requirements.yml --roles-path /usr/share/ansible/roles \
    && ansible-galaxy collection install -r /build/requirements.yml --collections-path /usr/share/ansible/collections

RUN install-php-extensions @composer

ENV COMPOSER_ALLOW_SUPERUSER=1
```
