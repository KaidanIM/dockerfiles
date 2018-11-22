FROM archlinux/base

RUN pacman -Sy && \
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
        kirigami2 \
        libidn \
        gloox

# Build latest QXmpp
RUN git clone https://github.com/qxmpp-project/qxmpp \
 && cd qxmpp \
 && cmake . -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=0 -DBUILD_EXAMPLES=0 \
 && ninja install \
 && cd ../ \
 && rm -rf qxmpp
