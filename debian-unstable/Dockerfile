FROM debian:testing

RUN apt update && \
    apt install -y \
        git \
        cmake \
        ninja-build \
        kirigami2-dev \
        libkf5notifications-dev \
        libkf5kio-dev \
        kquickimageeditor-dev \
        build-essential \
        extra-cmake-modules \
        qtbase5-dev \
        qttools5-dev \
        qtquickcontrols2-5-dev \
        qtdeclarative5-dev \
        libqt5svg5-dev \
        ccache \
        mesa-common-dev \
        libgl1-mesa-dev \
        libssl-dev \
        appstream \
        qtpositioning5-dev \
        qtlocation5-dev \
        qtmultimedia5-dev \
        clazy \
        doxygen \
        graphviz \
        libqca-qt5-2-dev \
        libgstreamer1.0-dev \
        kirigami-addons-dev \
        libomemo-c-dev \
        libzxing-dev \
 && apt clean

# Build latest QXmpp
RUN git clone https://github.com/qxmpp-project/qxmpp \
 && cd qxmpp \
 && git checkout cbf3209 \
 && cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_OMEMO=ON -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 -DWITH_GSTREAMER=ON \
 && ninja install \
 && cd ../ \
 && rm -rf qxmpp

