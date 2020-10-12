#------------------------------------------------------
FROM debian:stretch-slim as build

ENV HOME=/bitcoin
WORKDIR ${HOME}

RUN apt-get update
RUN apt-get -yyq install curl gpg
RUN gpg --recv-keys --keyserver keyserver.ubuntu.com 01EA5486DE18A882D4C2684590C8019E36C2E964

ARG VERSION=0.17.1

ENV ARCHIVE_NAME=bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz
ENV ARCHIVE_PATH=https://bitcoincore.org/bin/bitcoin-core-${VERSION}/${ARCHIVE_NAME}
ENV SHA256SUMS_PATH=https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS.asc

RUN curl -O ${ARCHIVE_PATH}
RUN curl -O ${SHA256SUMS_PATH}

RUN sha256sum --ignore-missing --check SHA256SUMS.asc
RUN gpg --verify SHA256SUMS.asc

RUN tar xvzf ${ARCHIVE_NAME}
RUN mv bitcoin-${VERSION} bitcoin

#------------------------------------------------------
FROM debian:stretch-slim as run

ENV HOME=/bitcoin
WORKDIR ${HOME}
COPY --from=build ${HOME}/bitcoin/bin/bitcoind ${HOME}
COPY --from=build ${HOME}/bitcoin/bin/bitcoin-cli ${HOME}

EXPOSE 8333

ENTRYPOINT ${HOME}/bitcoind

