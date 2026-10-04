FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash ca-certificates curl dnsutils iproute2 iputils-ping less \
    netcat-openbsd nmap openssh-client procps proxychains4 sshpass traceroute vim-tiny \
    && rm -rf /var/lib/apt/lists/*
COPY motd /etc/motd
COPY bashrc /root/.bashrc
COPY mission.txt /root/MISSION.txt
WORKDIR /root
CMD ["bash", "-lc", "cat /etc/motd; exec tail -f /dev/null"]
