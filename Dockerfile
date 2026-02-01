FROM debian:bookworm-slim

VOLUME /openh264
VOLUME /bindings
VOLUME /build

RUN apt-get update && \
    apt-get install -y python3 git xz-utils curl autoconf automake libtool gcc make nasm && \
    git clone https://github.com/emscripten-core/emsdk.git /emscripten

WORKDIR /emscripten

RUN ./emsdk install releases-e44d3cc557d78155966478aa2bd8dec657609619-64bit node-22.16.0-64bit && \
    ./emsdk activate releases-e44d3cc557d78155966478aa2bd8dec657609619-64bit node-22.16.0-64bit && \
    . ./emsdk_env.sh && \
    npm i typescript -g

COPY build.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]