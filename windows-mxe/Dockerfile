# Builder
FROM debian:testing-slim as builder

RUN mkdir -p /build/
WORKDIR /build

RUN apt update && \
	apt install -y \
	autotools-dev \
	p7zip-full \
	libgdk-pixbuf2.0-bin \
	git \
	make \
	build-essential \
	wget \
	file \
	python2 \
	automake \
	ruby \
	flex \
	bison \
	gperf \
	unzip \
	python3 \
	autopoint \
	libtool \
	libtool-bin \
	intltool \
	python-minimal \
	pkg-config

# Build mxe
ADD build-mxe.sh /usr/bin/build-mxe
RUN /usr/bin/build-mxe

RUN tar -czf mxe.tar.gz -C /build/mxe/ usr/


# Runner
FROM debian:testing-slim as runner

COPY --from=builder /build/mxe.tar.gz /tmp/mxe.tar.gz
RUN tar -xf /tmp/mxe.tar.gz -C /

# Runtime dependencies for compiling
RUN apt update && \
    apt install extra-cmake-modules inkscape make libfl2 optipng --no-install-recommends -y && \
    ln -s /usr/bin/x86_64-w64-mingw32.static-as /usr/bin/as

ENV MXE_ROOT=/
