#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
APP_NAME=${APP_NAME:?}
APP_VERSION=${APP_VERSION:?}

get_config_path() {
    local file=$1
    local version_path="${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/${file}"
    local default_path="${PROJECT_DIR}/project/${APP_NAME}/${file}"
    
    if [ -f "$version_path" ]; then
        echo "$version_path"
    elif [ -f "$default_path" ]; then
        echo "$default_path"
    fi
}

rpm_file=$(get_config_path "requirements/rpm")
if [ -f "$rpm_file" ]; then
    yum install -y $(cat "$rpm_file")
fi

rust_file=$(get_config_path "requirements/rust")
if [ -f "$rust_file" ]; then
    curl -sSf https://sh.rustup.rs | sh -s -- -y
fi

build_script=$(get_config_path "scripts/build.sh")
if [ -f "$build_script" ]; then
    bash "$build_script"
fi