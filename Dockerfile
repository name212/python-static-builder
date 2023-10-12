FROM ubuntu:jammy

ARG PYTHON_VERSION=3.11.6
ENV PYTHON_VERSION=${PYTHON_VERSION}

ARG BUILD_THREADS=4
ENV BUILD_THREADS=${BUILD_THREADS}

RUN apt update && apt install -y build-essential tar gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev uuid-dev zlib1g-dev wget coreutils

RUN mkdir -p /opt/python && mkdir -p /src && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && tar -xzf Python-${PYTHON_VERSION}.tgz -C /src 

COPY Setup.local /src/Python-${PYTHON_VERSION}/Modules/Setup.local

RUN cd /src/Python-${PYTHON_VERSION} && ./configure LDFLAGS="-static" --disable-shared --prefix=/opt/python --enable-optimizations

RUN cd /src/Python-${PYTHON_VERSION} && make LDFLAGS="-static" LINKFORSHARED=" " -j ${BUILD_THREADS}

RUN cd /src/Python-${PYTHON_VERSION} && make install -j ${BUILD_THREADS}
