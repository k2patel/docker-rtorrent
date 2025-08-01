FROM alpine:edge

RUN mkdir /myconfig
RUN mkdir /home/nfs_download
RUN mkdir /root || true

# create file and ignore if it fails
RUN touch /root/.rtorrent.rc || true
COPY install/rtorrent.sh /rtorrent.sh

RUN apk add --no-cache bash rtorrent curl libcurl ncurses

VOLUME ["/home/nfs_download"]
EXPOSE 5001/tcp
ENTRYPOINT ["/rtorrent.sh"]
