# Builder
FROM debian:testing-slim

RUN apt update && apt install ca-certificates software-properties-common gpg -y && \
    echo "deb https://dl.mumble.info/mirror/mirror.mxe.cc/repos/apt stretch main" >> /etc/apt/sources.list && \
    apt-key adv  --keyserver keyserver.ubuntu.com --recv C6BF758A33A3A276 && apt update && \
    apt install mxe-x86-64-w64-mingw32.static-qtbase mxe-x86-64-w64-mingw32.static-qtdeclarative mxe-x86-64-w64-mingw32.static-qtquickcontrols2 mxe-x86-64-w64-mingw32.static-quazip mxe-x86-64-w64-mingw32.static-poppler mxe-x86-64-w64-mingw32.static-qtscript mxe-x86-64-w64-mingw32.static-qtsvg extra-cmake-modules mxe-x86-64-w64-mingw32.static-qtgraphicaleffects inkscape optipng mxe-x86-64-w64-mingw32.static-qttools icoutils mxe-x86-64-w64-mingw32.static-gcc -y

# Update ECM
RUN git clone https://anongit.kde.org/extra-cmake-modules && cd extra-cmake-modules && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr . && make install

# Workaround for broken symlinks
RUN rm /usr/lib/mxe/usr/x86_64-pc-linux-gnu/bin/x86_64-w64* && for tool in /usr/lib/mxe/usr/bin/*; do ln -s $tool /usr/lib/mxe/usr/x86_64-pc-linux-gnu/bin/; done


ENV MXE_ROOT=/usr/lib/mxe/
ENV MXE_TARGET=x86_64-w64-mingw32.static
ENV PATH=$MXE_ROOT/usr/$MXE_TARGET/bin:$PATH
