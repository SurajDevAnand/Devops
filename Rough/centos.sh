#! /bin/bash


PLUGIN_VERSION=1
HEARTBEAT="true"
PLUGIN_OUTPUT=$PLUGIN_OUTPUT"heartbeat_required:$HEARTBEAT|plugin_version:$PLUGIN_VERSION|"


if [[ -e /etc/os-release ]]; then

    distro_name=$(cat /etc/os-release | grep "^NAME")
    if [[ $? -ne 0 ]]; then
        PLUGIN_OUTPUT=$PLUGIN_OUTPUT"status:0|msg:Distro name not found|"
        echo $PLUGIN_OUTPUT
        exit 1
    fi
    distro_name=$(echo $distro_name | cut -d "=" -f2)
else
    PLUGIN_OUTPUT=$PLUGIN_OUTPUT"status:0|msg:/etc/os-release file not found|"
    echo $PLUGIN_OUTPUT
    exit 1
fi



if [[ $distro_name == "\"CentOS Linux\"" ]]; then

    centos_updates_info=$(yum check-update --security | tail -n 1)  
    if [[ $? -ne 0 ]]; then
        PLUGIN_OUTPUT=$PLUGIN_OUTPUT"status:0|msg:Error during executing \"yum check-update --security | tail -n 1\" command.|"
        echo $PLUGIN_OUTPUT
        exit 1    
    fi

    out_verify=$(echo $centos_updates_info | grep -E "^([0-9]{1,3}|No) packages needed for security; ([0-9]{1,3}|No) packages available")
    if [[ $out_verify != $centos_updates_info ]]; then
        PLUGIN_OUTPUT=$PLUGIN_OUTPUT"status:0|msg:Error in command execution.|"
        echo $PLUGIN_OUTPUT
        exit 1
    fi

    centos_security_updates_raw=$(echo $centos_updates_info | cut -d ";" -f1)
    security_update_count=$(echo $centos_security_updates_raw | cut -d " " -f1)
    if [[ $security_update_count == "No" ]]; then
        security_update_count=0
    fi

    centos_updates_raw=$(echo $centos_updates_info | cut -d ";" -f2)
    update_count=$(echo $centos_updates_raw | cut -d " " -f1)

fi



PLUGIN_OUTPUT=$PLUGIN_OUTPUT"packages_to_be_updated:$update_count|security_updates:$security_update_count|"
echo $PLUGIN_OUTPUT
exit 0
