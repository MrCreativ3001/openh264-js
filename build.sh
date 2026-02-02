#!/bin/sh
set -e

# Set up Emscripten environment
cd /emscripten
. /emscripten/emsdk_env.sh

# Build openh264
cd /openh264

emmake make OS=linux ARCH=asmjs libraries

emcc /bindings/decoder.cpp /bindings/thread.cpp /openh264/*.a \
    -o /build/decoder.js \
    -s MODULARIZE=1 \
    -s EXPORT_ES6=1 \
    -s ENVIRONMENT=web,worker \
    -s SINGLE_FILE=1 \
    -s ALLOW_MEMORY_GROWTH \
    -s EXPORTED_FUNCTIONS="['_malloc','_free','_openh264_decoder_create','_openh264_decoder_decode','_openh264_decoder_destroy']" \
    -s EXPORTED_RUNTIME_METHODS="['stackAlloc','stackSave','stackRestore','setValue','getValue','writeArrayToMemory','HEAPU8','HEAPU32']" \
    --emit-tsd /build/decoder.d.ts

echo "openh264 build successful"