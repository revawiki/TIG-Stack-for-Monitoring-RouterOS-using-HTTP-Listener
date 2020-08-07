# -- Device Uptime --
# Gather basic router info
:local name [/system identity get name];
:local uptime [/system resource get uptime];

# Change device uptime to seconds
:local weekend 0;
:local dayend 0;
:if ([:find $uptime "w" -1]!="") do={ :set weekend [:find $uptime "w" -1]; };
:if ([:find $uptime "d" -1]!="") do={ :set dayend [:find $uptime "d" -1]; };
:local weeks [:pick $uptime 0 $weekend];
:local days [:pick $uptime ($weekend+1) $dayend];
:local time [:pick $uptime ([:len $uptime]-8) [:len $uptime]];
:local hours [:pick $time 0 2];
:local minutes [:pick $time 3 5];
:local seconds [:pick $time 6 8];
:local uptimeseconds [($weeks*86400*7) + ($days*86400) + ($hours*3600) + ($minutes*60) + ($seconds)];

# Fetch device uptime info via http
/tool fetch mode=http http-method=post http-header-field="content-type:application/json" url="http://192.168.56.1:8080/router" http-data="{\"deviceName\" : \"$name\", \"deviceUptime\" : $uptimeseconds}";

# -- Interface Traffic --
# Set variable for interface traffic info
:local name [/system identity get name]
:local ifname
:local monitor
:local speedrx
:local speedtx
:local kbpsrx
:local kbpstx

# Loop each interface and get traffic
:foreach interface in=[/interface find] do={
:delay 100ms;
:set $ifname [/interface get $interface name];
:set $monitor [/interface monitor-traffic $ifname as-value once];
:set $speedrx ($monitor->"rx-bits-per-second");
:set $speedtx ($monitor->"tx-bits-per-second");
:set $kbpsrx ($speedrx/1000);
:set $kbpstx ($speedtx/1000);

#Fetch interface traffic info via http
/tool fetch mode=http http-method=post http-header-field="content-type:application/json" url="http://192.168.56.1:8081/router" http-data="{\"deviceName\" : \"$name\", \"interfaceName\" : \"$ifname\", \"txSpeed\" : $kbpstx, \"rxSpeed\" : $kbpsrx}";

}

