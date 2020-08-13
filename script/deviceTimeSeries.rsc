# RouterOS automatic HTTP fetcher for TIG-Stacks

# Scripting options below
# Device Code
:local devicecode
:set devicecode "router-001"

# Metrics to Collect

# -- Device System Information --

# Gather basic router info
:local name [/system identity get name];
:local uptime [/system resource get uptime];
:local freememory [/system resource get free-memory];
:local totalmemory [/system resource get total-memory];
:local freehddspace [/system resource get free-hdd-space];
:local totalhddspace [/system resource get total-hdd-space];
:local cpuload [/system resource get cpu-load];
:local version [/system resource get version];

# Calculate HDD & Memory
:local memoryusage;
:local hddusage;
:set memoryusage [($totalmemory-$freememory)];
:set hddusage [($totalhddspace-$freehddspace)];

# Change device uptime to seconds
:local uptimeseconds 0;
:local weekend 0;
:local dayend 0;
:local weeks 0;
:local days 0;

:if ([:find $uptime "w" -1] > 0) do={
    :set weekend [:find $uptime "w" -1];
    :set weeks [:pick $uptime 0 $weekend];
    :set weekend ($weekend+1);
};

:if ([:find $uptime "d" -1] > 0) do={
    :set dayend [:find $uptime "d" -1];
    :set days [:pick $uptime $weekend $dayend];
};

:local time [:pick $uptime ([:len $uptime]-8) [:len $uptime]]; 

:local hours [:pick $time 0 2];
:local minutes [:pick $time 3 5];
:local seconds [:pick $time 6 8]; 

:set uptimeseconds [($weeks*86400*7+$days*86400+$hours*3600+$minutes*60+$seconds)];


#Fetch device system info via http
/tool fetch mode=http http-method=post http-header-field="content-type:application/json" url="http://192.168.56.1:8080/nodeinfo" http-data="{\"deviceCode\" : \"$devicecode\",\"deviceIdentity\" : \"$name\", \"deviceUptime\" : $uptimeseconds, \"systemUsageHDD\" : $hddusage, \"systemTotalHDD\" : $totalhddspace, \"systemUsageRAM\" : $memoryusage, \"systemTotalRAM\" : $totalmemory, \"systemCPULoad\" : $cpuload, \"systemVersion\" : \"$version\"}";

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
/tool fetch mode=http http-method=post http-header-field="content-type:application/json" url="http://192.168.56.1:8080/nodeinfo" http-data="{\"deviceCode\" : \"$devicecode\", \"interfaceName\" : \"$ifname\", \"trafficTxSpeed\" : $kbpstx, \"trafficRxSpeed\" : $kbpsrx}";

}


