# Build the TheSkyX Image

FROM debian:buster 

# Prevent the apt-get install steps from requesting interacive input
ENV DEBIAN_FRONTEND noninteractive

# I initially had quite a bit of trouble with the keyboard mapping.  
# These may have fixed the issue.  Need to retest now that I use a 
# different WM on the host machine
ENV XKB_DEFAULT_RULES evdev
ENV XKB_DEFAULT_MODEL pc105
ENV XKB_DEFAULT_LAYOUT us
ENV QT_XKB_CONFIG_ROOT /usr/share/X11/xkb

# Revsit these settings to slim down the image, some of the packages are for debugging.  
# break out into a seperate debug RUN command that can be commented out for a prod build.
# debug list: sudo, vim, xterm, libinput-tools, tbd
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

# Grab the TheSkyX package from a webserver 
# Currently I'm pulling from a webserver on my local network (A synology NAS homes/user/www directory)
ADD http://192.168.1.73/~Astro/TheSkyX-ARM-12545.tar.gz /opt/TheSkyX-ARM-12545.tar.gz 
RUN tar -xvf /opt/TheSkyX-ARM-12545.tar.gz -C /opt && rm /opt/TheSkyX-ARM-12545.tar.gz

# Download and install the settings directory (if you have them)
ADD http://192.168.1.73/~Astro/TheSkyX.Settings.tar.gz /root/Library/TheSkyX.Settings.tar.gz 
RUN tar -xvf /root/Library/TheSky.Settings.tar.gz -C /root/Library && rm /root/Library/TheSkyX.Settings.tar.gz

# Consider removing now that these are mounted at runtime from the host
RUN mkdir /lib/modules && mkdir /lib/modules/5.4.32-rockchip64

# Keeps the install script from complaining about missing directory
RUN mkdir /root/Desktop

# Modify the ./TheSkyX/install file to use 32bit packages
RUN sed -i -e '/apt-get/s/libudev-dev/libudev-dev:armhf/g' /opt/TheSkyX/install
RUN sed -i -e '/apt-get/s/fxload/fxload:armhf/g' /opt/TheSkyX/install

#Disable installation as the drivers cannot be copied if /run/udev/data and /lib/modules/5.4.32-rockchip64 cannot be mounted as volumes during image build
#RUN cd /opt/TheSkyX && ./install && rm -r /opt/TheSkyX/installfiles && rm /opt/TheSkyX/install

ENV DEBIAN_FRONTEND teletype

# open a console for installing the TheSkyX 
#CMD ["xterm"]

