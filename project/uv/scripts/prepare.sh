#!/usr/bin/env bash

set -e

# uv >= 0.5.15
# commit=2b430111222cd3645c37ae485edec0ce361bab81

# uv >= 0.5.19
commit=99b2d26dc45993edcebed5b124bc02f764cbca50
wget -O - "https://github.com/loong64/uv/commit/${commit}.patch" | patch -p1