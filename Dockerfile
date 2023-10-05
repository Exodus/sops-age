#syntax=docker/dockerfile:1
FROM ubuntu:22.04 as sops-age

# Github release variables.
# sops is distributed in it's executable binary.
# age is in a gz tarball
ARG SOPS_VERSION=v3.8.0
ARG SOPS_ARCH=linux.amd64
ARG AGE_VERSION=v1.1.1
ARG AGE_ARCH=linux-amd64

WORKDIR /app

RUN apt update && apt install -y curl

RUN <<EOT
    curl -L -o sops https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.${SOPS_ARCH} &&
    chmod +x sops
EOT

RUN <<EOT
    curl -L -o age.tar.gz https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-${AGE_ARCH}.tar.gz &&
    tar xzf age.tar.gz --strip-components=1 age/age
EOT
