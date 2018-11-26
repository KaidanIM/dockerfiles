FROM rabits/qt:5.11-desktop

RUN apt update \
&&  apt-get install software-properties-common dirmngr -y \
&&  add-apt-repository -y ppa:ubuntu-toolchain-r/test \
&&  add-apt-repository -y universe \
&&  apt-get update \
&&  apt-get install -y -t xenial-backports \
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
&&  apt-get clean

RUN wget -c "https://github.com/kf5builds/precompiled-kf5-linux/releases/download/kf5.52/kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz" \
&&  tar xf kf5-5.52.0-Release-ubuntu-trusty-amd64.tar.xz -C /opt/kf5/

ENV KF5_DIR=/opt/kf5
ENV LD_LIBRARY_PATH=$KF5_DIR/lib/x86_64-linux-gnu:$KF5_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$KF5_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

ENV QT_LINUX=$QT_DESKTOP

RUN git clone https://github.com/qxmpp-project/qxmpp \
&&  cd qxmpp \
&&  cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
&&  ninja install \
&&  cd ../ \
&&  rm -rf qxmpp

