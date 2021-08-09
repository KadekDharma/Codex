# Using python debian
FROM ubuntu:20.04

# https://shouldiblamecaching.com/
ENV PIP_NO_CACHE_DIR 1
# http://bugs.python.org/issue19846
ENV LANG C.UTF-8
# we don't have an interactive xTerm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update -y && apt-get -qq upgrade -y
RUN apt-get -qq install -y \
    git \
    curl \
    wget \
    ffmpeg \
    python3 \
    python3-virtualenv

# Git clone repository + root 
RUN git clone https://github.com/Codex51/Codex.git /usr/src/usercodex
WORKDIR /usr/src/usercodex
ENV PATH="/usr/src/usercodex/bin:$PATH"

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m virtualenv --python=/usr/bin/python3 $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install requirements
RUN python3 -m pip install -U pip setuptools wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

RUN chmod a+x start
CMD ["./start"]
