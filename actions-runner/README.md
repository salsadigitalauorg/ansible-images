# Github actions self-hosted runner

> This runner is intended to be hosted on an arm64 machine to allow faster
> single arch arm64 builds.


Get a token from https://github.com/salsadigitalauorg/ansible-images/settings/actions/runners/new.

Set up an env var with the token:
```sh
export RUNNER_TOKEN=the-token-you-got-from-github
```

Start the runner:
```sh
docker-compose up -d
```
