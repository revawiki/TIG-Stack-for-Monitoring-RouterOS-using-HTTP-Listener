# TIG Stack for Monitoring RouterOS using HTTP Listener

This project was created to overcome a solution for Monitoring a Router with Dynamic IP Public, where SNMP can't be implemented. Project was created using TIG Stack running on Docker. RouterOS used for the experiment was virtualized using Virtualbox. Telegraf with HTTP Listener plugin was used for metrics collecting agent, while RouterOS HTTP Fetcher was used for information relay.  

#### Current Issues and To-Do List (August 13th 2020)
Checkpoint :
- Added more metrics collection agent for system info
- Completed to visualizing and optimizing the dashboard for more metrics collected
- Improved overall plugin parser and router scripting
- Updated github documentation

Issues :
[None]

To-Do :
- Add noSQL database for non-timeseries metrics collection (presumably MongoDB)
- Create script for the non-timeseries metrics info parses

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Installing and Running TIG-Stacks

Guide to set-up TIG-stacks that run as a docker container.

1. Install Docker & Docker-Compose if it hasn't been installed on your machine and run it.\
[Docker Install](https://docs.docker.com/get-docker/) & [Docker-Compose Install](https://docs.docker.com/compose/install/)

2. Clone this repository into your machine.
```
$ git clone https://github.com/revawiki/TIG-Stack-for-Monitoring-RouterOS-using-HTTP-Listener
```

3. Go to the cloned directory, and execute this bashfile (with Docker running in the background).
```
$ ./up.sh
```
4. With your browser, access grafana via (http://localhost:3000), login with default password (admin)

5. Create new datasource and choose InfluxDB. Fill url with (http://influxdb:8086). Database name, username and password available in [.env](https://github.com/revawiki/TIG-Stack-for-Monitoring-RouterOS-using-HTTP-Listener/blob/master/.env) file.

6. Create new dashboard and import dashboard template by copy-paste [dashboard.json](https://github.com/revawiki/TIG-Stack-for-Monitoring-RouterOS-using-HTTP-Listener/blob/master/template/dashboard.json) file via dashboard settings.

### Setting-Up the RouterOS

Guide to virtualize RouterOS on the Virtualbox for setting up the simulation environtment.

1. Install Virtualbox [here](https://www.virtualbox.org/wiki/Downloads) & download RouterOS image [here](https://mikrotik.com/download/archive).

2. Install RouterOS in virtualbox, and set-up the connectivity with the guide from "Virtualbox set-up for docker" under the credits section.

3. With your browser, access Mikrotik webfig via your guest host-only IP.

4. Go to System, add a new Script and use [deviceTimeSeries.rsc](https://github.com/revawiki/TIG-Stack-for-Monitoring-RouterOS-using-HTTP-Listener/blob/master/script/deviceTimeSeries.rsc) as the source field then create a Scheduler to run the newly added script within interval (10-30s example).

5. Enable the Scheduler and try to run the Script at least once.

#### Expected visual
![Grafana-Dashboard-2.0](https://raw.githubusercontent.com/revawiki/TIG-Stack-for-Monitoring-RouterOS-using-HTTP-Listener/master/image/visualization-2.png)

## Built With

* [Grafana](http://www.grafana.com) for Data visualization.
* [InfluxDB](https://www.influxdata.com/) for Database.
* [Telegraf](https://github.com/influxdata/telegraf/tree/master/plugins) for Metric Collecting Agent.
* [RouterOS](https://mikrotik.com/) for Monitored Router.
* [VirtualBox](https://www.virtualbox.org/) for Router Visualization.
* [Docker](https://www.docker.com) for Container Virtualization.

## Credits

* [Jitsi-Monitoring](https://github.com/haidlir/jitsi-monitoring) by Haidlir Naqvi.
* [Telegraf HTTP Listener plugin use case](https://thenewstack.io/how-i-created-a-telegraf-plugin-to-monitor-solar-panels/) by Julius Marozas.
* [Virtualbox set-up for docker on host connectivity](http://pinter.org/archives/7719) by Lazlo Pinter


##### Question/Inquiries
If you have any question regarding the repo, feel free to e-mail me at reva.wiki@gmail.com. Thank you.

