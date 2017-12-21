FROM resin/rpi-raspbian:latest

LABEL maintainer="Michael Miklis / <info@michaelmiklis.de>"

ENV  DEBIAN_FRONTEND noninteractive

# Install RPI-Monitor form Xavier Berger's repository
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends dirmngr apt-transport-https ca-certificates  && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F && \
    echo deb http://giteduberger.fr rpimonitor/ > /etc/apt/sources.list.d/rpimonitor.list && \
    apt-get -y update && \
    apt-get install -y rpimonitor && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sed -i 's/\/sys\//\/dockerhost\/sys\//g' /etc/rpimonitor/template/* && \ 
    sed -i 's/\/etc\/os-release/\/dockerhost\/usr\/lib\/os-release/g' /etc/rpimonitor/template/version.conf && \
    sed -i 's/\/proc\//\/dockerhost\/proc\//g' /etc/rpimonitor/template/* && \
    echo include=/etc/rpimonitor/template/wlan.conf >> /etc/rpimonitor/data.conf && \
    sed -i '/^web.status.1.content.8.line/ d' /etc/rpimonitor/template/network.conf && \
    sed -i '/^#web.status.1.content.8.line/s/^#//g' /etc/rpimonitor/template/network.conf && \
    sed -i 's/\#dynamic/dynamic/g' /etc/rpimonitor/template/network.conf && \
    sed -i 's/\#web.statistics/web.statistics/g' /etc/rpimonitor/template/network.conf  
    
# Allow access to port 8888
EXPOSE 8888

# Start rpimonitord using run.sh wrapper script
ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD bash -C '/run.sh';'bash'
