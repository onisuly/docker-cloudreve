FROM ubuntu

LABEL maintainer "onisuly <onisuly@gmail.com>"

RUN apt-get update && apt-get install -y curl \
    && curl -o cloudreve.tar.gz -L https://github.com/cloudreve/Cloudreve/releases/download/3.0.0-rc1/cloudreve_3.0.0-rc1_linux_amd64.tar.gz \
    && mkdir /cloudreve \
    && tar -zxf /cloudreve.tar.gz -C /cloudreve \
    && chmod +x /cloudreve/cloudreve \
    && rm /cloudreve.tar.gz

EXPOSE 5212

CMD /cloudreve/cloudreve
