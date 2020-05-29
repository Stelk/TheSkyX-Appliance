FROM debian:buster 

ENV DEBIAN_FRONTEND noninteractive
ENV XKB_DEFAULT_RULES evdev
ENV XKB_DEFAULT_MODEL pc105
ENV XKB_DEFAULT_LAYOUT us
ENV QT_XKB_CONFIG_ROOT /usr/share/X11/xkb

RUN dpkg --add-architecture armhf
RUN apt-get update && apt-get install -y apt-utils 
RUN apt-get install -y \
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
    libinput-tools \
    sudo \
    kmod \
    udev \
    vim 

ADD http://192.168.1.73/~Astro/TheSkyX-ARM-12545.tar.gz /opt/TheSkyX-ARM-12545.tar.gz 
RUN tar -xvf /opt/TheSkyX-ARM-12545.tar.gz -C /opt && rm /opt/TheSkyX-ARM-12545.tar.gz

RUN mkdir /lib/modules && mkdir /lib/modules/5.4.32-rockchip64
RUN mkdir /root/Desktop
RUN sed -i -e '/apt-get/s/libudev-dev/libudev-dev:armhf/g' /opt/TheSkyX/install
RUN sed -i -e '/apt-get/s/fxload/fxload:armhf/g' /opt/TheSkyX/install
#RUN cd /opt/TheSkyX && ./install && rm -r /opt/TheSkyX/installfiles && rm /opt/TheSkyX/install
ENV DEBIAN_FRONTEND teletype
 
CMD ["xterm"]

