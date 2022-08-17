# syntax=docker/dockerfile:1.3-labs
FROM python:3.9

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PATH=/home/user/.local/bin:$PATH

RUN <<EOF
    apt-get update
    apt-get install -y \
        gosu
    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
    useradd -m -o -u 1000 user
EOF

ARG MCSTATUS_VERSION=9.3.0
RUN <<EOF
    gosu user pip3 install "mcstatus==${MCSTATUS_VERSION}"
EOF

ENTRYPOINT [ "gosu", "user", "mcstatus" ]
