FROM debian:jessie

MAINTAINER peter@c3re.de

RUN apt-get -y update

RUN apt-get -y install nano netcat rsyslog wget dbus less dialog
RUN cd ; wget -O - https://github.com/andryyy/mailcow/archive/v0.13.1.tar.gz | tar xfz -

COPY install_mailcow.sh /root/mailcow-0.13.1/
RUN chmod 777 /root/mailcow-0.13.1/install_mailcow.sh

COPY dienste_starten.sh /root/mailcow-0.13.1/
RUN chmod 777 /root/mailcow-0.13.1/dienste_starten.sh

COPY mailcow.config     /root/mailcow-0.13.1/
COPY functions.sh       /root/mailcow-0.13.1/includes/

CMD /bin/bash
