# TIG Stack for Monitoring RouterOS using HTTP Listener

This project was created to overcome a solution for Monitoring a Router with Dynamic IP Public, where SNMP can't be implemented. Project was created using TIG Stack running on Docker. RouterOS used for the experiment was virtualized using Virtualbox. Telegraf with HTTP Listener plugin (link below) was used for metrics collecting agent, while RouterOS HTTP Fetcher was used for information relay.  

## Current Issues and To-Do List (August 7th 2020)
Issues :
- deviceUptime parser return empty value (zero)
- uptimeseconds script seems to not working

To-Do :
- complete grafana dashboard visualization
- add more metric collecting system in script

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Installing and Running TIG-Stacks

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

### Setting-Up the RouterOS

Guide to virtualize RouterOS on the Virtualbox for setting up the simulation environtment.
(not yet published)

#### Expected visual
(not yet captured)
![Grafana-Dashboard]()

## Built With

* [Grafana](http://www.grafana.com) for Data visualization.
* [InfluxDB]() for Database.
* [Telegraf]() for Metric Collecting Agent.
* [RouterOS]() for Monitored Router.
* [VirtualBox]() for Router Visualization.
* [Docker](https://www.docker.com) for Container Virtualization.

## Credits

* [Jitsi-Monitoring](https://github.com/haidlir/jitsi-monitoring) by Haidlir Naqvi.

##### Question/Inquiries
If you have any question regarding the repo, feel free to e-mail me at reva.wiki@gmail.com. Thank you.

