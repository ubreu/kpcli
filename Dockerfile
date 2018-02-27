FROM debian:stretch-backports
LABEL creator="ubreu@gleisdrei.ch"

ENV KPCLI_VERSION 3.1-3

RUN apt-get update && apt-get install -y --no-install-recommends \
      kpcli=${KPCLI_VERSION} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY show_password /show_password

WORKDIR /work
VOLUME /work

ENTRYPOINT ["/usr/bin/kpcli"]