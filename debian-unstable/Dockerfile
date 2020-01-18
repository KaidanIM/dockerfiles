FROM debian:unstable

RUN apt update && \
    apt install -y \
        cmake \
        ninja-build \
        kirigami2-dev \
        libkf5notifications-dev \
        build-essential \
        extra-cmake-modules \
        qtbase5-dev \
        qt5-default \
        qttools5-dev \
        qtquickcontrols2-5-dev \
        libgloox-dev \
        qtdeclarative5-dev \
        libqt5svg5-dev \
        ccache \
        mesa-common-dev \
        libgl1-mesa-dev \
        libssl-dev \
        appstream \
        libqxmpp-dev \
        qtpositioning5-dev \
        qtlocation5-dev \
        qtmultimedia5-dev \
        clazy

# Build latest QXmpp
RUN apt install -y \
        cmake \
        git \
        debhelper \
        doxygen \
        graphviz \
        libopus-dev \
        libspeex-dev \
        libtheora-dev \
        libvpx-dev \
        qtbase5-dev \
 && git clone https://github.com/qxmpp-project/qxmpp \
 && cd qxmpp \
 && cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
 && ninja install \
 && cd ../ \
 && rm -rf qxmpp

# Build latest ZXing-cpp
RUN git clone https://github.com/nu-book/zxing-cpp \
 && cd zxing-cpp \
 && cmake . -GNinja \
 && ninja install \
 && cd ../ \
 && rm -rf zxing-cpp
