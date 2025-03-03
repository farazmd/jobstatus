#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export ROOT_PATH=$(cd $(dirname ${BASH_SOURCE[0]})/../.. && pwd -P)
export BUILD_PATH=${ROOT_PATH}/dist
export OVERRIDE_PLATFORM_LIST=""
export APP_NAME="jobstatus"
export BINARY="cmd/jobstatus/main.go"
export CGO_ENABLED=0
export GOLANGCI_LINT_VERSION=v1.63.4
export GOLANGCI_INSTALL_PATH=$(go env GOPATH)/bin

DEFAULT_PLATFORM_LIST="linux/amd64 linux/arm64 darwin/arm64 darwin/amd64 windows/amd64 linux/arm linux/386"

