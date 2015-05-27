FROM ubuntu:12.04
MAINTAINER Sven Hartmann <sid@sh87.net>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN dpkg-divert --local --rename --add /sbin/initctl && \
    	ln -s /bin/true /sbin/initctl || true

RUN apt-get update -y && apt-get upgrade -y --force-yes && apt-get dist-upgrade -y --force-yes
RUN apt-get -qq -y install \
	openssh-server sudo nano htop bmon git && \
	apt-get clean

RUN mkdir -p /var/run/sshd && \
    	echo "root:root" | chpasswd

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
