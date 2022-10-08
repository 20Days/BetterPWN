# BetterPWN
More reliable and effective way of capturing WiFi handshakes and PMKID's on a raspberry pi 0. Inspired by Pwnagotchi.

This tool automates the use of hcxdumptool to activly capture WiFi handshakes and PMKID's. The handshakes/PMKIDs are stored in a pcap file and after each scan the completed pcap file will be added to the full cpature file for easy offloading. 

# **Features**
-Automatic capture file merge
-Interface auto selecting

## DEPENDANCIES
tshark
aircrack-ng
hcxtools

sudo apt install tshark aircrack-ng hcxtools
