#! /usr/bin/expect

# Launch neurobot from workstation
set timeout 20

set MASTER_IP 192.168.1.107

# Get master ip
if "$argc == 1" {
    # Here argv 0 is the 1st param
    set MASTER_IP "192.168.1.[lindex $argv 0]"
}  else  {
    puts "Use default IP: $MASTER_IP"
}

# ssh to remote server
spawn ssh $MASTER_IP
set PASSWORD aicrobo
# If we do not have the first input, continue
expect {
    "*yes/no" { send "yes\r"; exp_continue }
    "*password:" { send "$PASSWORD\r" }
}
interact
