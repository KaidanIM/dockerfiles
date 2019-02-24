FROM rabits/qt:5.11-desktop

RUN sudo apt update \
&&  sudo apt-get install software-properties-common dirmngr -y \
&&  sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test \
&&  sudo add-apt-repository -y universe \
&&  sudo apt-get update \
&&  sudo apt-get install -y -t xenial-backports \
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
                         libxi6 \
                         libegl1-mesa \
                         libpq5 \
&&  sudo apt-get clean

RUN wget http://security.ubuntu.com/ubuntu/pool/main/m/mysql-5.5/mysql-common_5.5.62-0ubuntu0.14.04.1_all.deb \
&&  wget http://security.ubuntu.com/ubuntu/pool/main/m/mysql-5.5/libmysqlclient18_5.5.62-0ubuntu0.14.04.1_amd64.deb \
&&  sudo dpkg -i *.deb \
&&  rm -rf *.deb

ENV KF5_DIR=/opt/kf5
ENV LD_LIBRARY_PATH=$KF5_DIR/lib/x86_64-linux-gnu:$KF5_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$KF5_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV PATH=$KF5_DIR/bin:$PATH

ENV QT_LINUX=$QT_DESKTOP

# Install kdesrc-build dependencies
RUN sudo apt install libio-socket-ssl-perl libyaml-libyaml-perl gperf -y

# Install KF5
RUN sudo git clone git://anongit.kde.org/kdesrc-build /var/opt/kdesrcbuild
COPY kdesrc-buildrc /root/.kdesrc-buildrc
RUN sudo kdesrc-build --include-dependencies kirigami --verbose && sudo rm -rf ~/kde-src/ /var/opt/kdesrcbuild/

RUN git clone https://github.com/qxmpp-project/qxmpp \
&&  cd qxmpp \
&&  cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
&&  sudo ninja install \
&&  cd ../ \
&&  rm -rf qxmpp
