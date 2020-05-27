FROM debian:buster 
RUN dpkg --add-architecture armhf
RUN apt-get update && apt-get install -y \
    libudev-dev:armhf \
    fxload:armhf \
    libc6:armhf \
    libstdc++6:armhf \
    libx11-6:armhf \
    libx11-xcb1:armhf \
    libxcb1:armhf \
    libxcomposite1:armhf \
    libxcursor1:armhf \
    libxdamage1:armhf \
    libxss1:armhf \
    libxtst6:armhf \
    libgtk2.0-0:armhf \
    libidn11:armhf \
    libglu1-mesa:armhf \
    libgomp1:armhf \ 
    xkb-data:armhf \
    xterm \
    sudo \
    kmod \
    udev 

ADD http://192.168.1.73/~Astro/TheSkyX-ARM-12545.tar.gz /opt/TheSkyX-ARM-12545.tar.gz 
RUN tar -xvf /opt/TheSkyX-ARM-12545.tar.gz && rm /opt/TheSkyX-ARM-12545.tar.gz
RUN mkdir /lib/modules && mkdir /lib/modules/5.4.32-rockchip64
RUN mkdir /root/Desktop
 
CMD ["xterm"]

