# Old Pi Setup Steps

Model: Pi Rev B, 512 MB

Download:
- https://www.raspberrypi.org/downloads/raspberry-pi-os/
- Raspberry Pi OS (32-bit) Lite

Setup Guides: 
- https://www.raspberrypi.org/downloads/
- https://www.raspberrypi.org/documentation/installation/installing-images/README.md
- https://www.raspberrypi.org/documentation/installation/installing-images/mac.md
- https://desertbot.io/blog/headless-raspberry-pi-4-ssh-wifi-setup

Project Examples:
- https://gist.github.com/ntrepid8/d6f0fafa57a42ca1b515c19e71492309
- https://pimylifeup.com/raspberry-pi-internet-speed-monitor/
- https://medium.com/@picsnapr/i-made-raspberry-pi-monitor-and-record-my-broadband-speeds-on-a-google-sheet-417ef92fad85


# Download OS to SD card
On Mac

Download the image file, and unzip it

Run `diskutil list` to get disks, grab disk number (in this example, 2)

/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *8.0 GB     disk2
   1:                 DOS_FAT_32 PI                      8.0 GB     disk2s1


`diskutil unmountDisk /dev/disk2`

`sudo dd bs=1m if=2020-05-27-raspios-buster-lite-armhf.img of=/dev/disk2; sync` to copy the img file to the MicroSD card

`sudo diskutil eject /dev/disk2`

Disconnect and reconnect MicroSD card

# Enable SSH
`echo " " >> /Volumes/boot/ssh` to enable SSH remote access. Haven't tested to see if this was required.

# Configure Wi-Fi
Enabled Wi-Fi connection via USB Wi-Fi adapter by creating a file at `/Volumes/boot/wpa_supplicant.conf` with the following

country=CA
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="NETWORK-NAME"
    psk="NETWORK-PASSWORD"
}

Initially only connected it via Ethernet

Hostname was not visible on Fing, so SSHed to the IP address found from Fing

Went through the `sudo raspi-config` menus, set them how I liked, including hostname, disabling unneeded interfaces

Checked `iwconfig` and verified Power Management:off
This is a handy command to show WLAN statistics

# Update Software

sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get upgrade -y

# Other

Checked total RAM size by running `grep MemTotal /proc/meminfo` and saw 442548 kB (442 MB)

This Pi has 2011.12 printed on the PCB, meaning this is a Model B Revision 2.0 (512MB), from Q4 2012

Ran `cat /proc/cpuinfo` which showed Revision : 000e, meaning this one was manufactured by Sony
Serial          : 00000000e0ad68ec

Customize bash profile for my common shortcuts: c, l
pi@pi:~ $ cat .bash_profile 
alias c='clear'
alias l='ls -al'
alias ip='curl -w "\n" whatismyip.akamai.com'

Customize bash to put out ISO date time stamps on command line prompts

# Install Docker

https://withblue.ink/2020/06/24/docker-and-docker-compose-on-raspberry-pi-os.html
To install Docker CE on Raspberry Pi OS, both 32-bit and 64-bit, run:
# Install some required packages first
sudo apt update
sudo apt install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# Get the Docker signing key for packages
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# Add the Docker official repos
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

# Install Docker
sudo apt update
sudo apt install -y --no-install-recommends \
    docker-ce \
    cgroupfs-mount

# Further instructions in the link

# Speed Test

Google Sheet: https://docs.google.com/spreadsheets/d/1mvk1qvZ2wVeEhhcf9JJqcYJj6-Y5fbzvQb9ylsk4XMQ

Install pip with `sudo apt-get install python3-pip`

Install Speedtest.net's CLI with `sudo pip3 install speedtest-cli`

Look up Geo IP information with `curl ipinfo.io/96.51.228.193`
curl ipinfo.io/$(curl https://ifconfig.me/ip)
curl -w "\n" https://ifconfig.me/ip

# To Do:

Figure out why my local DNS resolves the hostname for the Wi-Fi IP address instead of Ethernet

Instructions on setting up the speed test, logging in the Google Sheet: https://medium.com/@picsnapr/i-made-raspberry-pi-monitor-and-record-my-broadband-speeds-on-a-google-sheet-417ef92fad85

Need to add columns for public IP, Lat, Long, Address, or some sort of location, so that this thing can run wherever I plug it in?

Need to add speed tests for wired and wireless, and a column to mark which interface the speed test used

Server ID,Sponsor,Server Name,Timestamp,Distance,Ping,Download,Upload,Share,IP Address
