FROM alpine:latest
# RUN apk add supervisor

RUN mkdir /myconfig
RUN mkdir /home/nfs_download
RUN mkdir /root || true

RUN apk add --no-cache bash
RUN apk add --no-cache rtorrent
RUN apk add --no-cache libcurl
RUN apk add --no-cache curl

# create file and ignore if it fails
RUN touch /root/.rtorrent.rc || true
COPY install/rtorrent.sh /rtorrent.sh

VOLUME ["/home/nfs_download"]
EXPOSE 5001/tcp
ENTRYPOINT ["/rtorrent.sh"]
