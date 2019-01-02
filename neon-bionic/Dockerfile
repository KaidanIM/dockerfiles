FROM kdeneon/plasma:dev-unstable

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
        appstream \
        libqxmpp-dev \
        clazy \
        clang \
        qtdeclarative5-dev-tools

RUN sudo apt install -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs \
&&  git clone https://git.kaidan.im/kaidan/qxmpp-packaging qxmpp && cd qxmpp \
&&  uscan -v \
&&  cd ../qxmpp-0.9.3+git*.* \
&&  sudo apt build-dep . \
&&  dch --local ~bpo18.04+ --distribution bionic-backports "Rebuild for bionic-backports." \
&&  dpkg-buildpackage -us -uc \
&&  cd .. \
&&  sudo dpkg -i libgloox*.deb libgloox-dev*.deb \
&&  rm -rf *gloox* \
&&  sudo apt purge --auto-remove -y \
        packaging-dev \
        debian-keyring \
        devscripts \
        equivs
