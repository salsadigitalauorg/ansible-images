#!/usr/bin/env bash

set -eu

AWX_VERSION=${AWX_VERSION:-19.4.0}

[ ! -d "awx" ] && git clone https://github.com/ansible/awx.git
cd awx
git checkout -- .
git clean -fd .
git checkout $AWX_VERSION

ansible-playbook tools/ansible/dockerfile.yml \
  --extra-vars tini_architecture=arm64 \
  --extra-vars kubectl_architecture=arm64

if [ -f "../dockerfile-${AWX_VERSION}.patch" ]; then
  patch --normal Dockerfile < ../dockerfile-${AWX_VERSION}.patch
fi
