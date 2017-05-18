FROM resin/raspberrypi3-python:3.6
LABEL maintainer "Philip Lundrigan <philipbl@cs.utah.edu>"
ENTRYPOINT []

# Install Openzwave
RUN apt-get update && apt-get install -y --force-yes \
    make libudev-dev g++ libyaml-dev && \
    pip3 install python_openzwave==0.4.0.34 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Mosquitto
RUN apt-get update && apt-get install -y \
    mosquitto && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install InfluxDB
ENV INFLUXDB_VERSION 1.2.0
ADD "https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_armhf.deb" "influxdb_${INFLUXDB_VERSION}_armhf.deb"
RUN dpkg -i "influxdb_${INFLUXDB_VERSION}_armhf.deb" && \
    rm "influxdb_${INFLUXDB_VERSION}_armhf.deb"

ENV BASE_VERSION 1.1.1
