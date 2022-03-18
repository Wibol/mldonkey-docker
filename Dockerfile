FROM ubuntu:18.04

RUN \
    apt-get update && \
    echo yes |apt-get install --no-install-recommends -y mldonkey-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/mldonkey && \
    rm /var/lib/mldonkey/*
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENV MLDONKEY_DIR=/var/lib/mldonkey LC_ALL=C.UTF-8 LANG=C.UTF-8 MLDONKEY_ADMIN_PASSWORD=Passw0rd-
VOLUME ["/var/lib/mldonkey"]
EXPOSE 4080 4000 4001 20562 20566/udp 16965/udp
CMD /entrypoint.sh
