FROM ubuntu:latest
MAINTAINER Fotios Lindiakos fotioslindiakos@gmail.com

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install git python-cheetah supervisor -y

# Setup supervisor
# http://docs.docker.io/en/latest/examples/using_supervisord/
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/
ADD sickbeard.conf /etc/supervisor/conf.d/

# Create a sickbeard user (I really don't like running stuff as root)
RUN useradd --system --create-home --base-dir=/opt --skel=/dev/null sickbeard
RUN git clone git://github.com/midgetspy/Sick-Beard.git /opt/sickbeard
RUN chown -R sickbeard:sickbeard /opt/sickbeard

EXPOSE 8081
CMD ["/usr/bin/supervisord"]
