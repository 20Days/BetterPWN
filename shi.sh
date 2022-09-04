#!/bin/bash
wake_Wait=60    # Wait time to give system a chance to start and show interfaces
start_Wait=60   # Additional wait time before scanning starts

timeOut=2       # Time (min) that each capture file will run (>=2)

echo "PID of this script: $$"      # Provides PID in output log to kill

if ! command -v hcxdumptool &> /dev/null
then
    echo "hcxdumptools not installed"
    exit
elif ! command -v tshark &> /dev/null
then
    echo "tshark not installed"
    exit
elif ! command -v aircrack-ng &> /dev/null
then
    echo "aircrack-ng not installed"
    exit
fi

sleep $wake_Wait

reload_brcm() {
  if ! modprobe -r brcmfmac; then
    return 1
  fi
  if ! modprobe brcmfmac; then
    return 1
  fi
  return 0
}

check_brcm() {
  if [[ "$(journalctl -n10 -k --since -5m | grep -c 'brcmf_cfg80211_nexmon_set_channel.*Set Channel failed')" -ge 5 ]]; then
    return 1
  fi
  return 0
}

start_monitor_interface() {
  iw phy "$(iw phy | head -1 | cut -d" " -f2)" interface add mon0 type monitor && ifconfig mon0 up
  echo "mon0 started"
}

iface=$(python3 iface_select.py)   # Run py script to get and check monitor mode
echo $iface                        # States the interface being used for output log

echo Waiting $start_Wait seconds...
sleep $start_Wait
echo Starting...

airmon-ng check kill
hcxdumptool -m $iface

while true
do
    hcxdumptool -i $iface -o cap.pcap --active_beacon --enable_status=15 --tot=$timeOut
    mergecap -a cap.pcap -w fullcap.pcap
    rm cap.pcap
    if $iface == "mon0"
    then
        if check_brcm
        then
            reload_brcm
        fi
    fi
done

### To-do
# Provide output for number of successful caps and unique caps
# Find way to use waveshare screen
###
