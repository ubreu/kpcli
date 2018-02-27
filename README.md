# kpcli

This docker image provides the kpcli executable as well as a helper script for retrieving passwords from Keepass files.

## Running kpcli

Running kpcli with a mounted Keepass file:

    docker run -it --net=none --rm -v keepass.kdbx:/work/keepass.kdbx ubreu/kpcli --kdb=keepass.kdbx

## Retrieving a password via script

Running the show_password script with a mounted Keepass file to show the password for the entry named *my-keepass-entry* in the *Root* folder:

    docker run --net=none --rm -v /keepass.kdbx:/work/keepass.kdbx -e KEEPASS_PASSWORD=password --entrypoint=/show_password ubreu/kpcli "/Root/my-keepass-entry"
