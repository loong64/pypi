#!/usr/bin/env bash

set -e

PROJECT_DIR=$(cd $(dirname $0) && pwd)

APP_NAME=${APP_NAME:-?}
APP_VERSION=${APP_VERSION:-?}

if [ -f "${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/requirements/rpm" ]; then
  yum install -y $(cat ${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/requirements/rpm)
fi

if [ -f "${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/requirements/rust" ]; then
  curl -sSf https://sh.rustup.rs | sh -s -- -y
fi

if [ -f "${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/ccache" ]; then
  yum install -y ccache
fi

if [ -f "${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/scripts/build.sh" ]; then
  bash "${PROJECT_DIR}/project/${APP_NAME}/${APP_VERSION}/scripts/build.sh"
fi