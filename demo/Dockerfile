FROM ubuntu:16.04

# Install curl
RUN apt-get update && \
    apt-get install -y curl rsyslog sudo && \
    rm -rf /var/lib/apt/lists/*


RUN groupadd mqbrkrs
RUN useradd --create-home --home-dir /home/iibuser -G mqbrkrs,sudo iibuser && \
    sed -e 's/^%sudo	.*/%sudo	ALL=NOPASSWD:ALL/g' -i /etc/sudoers

COPY test.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/*.sh

USER iibuser

ENTRYPOINT ["test.sh"]
