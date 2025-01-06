#!/usr/bin/env bash

set -e

PROJECT_DIR=$(cd $(dirname $0) && pwd)

APP_NAME=${APP_NAME:-?}
APP_VERSION=${APP_VERSION:-?}

if [ ! -d "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}" ]; then
  exit 0
fi

if [ -f "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/env" ]; then
  . ${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/env
fi

if [ -f "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/requirements/rpm" ]; then
  yum install -y $(cat ${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/requirements/rpm)
fi

if [ -f "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/requirements/rust" ]; then
  curl -sSf https://sh.rustup.rs | sh -s -- -y
fi

if [ -f "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/scripts/build.sh" ]; then
  bash "${PROJECT_DIR}/${APP_NAME}/${APP_VERSION}/scripts/build.sh"
fi