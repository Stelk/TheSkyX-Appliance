Configure a RockPi 4b after reimage using Armbian_20.02.7_Rockpi-4b_buster_current_5.4.28.7z

modify the /etc/hosts file to add local file server (e.g. 192.168.1.100 my.http.fileserver)


sudo apt update
sudo apt upgrade
sudo reboot
sudo apt-get install tasksel
#choose xfce and ssh server
sudo apt-get install gvfs-backends gvfs-fuse gvfs-bin
gio mount smb://avalon.stelk.net/homes
ln -s ~/.gvfs/'smb-share:server=avalon.stelk.net,share=homes' ~/Development/Avalon



#add the section on installing tigervncserver

sudo apt-get install tigervnc-standalone-server
sudo apt-get install tigervnc-common
sudo useradd vnc
sudo passwd vnc
sudo mkhomedir_helper vnc
# run vnc manually first
sudo LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1 vncserver -localhost no -depth 24 -geometry 1920x1024 :1 
sudo LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1 vncserver -kill :1 


sudo vi /etc/systemd/system/vncserver@:1.service
sudo chmod 644 vncserver@\:1.service
sudo systemctl daemon-reload
systemd-analyze verify /etc/systemd/system/vncserver@\:1.service

sudo systemctl start vncserver@:1.service
systemctl status vncserver@:1.service
sudo systemctl enable vncserver@\:1.service

[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=vnc
Environment="LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1"
WorkingDirectory=/home/vnc
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver %i -localhost no -geometry 1920x1924 -depth 24 -alwaysshared
ExecStop=/usr/bin/vncserver -kill %i

[Install]
WantedBy=multi-user.target





#copy ssh-keys to .ssh
vnc
chmod 600 ~/.ssh/id*

## configure git
mkdir ~/Development
cd ~/Development
git clone https://github.com/akgnah/rockpi-toolkit.git
git clone git@github.com:Stelk/TheSkyX-Appliance.git
cd astro-appliance
git checkout master
git config --global user.name "username"
git config --global user.email "email@address"


sudo apt-get install -y docker.io
sudo systemctl enable docker
service docker start
systemctl start docker

