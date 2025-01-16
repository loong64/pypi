#!/usr/bin/env bash

set -e

commit=bd33565a45aad30903eed9d825c82770d94fb639
wget -O - "https://github.com/loong64/maturin/commit/${commit}.patch" | patch -p1