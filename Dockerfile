FROM alpine:latest
RUN apk add --no-cache bash
RUN apk add --no-cache rtorrent
RUN apk add --no-cache libcurl
RUN apk add --no-cache curl
# RUN apk add supervisor

RUN mkdir /myconfig
RUN mkdir /home/nfs_download
RUN mkdir /root

# Removed: COPY config/rtorrent.rc /root/.rtorrent.rc
# This file will now be mounted as a volume during container runtime.
# COPY config/rtorrent.rc /root/.rtorrent.rc

# create file and ignore if it fails
RUN touch /root/.rtorrent.rc || true
# change ownership, ignore if it fails
RUN chown root:root /root/.rtorrent.rc || true
COPY install/rtorrent.sh /rtorrent.sh
# COPY config/supervisord.conf /etc/supervisor/supervisord.conf

VOLUME ["/home/nfs_download"]
EXPOSE 5001/tcp
# ENTRYPOINT ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
# ENTRYPOINT ["rtorrent"]
ENTRYPOINT ["/rtorrent.sh"]