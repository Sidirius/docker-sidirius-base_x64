FROM ubuntu:latest
MAINTAINER Sven Hartmann <sid@sh87.net>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get update -y
RUN apt-get -qq -y install \
	openssh-server wget nano sudo htop bmon && \
	apt-get clean

RUN mkdir -p /var/run/sshd && \
    echo "root:root" | chpasswd

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
