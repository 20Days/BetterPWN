import os
import subprocess as sp

# os.system('iw phy "$(iw phy | head -1 | cut -d" " -f2)" interface add mon0 type monitor && ifconfig mon0 up')

specified_iface = "mon0"

cmd = "sudo /usr/sbin/iw dev | /usr/bin/awk '$1==\"Interface\"{print $2}'"
output = sp.getoutput(cmd)

ifaces_unfiltered = output.split()
mon_ifaces = []

for i in ifaces_unfiltered:
    if i != "mon0":
	    os.system("sudo ip link set dev {} down".format(i))
	    mon_test = sp.getoutput("sudo iwconfig {} mode monitor".format(i))
	    if "not supported" in mon_test:
		    #print("{} does not spoort monitor mode".format(i))
		    os.system("sudo ip link set dev {} up".format(i))
	    else:
		    mon_ifaces.append(i)
		    #print("{} supports monitor mode".format(i))
		    os.system("sudo iwconfig {} mode managed".format(i))
		    os.system("sudo ip link set dev {} up".format(i))
    else:
        mon_ifaces.append("mon0")

if specified_iface in mon_ifaces:
    print(specified_iface)
elif len(mon_ifaces) <= 0:
    print("No supported interfaces found")
else:
    print(mon_ifaces[0])
    
# Add where mon0 as default but if others are present use those
    
