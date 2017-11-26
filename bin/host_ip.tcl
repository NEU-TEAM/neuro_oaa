#! /usr/bin/expect

# Set neurobot host IP on workstation
# This script receive host IP as argument
# Here the HOST_IP=ROS_MASTER_IP=ROS_IP
set timeout 20

# $argv0为脚本名字本身
# $argv为命令行参数
# [lrange $argv 0 0]表示第1个参数
# [lrange $argv 0 4]为第一个到第五个参数
# 与c语言不一样的地方在于，$argv不包含脚本名字本身

## Here argv 0 is the 1st param
set MASTER_IP [lindex $argv 0]

## ssh to remote server
spawn ssh $MASTER_IP

set PASSWORD aicrobo
## If we do not have the first yes/no input,
## it will continue with exp_continue
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$PASSWORD\r" }
}

# First erase original IP
expect {
"$*" { send "sed -i '/ROS_MASTER_URI/d' ~/.bashrc\r" }
}
expect {
"$*" { send "sed -i '/ROS_IP/d' ~/.bashrc\r" }
}

# Then add new IP
expect {
"$*" { send "echo export ROS_MASTER_URI=http://$MASTER_IP:11311 >> ~/.bashrc\r" }
}
expect {
"$*" { send "echo export ROS_IP=$MASTER_IP >> ~/.bashrc\r" }
}

# Close remote connection
expect {
"$*" { send "exit\r" }
}
interact
