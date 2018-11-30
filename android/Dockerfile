# See https://github.com/rabits/dockerfiles/blob/master/5.11-android/Dockerfile
FROM rabits/qt:5.11-android

RUN sudo apt update \
&&  sudo apt-get install software-properties-common dirmngr -y \
&&  sudo add-apt-repository -y universe \
&&  sudo apt-get update \
&&  sudo apt-get install -y -t xenial-backports \
                 wget curl git \
                 build-essential pkg-config cmake ccache \
                 inkscape optipng \
                 dos2unix \
&&  sudo apt-get clean
