#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

build_help(){
    echo -e "$(basename ${0}) [-h] [ -t <targets> ]"
    echo -e "\t-h \t Prints this help"
    echo -e "\t-t \t A target platform or a set of target platforms to build. (Space demilited) \t Optional"
    echo -e "Eg:\n\tbuild.sh \t\t\t\t\t Will build for all platforms listed in DEFAULT_PLATFORM_LIST or OVERRIDE_PLATFORM_LIST"
    echo -e "\tbuild.sh -t \"darwin/arm64 darwin/amd64\" \t Will build only darwin arm64 and amd64 versions"
}

source $(dirname ${BASH_SOURCE[0]})/init.sh

while getopts ":t:h" OPTS; do
    case "${OPTS}" in
        h)
            build_help
            exit 0
            ;;
        t)
            export OVERRIDE_PLATFORM_LIST="${OPTARG}"
            ;;
        :)
            echo "Option -${OPTARG} requires an argument"
            build_help
            exit 1
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            build_help
            exit 1
            ;;
    esac
done

source $(dirname ${BASH_SOURCE[0]})/build_helper.sh

go_build_all_platforms