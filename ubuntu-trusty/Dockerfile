FROM ubuntu:trusty

# Add PPAs
RUN sudo apt update && \
    sudo apt-get install software-properties-common dirmngr -y && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/nginx

# Install Qt
ARG QT_VERSION=5.12.2

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
                         libtheora-dev \
                         libssl-dev \
                         libxi6 \
                         libegl1-mesa \
                         libpq5 \
                         libdbus-1-3 \
                         mysql-common \
                         libmysqlclient18 \
                         libxkbcommon-x11-0 \
&&  sudo apt-get clean

ENV KF5_DIR=/opt/kf5
ENV LD_LIBRARY_PATH=$KF5_DIR/lib/x86_64-linux-gnu:$KF5_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$KF5_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV PATH=$KF5_DIR/bin:/var/opt/kdesrcbuild:$PATH

ENV QT_LINUX=$QT_DESKTOP

# Update dbus
RUN wget http://security.ubuntu.com/ubuntu/pool/main/d/dbus/libdbus-1-3_1.10.6-1ubuntu3.1_amd64.deb \
    http://de.archive.ubuntu.com/ubuntu/pool/main/s/systemd/libsystemd0_229-4ubuntu21.21_amd64.deb \
    http://de.archive.ubuntu.com/ubuntu/pool/main/libg/libgcrypt20/libgcrypt20_1.6.5-2ubuntu0.5_amd64.deb \
    http://de.archive.ubuntu.com/ubuntu/pool/main/libg/libgpg-error/libgpg-error0_1.21-2ubuntu1_amd64.deb \
    http://de.archive.ubuntu.com/ubuntu/pool/main/u/unixodbc/libodbc1_2.3.1-4.1_amd64.deb \
    http://archive.ubuntu.com/ubuntu/pool/main/libt/libtool/libltdl7_2.4.6-0.1_amd64.deb \
    http://security.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.6.1-0.1ubuntu2.3_amd64.deb && \
    dpkg -i libgpg-error0_1.21-2ubuntu1_amd64.deb libgcrypt20_1.6.5-2ubuntu0.5_amd64.deb && \
    dpkg -i *.deb && \
    rm *.deb && apt install -f -y

# Update CMAKE
RUN wget https://cmake.org/files/v3.13/cmake-3.13.3-Linux-x86_64.tar.gz -O- | sudo tar xz -C /usr --strip-components=1

# Install kdesrc-build dependencies
RUN apt install libio-socket-ssl-perl libyaml-libyaml-perl gperf -y

# Install KF5
RUN git clone git://anongit.kde.org/kdesrc-build /var/opt/kdesrcbuild
COPY kdesrc-buildrc /root/.kdesrc-buildrc
RUN kdesrc-build --include-dependencies kirigami --verbose && rm -rf ~/kde-src/ /var/opt/kdesrcbuild/

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
