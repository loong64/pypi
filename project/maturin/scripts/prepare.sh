#!/usr/bin/env bash

set -e

commit=c81f1f76679afa29d1a9e4da56390f420b4d61c1
wget -O - "https://github.com/loong64/maturin/commit/${commit}.patch" | patch -p1