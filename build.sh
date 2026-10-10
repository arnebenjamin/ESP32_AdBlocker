#!/bin/bash
# Build ESP32-S3-N16R8 firmware (16M flash, octal PSRAM, large FS partition).
# Usage: ./build.sh
set -e
cd "$(dirname "$0")"
FQBN="esp32:esp32:esp32s3-octal:CDCOnBoot=cdc,FlashMode=qio,FlashSize=16M"
FQBN="${FQBN},PSRAM=opi,PartitionScheme=no_ota"
mkdir -p build
# NOTE: -e/--export-binaries is a boolean flag that exports into the sketch folder (no path arg).
arduino-cli compile . --fqbn "$FQBN" -e
# -e exports into build/<platform>/ in this arduino-cli version:
BIN=$(find build -name "ESP32_AdBlocker.ino.bin" | head -1)
if [ -n "$BIN" ]; then
  cp "$BIN" build/ESP32_AdBlocker.bin
fi
echo "Done:"
ls -lh build/*.bin
