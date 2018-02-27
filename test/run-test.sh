#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail

SCRIPT_DIR=$(cd -P "$(dirname $0)" && pwd )
IMAGE="ubreu/kpcli"
VERSION="latest"

FOO_KEEPASS_ENTRY="Root/foo"
BAR_KEEPASS_ENTRY="Root/a group/bar"

docker run --rm ${IMAGE}:${VERSION} --help

echo "verifying retrieval of ${FOO_KEEPASS_ENTRY}"
ACTUAL_PASSWORD=$(docker run --net=none --rm -v ${SCRIPT_DIR}/keepass.kdbx:/work/keepass.kdbx -e KEEPASS_PASSWORD=password --entrypoint=/show_password ${IMAGE}:${VERSION} "$FOO_KEEPASS_ENTRY")
[[ $ACTUAL_PASSWORD == "foo password" ]]
echo "OK"

echo "verifying retrieval of ${BAR_KEEPASS_ENTRY}"
ACTUAL_PASSWORD=$(docker run --net=none --rm -v ${SCRIPT_DIR}/keepass.kdbx:/work/keepass.kdbx -e KEEPASS_PASSWORD=password --entrypoint=/show_password ${IMAGE}:${VERSION} "$BAR_KEEPASS_ENTRY")
[[ $ACTUAL_PASSWORD == "barpassword" ]]
echo "OK"

echo "verifying that master password can be read from stdin"
ACTUAL_PASSWORD=$(echo "password" | docker run -i --net=none --rm -v ${SCRIPT_DIR}/keepass.kdbx:/work/keepass.kdbx --entrypoint=/show_password ${IMAGE}:${VERSION} "$BAR_KEEPASS_ENTRY")
[[ $ACTUAL_PASSWORD == "barpassword" ]]
echo "OK"