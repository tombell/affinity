FROM alpine:3.18.3

RUN apk add --no-cache cdrkit gcc grub make nasm

RUN mkdir -p /opt/affinity
WORKDIR /opt/affinity
