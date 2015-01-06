FROM tpires/neo4j
MAINTAINER SMS Management & Technology


RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd /var/log/supervisor /root/.ssh

COPY id_rsa.pub /root/.ssh/authorized_keys
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 700 /root/.ssh; chmod 640 /root/.ssh/authorized_keys

EXPOSE 22
EXPOSE 7474

CMD ["/usr/bin/supervisord"]
