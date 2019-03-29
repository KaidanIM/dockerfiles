# Builder
FROM debian:testing-slim

RUN apt update && apt install ca-certificates software-properties-common gpg -y && \
    echo "deb https://dl.mumble.info/mirror/mirror.mxe.cc/repos/apt stretch main" >> /etc/apt/sources.list && \
    apt-key adv  --keyserver keyserver.ubuntu.com --recv C6BF758A33A3A276 && apt update && \
    apt install mxe-x86-64-w64-mingw32.static-qtbase mxe-x86-64-w64-mingw32.static-qtdeclarative mxe-x86-64-w64-mingw32.static-qtquickcontrols2 mxe-x86-64-w64-mingw32.static-quazip mxe-x86-64-w64-mingw32.static-poppler mxe-x86-64-w64-mingw32.static-qtscript mxe-x86-64-w64-mingw32.static-qtsvg extra-cmake-modules mxe-x86-64-w64-mingw32.static-qtgraphicaleffects inkscape optipng -y

RUN apt install mxe-x86-64-w64-mingw32.static-qttools -y

ENV MXE_ROOT=/usr/lib/mxe/
ENV MXE_TARGET=x86_64-w64-mingw32.static
ENV PATH=$MXE_ROOT/usr/$MXE_TARGET/bin:$PATH
