FROM ubuntu:trusty

RUN sudo apt update && \
    sudo apt-get install software-properties-common dirmngr -y && \
    sudo add-apt-repository -y ppa:beineri/opt-qt-5.10.1-trusty && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    sudo add-apt-repository -y universe

RUN sudo apt-get update && \
    sudo apt-get install -y -t trusty-backports \
                         wget \
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
                         mesa-common-dev \
                         libgl1-mesa-dev \
                         libssl-dev \
                         libqxmpp-dev \
                         fuse

RUN wget -c "https://github.com/kf5builds/precompiled-kf5-linux/releases/download/kf5.50/kf5-5.50.0-Release-ubuntu-trusty-amd64.tar.xz" && \
    mkdir /tmp/kf5 && \
    tar xf kf5-5.50.0-Release-ubuntu-trusty-amd64.tar.xz -C /tmp/kf5 && \
    sudo cp -rf /tmp/kf5/* /opt/qt*/

RUN sudo apt install -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs \
        debhelper \
&&  echo "deb-src http://http.debian.net/debian sid main" >> /etc/apt/sources.list \
&&  apt-get update \
&&  dget -x http://http.debian.net/debian/pool/main/g/gloox/gloox_1.0.20-2.dsc \
&&  cd gloox-*/ \
&&  sed -i 's/libgnutls28-dev/libgnutls-dev/g' debian/control \
&&  sudo apt-get build-dep gloox -y -t trusty-backports \
&&  dch --local ~bpo14.04+ --distribution trusty-backports "Rebuild for trusty-backports." \
&&  echo "9" > debian/compat \
&&  dpkg-buildpackage -us -uc -d \
&&  cd .. \
&&  sudo dpkg -i libgloox*.deb \
&&  rm -rf *gloox* \
&&  apt purge --auto-remove -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs

ENV QT_BASE_DIR=/opt/qt510
ENV QTDIR=$QT_BASE_DIR
ENV PATH=$QT_BASE_DIR/bin:$PATH

ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
