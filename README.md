
# openh264-js

This is the openh264 decoder compiled with emscripten so that it can be used to play a annex b prefixed h264 bitstream inspired by [@ttyridal/openh264-js](https://github.com/ttyridal/openh264-js).

To see the outputted frames you'll need to use another library. Here are two possible ways to do that:
- the [ImageData]() like the [example](example/example.html) does
- the [YUVCanvas from broadway js](https://github.com/mbebenita/Broadway/blob/b8f055f5ad709db3c5042cff5938237ac0e1b5d5/Player/YUVCanvas.js)

## Building

Build using the docker compose file:
```
docker compose up
```

## Example

After successfully building the emscripten files run:
```
npm run build
```

The final output files will be in `/dist`