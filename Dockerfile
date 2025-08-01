ARG BASE_DOCKER_IMAGE

FROM $BASE_DOCKER_IMAGE

ENV GSKIT $PS2DEV/gsKit

COPY . /src

RUN apk add build-base git bash cmake pkgconfig texinfo autoconf automake libtool gettext-dev flex
RUN cd /src && make -j $(getconf _NPROCESSORS_ONLN)

FROM alpine:3.21.0

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV GSKIT $PS2DEV/gsKit
ENV PATH $PATH:${PS2DEV}/bin:${PS2DEV}/ee/bin:${PS2DEV}/iop/bin:${PS2DEV}/dvp/bin:${PS2SDK}/bin

COPY --from=0 ${PS2DEV} ${PS2DEV}
