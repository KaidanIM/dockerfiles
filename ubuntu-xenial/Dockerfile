FROM ubuntu:xenial

# Add PPAs
RUN apt update && \
    apt-get install software-properties-common dirmngr -y && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test

# Install Qt
ARG QT_VERSION=5.12.5

ENV DEBIAN_FRONTEND=noninteractive \
    QT_PATH=/opt/Qt
ENV QT_DESKTOP $QT_PATH/${QT_VERSION}/gcc_64
ENV PATH $QT_DESKTOP/bin:$PATH

# Install updates & requirements:
#  * git, openssh-client, ca-certificates - clone & build
#  * locales, - useful to set utf-8 locale & usage
#  * curl - to download Qt bundle
#  * build-essential, pkg-config, libgl1-mesa-dev - basic Qt build requirements
#  * libsm6, libice6, libxext6, libxrender1, libfontconfig1, libdbus-1-3 - dependencies of the Qt bundle run-file
RUN apt update && apt full-upgrade -y && apt install -y --no-install-recommends \
    git \
    openssh-client \
    ca-certificates \
    locales \
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
    gcc-8 g++-8 \
    libgstreamer-plugins-base1.0-0 \
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

RUN apt-get update && \
    apt-get install -y \
                         wget \
                         git \
                         pkg-config \
                         cmake \
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
                         libtheora-dev \
                         libssl-dev \
                         libxi6 \
                         libegl1-mesa \
                         libpq5 \
                         libdbus-1-3 \
                         mysql-common \
                         libmysqlclient20 \
                         libxkbcommon-x11-0 \
                         libpulse-mainloop-glib0 \
                         libodbc1 \
&&  apt-get clean

ENV KF5_DIR=/opt/kf5
ENV LD_LIBRARY_PATH=$KF5_DIR/lib/x86_64-linux-gnu:$KF5_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$KF5_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV PATH=$KF5_DIR/bin:/var/opt/kdesrcbuild:$PATH

ENV QT_LINUX=$QT_DESKTOP

# Update CMAKE
RUN wget https://cmake.org/files/v3.13/cmake-3.13.3-Linux-x86_64.tar.gz -O- | tar xz -C /usr --strip-components=1

# Install kdesrc-build dependencies
RUN apt install -y libio-socket-ssl-perl libyaml-libyaml-perl gperf bzr libxrender-dev libxcb-keysyms1-dev libxcb-icccm4-dev doxygen git libopus-dev libspeex-dev libtheora-dev libvpx-dev libasound2 libxcb-res0-dev

# Install KF5
COPY kdesrc-buildrc /root/.kdesrc-buildrc
RUN git clone git://anongit.kde.org/kdesrc-build /var/opt/kdesrcbuild && \
    kdesrc-build --include-dependencies kirigami knotifications zxing-cpp qxmpp --verbose && \
    rm -rf ~/kde-src/
