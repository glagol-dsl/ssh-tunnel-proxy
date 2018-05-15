FROM php:7.2-cli

MAINTAINER Yoan-Alexander Grigorov <joan.grigorov@gmail.com>

RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /tmp/pear ~/.pearrc

RUN adduser glagol-client --home /home/glagol-client --disabled-password --shell /bin/false --gecos '' \
    && passwd -u glagol-client \
    && echo 'AuthorizedKeysCommand /opt/glagol/bin/authorized_keys %k' >> /etc/ssh/sshd_config \
    && echo 'AuthorizedKeysCommandUser glagol-client' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
    && echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config \
    && echo 'AllowUsers glagol-client' >> /etc/ssh/sshd_config \
    && echo 'AllowTcpForwarding yes' >> /etc/ssh/sshd_config \
    && echo 'X11Forwarding no' >> /etc/ssh/sshd_config \
    && echo 'AllowAgentForwarding no' >> /etc/ssh/sshd_config \
    && echo 'ForceCommand /bin/false' >> /etc/ssh/sshd_config \
    && echo 'HostKeyAlgorithms ssh-rsa' >> /etc/ssh/sshd_config \
    && mkdir /opt/glagol \
    && mkdir /opt/glagol/bin

USER glagol-client

RUN cd \
    && mkdir .ssh \
    && chmod 700 .ssh

USER root

COPY entrypoint.sh /entrypoint.sh
COPY bin /opt/glagol/bin

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
