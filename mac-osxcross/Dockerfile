FROM debian:testing-slim

# Install build tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
        automake curl file git libtool pkg-config \
        python3 texinfo vim  wget cmake clang zlib1g-dev build-essential

ADD 0001-tools-osxcross-macports-Avoid-universal-packages.patch /tmp/

# Install osxcross
RUN mkdir /opt/osxcross && \
    cd /opt && git clone https://github.com/tpoechtrager/osxcross.git && \
    cd osxcross && \
    git apply /tmp/0001-tools-osxcross-macports-Avoid-universal-packages.patch && \
    ./tools/get_dependencies.sh && \
    wget -O tarballs/MacOSX10.11.sdk.tar.xz https://dl.dropboxusercontent.com/s/x5qzef4txpxi6ie/MacOSX10.11.sdk.tar.xz && \
    UNATTENDED=1 PORTABLE=true ./build.sh

ENV PATH=$PATH:/opt/osxcross/target/bin:/var/opt/kdesrcbuild \
    MACOSX_DEPLOYMENT_TARGET=10.11 \
    OSXCROSS_MP_INC=1 \
    OSXCROSS_HOST=x86_64-apple-darwin15 \
    OSXCROSS_VERSION=1.0 \
    OSXCROSS_OSX_VERSION_MIN=10.5 \
    OSXCROSS_TARGET=darwin15 \
    OSXCROSS_SDK_VERSION=10.11 \
    OSXCROSS_SDK=/opt/osxcross/target/bin/../SDK/MacOSX10.11.sdk \
    OSXCROSS_TARBALL_DIR=/opt/osxcross/target/bin/../../tarballs \
    OSXCROSS_PATCH_DIR=/opt/osxcross/target/bin/../../patches \
    OSXCROSS_TARGET_DIR=/opt/osxcross/target/bin/.. \
    OSXCROSS_BUILD_DIR=/opt/osxcross/build \
    OSXCROSS_CCTOOLS_PATH=/opt/osxcross/target/bin \
    OSXCROSS_LIBLTO_PATH=/usr/lib/llvm-7/lib \
    OSXCROSS_LINKER_VERSION=409.12

RUN apt-get install -y make ccache qt5-default qttools5-dev-tools p7zip-full python3-requests qtdeclarative5-dev-tools

# Install Qt
RUN mkdir -p /opt/osxcross/target/macports/pkgs/opt/local/ && cd /tmp/ && \
    wget -q https://git.sr.ht/~lnj/qli-installer/blob/master/qli-installer.py && \
    python3 ./qli-installer.py 5.13.2 mac desktop && \
    mv /tmp/*/clang_64/* /opt/osxcross/target/macports/pkgs/opt/local/

# Install Qt dependencies
RUN echo 4 | osxcross-macports install openssl zlib mysql57-connector-cpp && \
    mkdir -p /usr/local/mysql/lib/ && ln /opt/osxcross/target/macports/pkgs/opt/local/lib/mysql57/mysql/libmysqlclient.20.dylib /usr/local/mysql/lib/libmysqlclient.20.dylib && \
    mkdir -p /opt/local/lib/ && ln /opt/osxcross/target/macports/pkgs/opt/local/lib/libz.1.dylib /opt/local/lib/libz.1.dylib && \
    ln /opt/osxcross/target/macports/pkgs/opt/local/lib/libz.1.2.11.dylib /opt/local/lib/libz.1.2.11.dylib && \
    rm /opt/osxcross/target/macports/{cache,tmp} -rf

RUN sed -i "s,$(grep _GL_INCDIRS /opt/osxcross/target/macports/pkgs/opt/local/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake | head -n 1),set(_GL_INCDIRS /opt/osxcross/target/SDK/MacOSX10.11.sdk/System/Library/Frameworks/OpenGL.framework/Versions/A/Headers/),g" /opt/osxcross/target/macports/pkgs/opt/local/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake
RUN sed -i "s,$(grep CMAKE_FIND_ROOT_PATH_MODE_PACKAGE /opt/osxcross/target/toolchain.cmake | head -n 1),set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH),g" /opt/osxcross/target/toolchain.cmake
ENV QT_MACOS=/opt/osxcross/target/macports/pkgs/opt/local/

# Use Qt host tools
RUN rm -rf '/opt/osxcross/target/macports/pkgs/opt/local/bin/'* && \
    echo 'Replacing Qt Tools with native binaries...' && \
    for i in 'moc' 'qdbuscpp2xml' 'qdbusxml2cpp' 'qlalr' 'qmake' 'rcc' 'uic' 'lconvert' 'lrelease' 'lupdate' 'qmlcachegen'; do \
    ln -sv "$(which $i)" '/opt/osxcross/target/macports/pkgs/opt/local/bin/'; done

# Install osxcross-extras
RUN git clone https://github.com/liushuyu/osxcross-extras && cd osxcross-extras && \
    ./install_extras.sh

# Install kaidan & kdesrc-build dependencies
RUN apt-get install --no-install-recommends extra-cmake-modules inkscape optipng icnsutils libio-socket-ssl-perl libyaml-libyaml-perl gperf bzr libxrender-dev libxcb-keysyms1-dev doxygen -y

# Install KF5
COPY kdesrc-buildrc /root/.kdesrc-buildrc
RUN $(/opt/osxcross/target/bin/x86_64-apple-darwin15-osxcross-conf) && \
    git clone git://anongit.kde.org/kdesrc-build /var/opt/kdesrcbuild && \
    /var/opt/kdesrcbuild/kdesrc-build --include-dependencies \
        extra-cmake-modules \
        kirigami \
        zxing-cpp \
        qxmpp && \
    rm -rf ~/kde/

# Clean up
RUN rm /tmp/* -r
