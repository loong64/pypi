#!/usr/bin/env bash

sed -i 's@"*linux_s390x"@"*linux_s390x", "*linux_loongarch64"@g' pyproject.toml
./scripts/manylinux-build-and-install-openssl.sh