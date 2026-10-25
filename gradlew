#!/bin/sh
# Lightweight Gradle launcher for environments where the official wrapper JAR is unavailable.
# Uses the project's pinned Gradle distribution and caches it outside the project.
set -eu
APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
GRADLE_VERSION=8.9
DIST_NAME="gradle-${GRADLE_VERSION}-bin"
USER_HOME_DIR="${GRADLE_USER_HOME:-$HOME/.gradle}"
DIST_DIR="${USER_HOME_DIR}/mr91-wrapper/${DIST_NAME}"
GRADLE_BIN="${DIST_DIR}/gradle-${GRADLE_VERSION}/bin/gradle"
if [ ! -x "$GRADLE_BIN" ]; then
  mkdir -p "${USER_HOME_DIR}/mr91-wrapper"
  ZIP_PATH="${USER_HOME_DIR}/mr91-wrapper/${DIST_NAME}.zip"
  URL="https://services.gradle.org/distributions/${DIST_NAME}.zip"
  if command -v curl >/dev/null 2>&1; then
    curl -fL --retry 3 "$URL" -o "$ZIP_PATH"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$ZIP_PATH" "$URL"
  else
    echo "ERROR: curl or wget is required to download Gradle ${GRADLE_VERSION}." >&2
    exit 1
  fi
  command -v unzip >/dev/null 2>&1 || { echo "ERROR: unzip is required." >&2; exit 1; }
  mkdir -p "$DIST_DIR"
  unzip -q -o "$ZIP_PATH" -d "$DIST_DIR"
fi
exec "$GRADLE_BIN" -p "$APP_HOME" "$@"
