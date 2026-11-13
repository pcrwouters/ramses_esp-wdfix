#!/bin/sh
# Build ramses_esp 0.5.3-wdfix1 with Docker (no ESP-IDF install needed)
set -e
docker run --rm -v "$PWD":/project -w /project espressif/idf:v6.0.3 \
  sh -c "idf.py set-target esp32s3 && idf.py build && idf.py merge-bin -o ramses_esp-0.5.3-wdfix1-merged.bin"
ls -l build/ramses_esp-0.5.3-wdfix1-merged.bin build/ramses_esp.bin 2>/dev/null || ls -l build/*.bin
