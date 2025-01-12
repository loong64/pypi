#!/usr/bin/env bash

set -e

# disable tests
sed -i 's/"\*linux_s390x"/"\*linux_s390x", "\*linux_loongarch64"/g' pyproject.toml