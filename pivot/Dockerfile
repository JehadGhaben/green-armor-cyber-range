FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server iproute2 iputils-ping procps curl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd \
    && useradd -m -s /bin/bash pivot \
    && echo 'pivot:PivotLab2026!' | chpasswd
RUN printf '%s\n' \
    'PasswordAuthentication yes' \
    'PermitRootLogin no' \
    'AllowTcpForwarding yes' \
    'GatewayPorts no' \
    'X11Forwarding no' \
    'UsePAM yes' \
    'PrintMotd yes' \
    >> /etc/ssh/sshd_config
COPY motd /etc/motd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
