#!/bin/sh
##############################################################################

ROOT_DIR=$( dirname "$( dirname "$( readlink -f "${0}" )" )" )
CODE_DIR="${ROOT_DIR}/.vscode"
REMOTE_DIR='/workspace/.vscode-remote/data/Machine'

mkdir -p "${REMOTE_DIR}"
cp "${CODE_DIR}/settings.json" "${REMOTE_DIR}/settings.json"
