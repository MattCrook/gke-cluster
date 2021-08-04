#!/bin/sh

while true; do
    echo -en '\n';
    if [[ -e /etc/downward/labels ]]; then
        echo -en '\n'; cat /etc/downward/labels; fi;
    if [[ -e /etc/downward/annotations ]]; then
        echo -en '\n'; cat /etc/downward/annotations; fi;
    if [[ -e /etc/downward/podName ]]; then
        echo -en '\n'; cat /etc/downward/podName; fi;
    if [[ -e /etc/downward/containerCpuRequestMilliCores ]]; then
        echo -en '\n'; cat /etc/downward/containerCpuRequestMilliCores; fi;
    if [[ -e /etc/downward/containerMemoryLimitBytes ]]; then
        echo -en '\n'; cat /etc/downward/containerMemoryLimitBytes; fi;
    if [[ -e /etc/downward/podIP ]]; then
        echo -en '\n'; cat /etc/downward/podIP; fi;
    if [[ -e /etc/downward/podServiceAccountName ]]; then
        echo -en '\n'; cat /etc/downward/podServiceAccountName; fi;
    sleep 5;
done;
