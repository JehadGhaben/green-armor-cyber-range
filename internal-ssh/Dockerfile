FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server iproute2 procps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd \
    && useradd -m -s /bin/bash internal \
    && echo 'internal:InternalLab2026!' | chpasswd \
    && printf '%s\n' 'GA{SECOND_INTERNAL_SERVICE_REACHED}' > /home/internal/flag.txt \
    && chown internal:internal /home/internal/flag.txt
RUN printf '%s\n' \
    'PasswordAuthentication yes' \
    'PermitRootLogin no' \
    'AllowTcpForwarding no' \
    'X11Forwarding no' \
    'UsePAM yes' \
    'PrintMotd yes' \
    >> /etc/ssh/sshd_config
COPY motd /etc/motd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
