FROM alpine

LABEL maintainer "onisuly <onisuly@gmail.com>"

ENV PUID=1000
ENV PGID=1000

ARG BUILD_DEP="ca-certificates wget"
ARG RUN_DEP="s6"

RUN apk add --no-cache $RUN_DEP \
    && apk add --no-cache --virtual build-dependencies $BUILD_DEP \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk \
    && apk add glibc-2.31-r0.apk \
    && rm glibc-2.31-r0.apk \
    && CLOUDREVE_VERSION=$(wget -q -O- "https://api.github.com/repos/cloudreve/Cloudreve/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') \
    && wget -O cloudreve.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/${CLOUDREVE_VERSION}/cloudreve_${CLOUDREVE_VERSION}_linux_amd64.tar.gz \
    && mkdir /cloudreve \
    && tar -zxf /cloudreve.tar.gz -C /cloudreve \
    && chmod +x /cloudreve/cloudreve \
    && rm /cloudreve.tar.gz \
    && apk del build-dependencies

ADD main.sh /cloudreve/main.sh

RUN chmod +x /cloudreve/main.sh

WORKDIR /cloudreve

EXPOSE 5212

ENTRYPOINT ["./main.sh"]
