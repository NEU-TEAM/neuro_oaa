#! /usr/bin/expect

# Launch neurobot from workstation
set timeout 20

# Get master ip

# Here argv 0 is the 1st param
set MASTER_IP 192.168.1.107

# ssh to remote server
spawn ssh $MASTER_IP

set PASSWORD aicrobo
# If we do not have the first input, continue
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$PASSWORD\r" }
}

interact