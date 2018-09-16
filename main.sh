#!/usr/bin/env bash

set -x

# Keep track of the script path
TOP_PATH=$(cd $(dirname "$0") && pwd)

${TOP_PATH}/entry.sh 2>&1 | tee /var/log/make-local-repo.log
