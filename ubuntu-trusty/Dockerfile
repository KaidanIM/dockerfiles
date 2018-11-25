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

RUN sudo apt install -y \
        debian-keyring \
        devscripts \
        equivs \
        debhelper \
&&  echo "deb-src http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse" >> /etc/apt/sources.list \
&&  apt-get update \
&&  dget -x http://http.debian.net/debian/pool/main/g/gloox/gloox_1.0.20-2.dsc \
&&  cd gloox-*/ \
&&  sed -i 's/libgnutls28-dev/libgnutls-dev/g' debian/control \
&&  echo "9" > debian/compat \
&&  sudo apt-get build-dep gloox -t trusty-backports -y \
&&  dch --local ~bpo14.04+ --distribution trusty-backports "Rebuild for trusty-backports." \
&&  dpkg-buildpackage -us -uc -d \
&&  cd .. \
&&  sudo dpkg -i libgloox*.deb \
&&  rm -rf *gloox* \
&&  dget -x http://archive.ubuntu.com/ubuntu/pool/universe/q/qxmpp/qxmpp_0.9.3-1build3.dsc \
&&  cd qxmpp-*/ \
&&  echo "9" > debian/compat \
&&  sed -i 's/qtbase5-dev,//g' debian/control \
&&  sudo apt-get build-dep qxmpp -t trusty-backports -y \
&&  dch --local ~bpo14.04+ --distribution trusty-backports "Rebuild for trusty-backports." \
&&  dpkg-buildpackage -us -uc -d \
&&  cd .. \
&&  sudo dpkg -i libqxmpp0*.deb libqxmpp-dev*.deb \
&&  rm -rf *qxmpp* \
&&  apt purge --auto-remove -y \
        debian-keyring \
        devscripts \
        equivs
