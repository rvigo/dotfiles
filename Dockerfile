FROM ubuntu:latest

ARG CI=1
ARG HOMEBREW_NO_INSTALL_CLEANUP=1
ARG HOMEBREW_NO_ENV_HINTS=1
ARG HOMEBREW_NO_AUTO_UPDATE=1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    git\
    curl\
    ca-certificates\
    zip\
    unzip

COPY . /root/.dotfiles/

WORKDIR /root/.dotfiles
RUN chmod +x install.sh && \
    ./install.sh
