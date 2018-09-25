FROM kdeneon/plasma:dev-unstable-bionic

RUN sudo apt update \
&&  sudo apt install -y \
        cmake \
        ninja-build \
        kirigami2-dev \
        build-essential \
        extra-cmake-modules \
        qtbase5-dev \
        qt5-default \
        qttools5-dev \
        qtquickcontrols2-5-dev \
        libgloox-dev \
        qtdeclarative5-dev \
        libqt5svg5-dev \
        ccache \
        mesa-common-dev \
        libgl1-mesa-dev \
        libssl-dev \
        appstream

RUN sudo apt install -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs \
&&  dget -x http://http.debian.net/debian/pool/main/g/gloox/gloox_1.0.20-2.dsc \
&&  cd gloox_1.0.20/ \
&&  sudo mk-build-deps --install --remove \
&&  dch --local ~bpo18.04+ --distribution bionic-backports "Rebuild for bionic-backports." \
&&  dpkg-buildpackage -us -uc \
&&  cd .. \
&&  sudo dpkg -i libgloox17*.deb libgloox-dev*.deb \
&&  rm -rf *gloox* \
&&  apt purge -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs
