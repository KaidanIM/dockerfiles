FROM ubuntu:xenial

RUN apt update \
&&  apt-get install software-properties-common dirmngr -y \
&&  add-apt-repository -y ppa:beineri/opt-qt-5.11.2-xenial \
&&  add-apt-repository -y ppa:ubuntu-toolchain-r/test \
&&  add-apt-repository -y universe \
&&  apt-get update \
&&  apt-get install -y -t xenial-backports \
                         wget \
                         git \
                         pkg-config \
                         cmake3 \
                         ccache \
                         build-essential \
                         ninja-build \
                         zlib1g-dev \
                         qt511base \
                         qt511script \
                         qt511declarative \
                         qt511tools \
                         qt511x11extras \
                         qt511svg \
                         qt511quickcontrols2 \
                         qt511graphicaleffects \
                         mesa-common-dev \
                         libgl1-mesa-dev \
                         libssl-dev \
&&  apt-get clean

RUN wget -c "https://github.com/kf5builds/precompiled-kf5-linux/releases/download/kf5.52/kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz" \
&&  tar xf kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz -C /opt/qt5*/

RUN git clone https://github.com/qxmpp-project/qxmpp \
&&  cd qxmpp \
&&  cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
&&  ninja install \
&&  cd ../ \
&&  rm -rf qxmpp

ENV QT_BASE_DIR=/opt/qt511
ENV QTDIR=$QT_BASE_DIR
ENV PATH=$QT_BASE_DIR/bin:$PATH

ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

ENV QT_LINUX=$QT_BASE_DIR

