# See https://github.com/rabits/dockerfiles/blob/master/5.11-android/Dockerfile
FROM rabits/qt:5.11-android

RUN apt update \
&&  apt-get install software-properties-common dirmngr -y \
&&  add-apt-repository -y universe \
&&  apt-get update \
&&  apt-get dist-upgrade -t xenial-backports \
&&  apt-get install -y -t xenial-backports \
                    sudo \
                    wget \
                    curl \
                    git \
                    pkg-config \
                    cmake \
                    ccache \
                    inkscape \
                    optipng \
                    dos2unix \
&&  apt-get clean
