FROM debian:bookworm-slim

VOLUME /openh264
VOLUME /build

RUN apt-get update && \
    apt-get install -y python3 git xz-utils curl autoconf automake libtool gcc make && \
    git clone https://github.com/emscripten-core/emsdk.git /emscripten

WORKDIR /emscripten

RUN ./emsdk install latest && \
    ./emsdk activate latest && \
    . ./emsdk_env.sh && \
    npm i typescript -g

COPY build.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]