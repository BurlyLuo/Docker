#In order to get a env for network test,This image can help you achive your goal!
#Any Help：olaf.luo@foxmail.com,You also can pull this image from:https://cloud.docker.com/u/burlyluo/repository/docker/burlyluo/nettoolbox
#A network toolbox. image: docker build -t nettoolbox/burlyluo:v1 .

FROM nginx:alpine
RUN sed -i 's|dl-cdn.alpinelinux.org|mirrors.aliyun.com|g' /etc/apk/repositories && \
     apk add bind-tools \
     bash \
     curl \
     wget \
     netcat-openbsd \
     busybox-extras \
     iproute2 \
     apache2-utils \
     net-tools \
     iptables \
     ipset \
     ethtool \
     tmux \
     tcpdump \
     tcpflow \
     ipvsadm \
     openssl \
     vim \
     iperf \
     ntop \
     tini

EXPOSE 80

COPY default.conf /etc/nginx/conf.d/
COPY .tmux.conf /root/.tmux.conf
COPY ./entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "-g", "--", "/entrypoint.sh"]
