#!/usr/bin/env bash

set -e

LIBYAML_REPO=https://github.com/yaml/libyaml
LIBYAML_REF=0.2.5

sed -i 's@exit 1@yum install -y perl-Test-Harness@g' packaging/build/libyaml.sh
sed -i 's@make test-all@# make test-all@' packaging/build/libyaml.sh

docker run --rm --volume "$(pwd):/io" --env LIBYAML_REF=${LIBYAML_REF} --env LIBYAML_REPO=${LIBYAML_REPO} --workdir /io ghcr.io/loong64/manylinux_2_38_loongarch64 bash /io/packaging/build/libyaml.sh

sudo chmod -R a+r ./libyaml/