#! /usr/bin/expect

# Launch neurobot from workstation
set timeout 20

# Get master ip form input

# Here argv 0 is the 1st param
set MASTER_IP [lindex $argv 0]
puts "MASTER_IP set to be: [lindex $argv 0]"

# ssh to remote server
spawn ssh $MASTER_IP

set PASSWORD [lindex $argv 1]
# If we do not have the first input, continue
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$PASSWORD\r" }
}

# Launch roscore
expect {
"$*" { send "roslaunch drv_brain drv_v2_host.launch\r" }
}

interact
