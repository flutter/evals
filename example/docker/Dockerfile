# syntax=docker/dockerfile:1

# Flutter eval sandbox image.
#
# Extends the official Cirrus Labs Flutter image with:
# - System utilities (curl, git, unzip, bash)
# - Pre-warmed pub cache for common Flutter packages
# - Eval fixture apps baked into /fixtures/
#
# The full Dart SDK (including dart analyze, dart test, dart pub) and Flutter
# are provided by the base image. No additional Dart tooling needs to be
# installed.
#
# Build from example/ (not the repo root) so the COPY fixtures/ step works:
#   docker compose -f example/docker/docker-compose.yml build
#   # or, from example/: docker build -f docker/Dockerfile -t dart-evals-flutter .
#
# Smoke-test:
#   docker run --rm dart-evals-flutter flutter --version
FROM ghcr.io/cirruslabs/flutter:stable

# Install system deps useful in eval scripts
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Ensure pub global bin is on PATH
ENV PATH="$PATH:/root/.pub-cache/bin"


# Pre-warm the pub cache with packages commonly used in Flutter evals.
# We create a throw-away project, resolve deps, then delete it.
RUN flutter create --no-pub /tmp/warmup \
    && cd /tmp/warmup \
    && flutter pub add \
    freezed_annotation \
    json_annotation \
    && dart pub global activate build_runner \
    && dart pub global activate freezed \
    && dart pub global activate json_serializable \
    && rm -rf /tmp/warmup

# Copy eval fixture apps into the image so setup scripts can provision them
# without a network call.  Each fixture lives at /fixtures/<app-name>/.
# Build context must be example/ (not the repo root) when using this COPY:
#   docker build -f docker/Dockerfile -t dart-evals-flutter . (run from example/)
COPY fixtures/ /fixtures/

# Pre-create the workspace directories so setUp scripts can copy into them
# without needing to create them first (cp -r target must exist).
RUN mkdir -p /workspace/app

# Default working directory — eval orchestration mounts the app here
WORKDIR /workspace

# Keep the container alive so DockerSandboxEnvironment.exec() can run commands
CMD ["tail", "-f", "/dev/null"]
