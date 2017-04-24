# base image is lenny (eol!) from debian archive
FROM debian/eol:lenny
MAINTAINER Herbert Nees <c64.emulator@web.de>

ENV SQUEEZE_VOL /srv/squeezebox
ENV SQUEEZE_MEDIA /media/Audio
ENV SQUEEZE_USER squeezecenter
ENV DEBIAN_FRONTEND noninteractive
ENV MEDIASERVER_URL=http://downloads.slimdevices.com/SqueezeCenter_v7.2.1/squeezecenter_7.2.1_all.deb
ENV LAME_PKG=lame_3.98.2-0.4_amd64.deb
ENV LIBMP3_PKG=libmp3lame0_3.98.2-0.4_amd64.deb

# prevent message about expired keys
RUN sed -i '/volatile/d' /etc/apt/sources.list && \
	sed -i '/updates/d' /etc/apt/sources.list && \
	cat /etc/apt/sources.list

# install essentials
RUN apt-get update && \
	apt-get -y --force-yes install apt-utils locales curl wget

# Set the locale
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 

# create user and group (must already exist on host system with same uid and gid)
RUN 	groupadd -g 888 $SQUEEZE_USER && \
	useradd -b $SQUEEZE_VOL -c "Logitech SqueezeCenter" -r -s /bin/false -g 888 -u 888 $SQUEEZE_USER

# copy mp3 packages (lame) from host to image for installation
COPY $LAME_PKG /tmp/lame.deb
COPY $LIBMP3_PKG /tmp/libmp3lame0.deb

# install mediaserver and prerequisites
RUN apt-get update && \
	apt-get -y --force-yes install perl mysql-server libmysqlclient-dev libgd-gd2-perl ia32-libs faad flac sox mplayer && \
	curl -Lsf -o /tmp/logitechmediaserver.deb $MEDIASERVER_URL && \
	dpkg -i /tmp/logitechmediaserver.deb && \
	rm -f /tmp/logitechmediaserver.deb && \
	dpkg -i /tmp/libmp3lame0.deb && \
	rm -f /tmp/libmp3lame0.deb && \
	dpkg -i /tmp/lame.deb && \
	rm -f /tmp/lame.deb && \
	apt-get clean

# enable MySQL 5.5
RUN sed -i 's/TYPE=InnoDB/ENGINE=InnoDB/' /usr/share/squeezecenter/SQL/mysql/schema_*.sql

# enable Transcoding for AAC files
COPY convert.conf /etc/squeezecenter

# volumes and ports between host and container
VOLUME $SQUEEZE_VOL
VOLUME $SQUEEZE_MEDIA
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]

