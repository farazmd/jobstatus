#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset


source $(dirname ${BASH_SOURCE[0]})/init.sh

lint_help(){
    echo -e "$(basename ${0})[-hf]"
    echo -e "Helper script to run golangci-lint. Defaults to \"golangci-lint run\""
    echo -e "\t -h \t Prints this help"
    echo -e "\t -f \t Runs golangci-lint with --fix option"
}
export LINT_OPTS=""

while getopts ":fh" OPTS; do
    case "${OPTS}" in
        h)
            lint_help
            exit 1
            ;;
        f)
            LINT_OPTS="--fix"
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            build_help
            exit 1
            ;;
    esac
done

${GOLANGCI_INSTALL_PATH}/golangci-lint run --config ${ROOT_PATH}/.golangci.yml ${LINT_OPTS}

