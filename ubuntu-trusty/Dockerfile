FROM ubuntu:trusty

RUN sudo apt update && \
    sudo apt-get install software-properties-common dirmngr -y && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    sudo add-apt-repository -y universe \
    sudo add-apt-repository -y ppa:ondrej/apache2

# Qt
ARG QT_VERSION=5.12.0

ENV DEBIAN_FRONTEND=noninteractive \
    QT_PATH=/opt/Qt
ENV QT_DESKTOP $QT_PATH/${QT_VERSION}/gcc_64
ENV PATH $QT_DESKTOP/bin:$PATH

# Install updates & requirements:
#  * git, openssh-client, ca-certificates - clone & build
#  * locales, sudo - useful to set utf-8 locale & sudo usage
#  * curl - to download Qt bundle
#  * build-essential, pkg-config, libgl1-mesa-dev - basic Qt build requirements
#  * libsm6, libice6, libxext6, libxrender1, libfontconfig1, libdbus-1-3 - dependencies of the Qt bundle run-file
RUN apt update && apt full-upgrade -y && apt install -y --no-install-recommends \
    git \
    openssh-client \
    ca-certificates \
    locales \
    sudo \
    curl \
    build-essential \
    pkg-config \
    libgl1-mesa-dev \
    libsm6 \
    libice6 \
    libxext6 \
    libxrender1 \
    libfontconfig1 \
    libdbus-1-3 \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

COPY extract-qt-installer.sh /tmp/qt/

# Download & unpack Qt toolchains & clean
RUN curl -Lo /tmp/qt/installer.run "https://download.qt.io/official_releases/qt/$(echo "${QT_VERSION}" | cut -d. -f 1-2)/${QT_VERSION}/qt-opensource-linux-x64-${QT_VERSION}.run" \
    && QT_CI_PACKAGES=qt.qt5.$(echo "${QT_VERSION}" | tr -d .).gcc_64 /tmp/qt/extract-qt-installer.sh /tmp/qt/installer.run "$QT_PATH" \
    && find "$QT_PATH" -mindepth 1 -maxdepth 1 ! -name "${QT_VERSION}" -exec echo 'Cleaning Qt SDK: {}' \; -exec rm -r '{}' \; \
    && rm -rf /tmp/qt

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# /Qt

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
        git \
        debhelper \
        doxygen \
        graphviz \
        libopus-dev \
        libspeex-dev \
        libtheora-dev \
        libvpx-dev \
 && git clone https://github.com/qxmpp-project/qxmpp \
 && cd qxmpp \
 && cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
 && sudo ninja install \
 && cd ../ \
 && sudo rm -rf qxmpp
