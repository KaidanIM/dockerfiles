FROM kdeneon/plasma:dev-unstable

RUN sudo apt update \
&&  sudo apt install -y \
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
        clazy \
        clang \
        qtdeclarative5-dev-tools \
        qtmultimedia5-dev

# Build latest QXmpp
RUN sudo apt install -y \
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
 && sudo ninja install \
 && cd ../ \
 && sudo rm -rf qxmpp

# Build latest ZXing-cpp
RUN git clone https://github.com/nu-book/zxing-cpp \
 && cd zxing-cpp \
 && cmake . -GNinja \
 && sudo ninja install \
 && cd ../ \
 && sudo rm -rf zxing-cpp
