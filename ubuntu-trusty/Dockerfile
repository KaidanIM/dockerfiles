FROM ubuntu:trusty

RUN sudo apt update && \
    sudo apt-get install software-properties-common dirmngr -y && \
    sudo add-apt-repository -y ppa:beineri/opt-qt-5.10.1-trusty && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN sudo apt-get update && \
    sudo apt-get install -y -t trusty-backports \
                         wget \
                         cmake \
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
                         qt510quickcontrols2

RUN wget -c "https://github.com/kf5builds/precompiled-kf5-linux/releases/download/kf5.50/kf5-5.50.0-Release-ubuntu-trusty-amd64.tar.xz" && \
    mkdir /tmp/kf5 && \
    tar xf kf5-5.50.0-Release-ubuntu-trusty-amd64.tar.xz -C /tmp/kf5 && \
    sudo cp -rf /tmp/kf5/* /opt/qt*/

RUN wget -c "https://github.com/JBBgameich/precompiled-kf5-linux/releases/download/KF5.40/libgloox17_1.0.20-1_amd64.deb" && \
    wget -c "https://github.com/JBBgameich/precompiled-kf5-linux/releases/download/KF5.40/libgloox-dev_1.0.20-1_amd64.deb" && \
    sudo dpkg -i libgloox*.deb || sudo apt-get -f -y install && \
    rm libgloox*.deb

ENV QT_BASE_DIR=/opt/qt510
ENV QTDIR=$QT_BASE_DIR
ENV PATH=$QT_BASE_DIR/bin:$PATH

ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
