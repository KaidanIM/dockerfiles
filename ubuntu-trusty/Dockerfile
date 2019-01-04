FROM ubuntu:trusty

RUN sudo apt update && \
    sudo apt-get install software-properties-common dirmngr -y && \
    sudo add-apt-repository -y ppa:beineri/opt-qt-5.10.1-trusty && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    sudo add-apt-repository -y universe

RUN sudo apt-get update && \
    sudo apt-get install -y -t trusty-backports \
                         wget \
                         git \
                         pkg-config \
                         cmake3 \
                         ccache \
                         build-essential \
                         ninja-build \
                         zlib1g-dev \
                         qt510base \
                         qt510script \
                         qt510declarative \
                         qt510tools \
                         qt510x11extras \
                         qt510svg \
                         qt510quickcontrols2 \
                         qt510graphicaleffects \
                         mesa-common-dev \
                         libgl1-mesa-dev \
                         libssl-dev \
                         libopus-dev \
                         libvpx-dev \
                         libspeex-dev \
                         libtheora-dev

RUN wget -c "https://github.com/kf5builds/precompiled-kf5-linux/releases/download/kf5.52/kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz" && \
    mkdir /tmp/kf5 && \
    tar xf kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz -C /tmp/kf5 && \
    sudo cp -rf /tmp/kf5/* /opt/qt*/

ENV QT_BASE_DIR=/opt/qt510
ENV QTDIR=$QT_BASE_DIR
ENV PATH=$QT_BASE_DIR/bin:$PATH

ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

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
