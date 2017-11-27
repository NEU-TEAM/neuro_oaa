#! /bin/bash
## Main script for launch neurobot on workstation
## You only need to make sure the workstation and robot
## are in the same local network to run this script

## Author: Dong Zhipeng 2017/11/26

################################################################################################
## Set both workstation and host ROS ENV on workstation

## Define host name, check this with `hostname` on host machine 
HOST_NAME=neurobot
## Get path for this script
BASE_PATH=$(cd `dirname $0`; pwd)

setLocalMaster(){
    echo -e "\033[32m> MASTER_IP is: $1\033[0m"

    ## Delete original ROS_MASTER_URI
    sed -i '/ROS_MASTER_URI/d' ~/.bashrc

    ## Set ROS_MASTER_URI for local workstation
    echo export ROS_MASTER_URI=http://$1:11311 >> ~/.bashrc
}

setRemote(){
    ## Set ROS_IP and ROS_MASTER_URI for robot host
    ## Use `1>/dev/null 2>&1` for not displaying output
    ## \Enter change another line, no space in between
    # output=$(./ip_host.tcl $1)
    # if [[ $output =~ "$HOST_NAME" ]]
    ${BASE_PATH}/host_ip.tcl $1 1>${BASE_PATH}/temp.txt 2>&1
    grep -q "$HOST_NAME" ${BASE_PATH}/temp.txt
    if [ $? -eq 0 ]
    then
    	## Host name match, so this is the robot's machine
    	setLocalMaster ${IP}
    	echo -e "\033[32m> ROS_IP and ROS_MASTER_URI set OK\033[0m"
    	return 0
    else
    	echo -e "\033[33mHost name mismatch, continue searching\033[0m"
    	return 1
	fi
	
    ## Simple version without host name judgement
	# ./ip_host.tcl $1 1>./temp.txt 2>&1 && \
	# echo -e "\033[32mHost: ROS_IP and ROS_MASTER_URI set OK\033[0m" || \
	# echo -e "\033[33mHost: Name mismatch\033[0m"
}

## Make current working directory right

## Get workstation local IP by ifconfig
echo -e "\033[32m===============> NEUROBOT STARTING <===============\033[0m"
LOCAL_IP=`LC_ALL=C ifconfig|grep "192.168.1.[0-9]*"|grep -v "127.0.0.1"|cut -d: -f2|awk '{print $1}'`
echo -e "\033[32m> SERVER_IP is: $LOCAL_IP\033[0m"

## Simplified version
## Delete original ROS_IP of workstation
sed -i '/ROS_IP/d' ~/.bashrc
## Add new ROS_IP for workstation
echo export ROS_IP=${LOCAL_IP} >> ~/.bashrc

## Find robot host in range
ROBOT_IP=""
for address in {101..110}
do
	IP=192.168.1.${address}
	## If the IP is not equal to LOCAL_IP
	if [ $(echo ${IP}|tr '.' '+'|bc) -ne $(echo ${LOCAL_IP}|tr '.' '+'|bc) ]
	then
		## No big difference in running time, use nmap by default
		# ping -c1 $IP | grep -q "ttl" && addRemoteIP $IP && break

		## Robust version:
		## Script after || will be executed no matter which && failed
		## Use `` to get return value
		## Use $? to represent the return of former function
		nmap -sn ${IP} | grep -q "192.168.1.[0-9]*"
		if [ $? -eq 0 ]
		then
			## We can check whether the host name is what we want
			setRemote ${IP} && ROBOT_IP=${IP} && break
		fi
	fi
done

################################################################################################
## Launch neurobot

## Param for remote login
PASSWORD='aicrobo'

gnome-terminal -t "roscore" -x bash -c "expect ${BASE_PATH}/launch_roscore.tcl $ROBOT_IP $PASSWORD;exec bash;"
## Wait for 4 seconds to let roscore start
sleep 4
## Launch roscore
gnome-terminal -t "neurobot" -x bash -c "expect ${BASE_PATH}/launch_arm.tcl $ROBOT_IP $PASSWORD;exec bash;"

echo -e "\033[32m===============> NEUROBOT LAUNCHED <===============\033[0m"
