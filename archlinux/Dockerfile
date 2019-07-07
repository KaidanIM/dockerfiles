FROM archlinux/base

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        git \
        base-devel \
        appstream \
        ccache \
        cmake \
        extra-cmake-modules \
        ninja \
        qt5-base \
        qt5-declarative \
        qt5-quickcontrols2 \
        qt5-tools \
        qt5-svg \
        qt5-location \
        kirigami2 \
        knotifications \
        libidn \
        gloox

# Build latest QXmpp
RUN git clone https://github.com/qxmpp-project/qxmpp \
 && cd qxmpp \
 && cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
 && ninja install \
 && cd ../ \
 && rm -rf qxmpp

# Build latest ZXing-cpp
RUN git clone https://github.com/nu-book/zxing-cpp \
 && cd zxing-cpp \
 && cmake . -GNinja \
 && sudo ninja install \
 && cd ../ \
 && sudo rm -rf zxing-cpp
