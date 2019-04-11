FROM debian:stretch-slim as build

ARG VERSION=0.17.1

ENV ARCHIVE_NAME=bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz
ENV HOME=/bitcoin

WORKDIR ${HOME}

COPY ${ARCHIVE_NAME} .

RUN tar xvzf ${ARCHIVE_NAME}
RUN mv bitcoin-${VERSION} bitcoin

#----------------------------------
FROM debian:stretch-slim as run

ENV HOME=/bitcoin
WORKDIR ${HOME}
COPY --from=build ${HOME}/bitcoin/bin/bitcoind ${HOME}
COPY --from=build ${HOME}/bitcoin/bin/bitcoin-cli ${HOME}

EXPOSE 8333

ENTRYPOINT ${HOME}/bitcoind

