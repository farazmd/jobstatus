#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Check if dist/ directory exists in root folder
check_dist_directory_exists(){
    [ -d  "${ROOT_PATH}/dist" ]
}

# Check if binary output path exists under dist folder
check_bin_path_exists(){
    local path="${1}"
    [ -n "${path}" ] && [ -d "${path}" ]
}

# Set env variables based on platform
go_set_env_vars_for_platform() {
    local platform="${1}"
    export GOOS=${platform%/*}
    export GOARCH=${platform##*/}
    export BUILD_PLATFORM_PATH=${platform} 
    export BIN_PATH=${BUILD_PATH}/${BUILD_PLATFORM_PATH}/bin
}

# Run go build for a specific platform
go_build_specific_platform() {
    local platform="${1}"
    if [[ "${platform}" =~ "windows" ]]; then
        BINARY_NAME=${APP_NAME}-${GOOS}-${GOARCH}.exe
    else
       BINARY_NAME=${APP_NAME}-${GOOS}-${GOARCH}
    fi

    echo "Building ${APP_NAME} with GOOS: ${GOOS}, GOARCH: ${GOARCH}"
    echo "Output: ${BIN_PATH}/${BINARY_NAME}, BIN: ${ROOT_PATH}/${BINARY}"
    if ! check_bin_path_exists "${BIN_PATH}"; then
        mkdir -p "${BIN_PATH}"
    fi
    # go build -o ${BIN_PATH}/${BINARY_NAME} ${ROOT_PATH}/${BINARY} 
}

# Run go build for all platforms listed either in DEFAULT_PLATFORM_LIST or OVERRIDE_PLATFORM_LIST
go_build_all_platforms() {

    local all_platforms=()

    if [ ! -z "${OVERRIDE_PLATFORM_LIST}" ]; then
        all_platforms+=(${OVERRIDE_PLATFORM_LIST})
    else
        all_platforms+=(${DEFAULT_PLATFORM_LIST})
    fi

    for platform in ${all_platforms[@]}; do
        go_set_env_vars_for_platform ${platform}
        go_build_specific_platform ${platform}
    done
}

if ! check_dist_directory_exists; then
    mkdir -p ${ROOT_PATH}/dist
fi