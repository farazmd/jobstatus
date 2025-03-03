#!/usr/bin/env bash

# Script to install required external dependencies for project.
# Add required external dependencies here Eg. golangci-lint, cobra-cli.

set -o errexit
set -o pipefail

source $(dirname ${BASH_SOURCE[0]})/init.sh


# Install golangci-lint

echo "Installing golangci-lint: ${GOLANGCI_LINT_VERSION}"
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b ${GOLANGCI_INSTALL_PATH} ${GOLANGCI_LINT_VERSION}