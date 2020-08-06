# Gather basic router info
:local name [/system identity get name];
:local uptime [/system resource get uptime];

# Send HTTP info to Telegraf
/tool fetch http-method=post http-header-field='type:application:json" http-data="{\"deviceName\":\"$name\" , \"deviceUpTime\":\"$uptime\"}" url="192.168.56.1:8080/router"
