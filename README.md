# BetterPWN
More reliable and effective way of capturing WiFi handshakes and PMKID's on a raspberry pi 0. Inspired by Pwnagotchi.

This tool automates the use of hcxdumptool to activly capture WiFi handshakes and PMKID's. The handshakes/PMKIDs are stored in a pcap file and after each scan the completed pcap file will be added to the full cpature file for easy offloading. 

Provided are the 2 scripts needed. ISO file will be added later. Currently must be used with an externel WiFi card (not the onload one to raspberry pi's) as nexmon support is limited and i am currently working on a stable version. For now, running the shi.sh file via cron on reboot with a monitor mode compatable adapter will generate captures. Logs can be viewed in the output.log file for trouble shooting purposes. This is a very crude project at the moment but it works and i enjoyed making it.

####DEPENDANCIES####
tshark
aircrack-ng
hcxtools

sudo apt install tshark aircrack-ng hcxtools
