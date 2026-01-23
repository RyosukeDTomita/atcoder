# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/base:trixie
WORKDIR /workspace

# install dependencies for nix (will be installed in postCreateCommand)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt-get update && \
  apt-get install -y curl xz-utils ca-certificates direnv

# enable nix in PATH
ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"
