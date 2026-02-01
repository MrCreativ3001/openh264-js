#!/bin/sh
set -e

# Set up Emscripten environment
cd /emscripten
. /emscripten/emsdk_env.sh

sleep infinity

# Build openh264
cd /openh264

emmake make OS=linux ARCH=x86_64

emcc /build/.libs/openh264.a \
    -o openh264.js \
    -s MODULARIZE=1 \
    -s EXPORT_ES6=1 \
    -s ENVIRONMENT=web \
    -s SINGLE_FILE=1 \
    -s EXPORTED_FUNCTIONS="['_malloc','_free','_opus_multistream_decoder_create','_opus_multistream_decode_float','_opus_multistream_decoder_destroy']" \
    -s EXPORTED_RUNTIME_METHODS="['stackAlloc','stackSave','stackRestore','setValue','getValue','writeArrayToMemory','HEAPU8','HEAPF32']" \
    --emit-tsd openh264.d.ts

echo "openh264 build successful"