#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail

SCRIPT_DIR=$(cd -P "$(dirname $0)" && pwd )
IMAGE="ubreu/kpcli"

FOO_KEEPASS_ENTRY="Root/foo"
BAR_KEEPASS_ENTRY="Root/a group/bar"

docker run --rm ${IMAGE}:${VERSION} --help

ACTUAL_PASSWORD=$(docker run --rm -v ${SCRIPT_DIR}/keepass.kdbx:/work/keepass.kdbx -e KEEPASS_PASSWORD=password --entrypoint=/show_password ${IMAGE}:${VERSION} "$FOO_KEEPASS_ENTRY")
[[ $ACTUAL_PASSWORD == "foo password" ]]

ACTUAL_PASSWORD=$(docker run --rm -v ${SCRIPT_DIR}/keepass.kdbx:/work/keepass.kdbx -e KEEPASS_PASSWORD=password --entrypoint=/show_password ${IMAGE}:${VERSION} "$BAR_KEEPASS_ENTRY")
[[ $ACTUAL_PASSWORD == "barpassword" ]]