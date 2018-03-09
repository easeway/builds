FROM ubuntu:16.04
ADD install.sh /tmp/install-ncsdk.sh
RUN apt-get update && \
    apt-get install -y wget curl sudo lsb && \
    bash /tmp/install-ncsdk.sh && \
    apt-get clean -y

