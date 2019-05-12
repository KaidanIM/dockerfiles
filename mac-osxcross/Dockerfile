FROM debian:buster

# Install build tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
        automake curl file git libtool pkg-config \
        python3 texinfo vim  wget cmake clang

# Install osxcross
RUN mkdir /opt/osxcross && \
    cd /opt && git clone https://github.com/tpoechtrager/osxcross.git && \
    cd osxcross && \
    ./tools/get_dependencies.sh && \
    wget -O tarballs/MacOSX10.11.sdk.tar.xz https://dl.dropboxusercontent.com/s/x5qzef4txpxi6ie/MacOSX10.11.sdk.tar.xz && \
    UNATTENDED=1 PORTABLE=true ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
ENV MACOSX_DEPLOYMENT_TARGET=10.11
ENV export OSXCROSS_MP_INC=1

RUN apt-get install -y make ccache qt5-default qttools5-dev-tools p7zip-full python3-requests qtdeclarative5-dev-tools

# Install Qt
RUN mkdir -p /opt/osxcross/target/macports/pkgs/opt/local/ && cd /tmp/ && \
    wget -q https://git.sr.ht/~lnj/qli-installer/blob/master/qli-installer.py && \
    python3 ./qli-installer.py 5.12.0 mac desktop && \
    mv /tmp/*/clang_64/* /opt/osxcross/target/macports/pkgs/opt/local/ && rm /tmp/* -r

RUN sed -i "s,$(grep _GL_INCDIRS /opt/osxcross/target/macports/pkgs/opt/local/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake | head -n 1),set(_GL_INCDIRS /opt/osxcross/target/SDK/MacOSX10.11.sdk/System/Library/Frameworks/OpenGL.framework/Versions/A/Headers/),g" /opt/osxcross/target/macports/pkgs/opt/local/lib/cmake/Qt5Gui/Qt5GuiConfigExtras.cmake
RUN sed -i "s,$(grep CMAKE_FIND_ROOT_PATH_MODE_PACKAGE /opt/osxcross/target/toolchain.cmake | head -n 1),set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH),g" /opt/osxcross/target/toolchain.cmake
ENV QT_MACOS=/opt/osxcross/target/macports/pkgs/opt/local/

# Use Qt host tools
RUN rm -rf '/opt/osxcross/target/macports/pkgs/opt/local/bin/'* && \
    echo 'Replacing Qt Tools with native binaries...' && \
    for i in 'moc' 'qdbuscpp2xml' 'qdbusxml2cpp' 'qlalr' 'qmake' 'rcc' 'uic' 'lconvert' 'lrelease' 'lupdate'; do \
    ln -sv "$(which $i)" '/opt/osxcross/target/macports/pkgs/opt/local/bin/'; done

# Install osxcross-extras
RUN git clone https://github.com/liushuyu/osxcross-extras && cd osxcross-extras && \
    ./install_extras.sh

# Install kaidan dependencies
RUN apt-get install extra-cmake-modules inkscape optipng -y
