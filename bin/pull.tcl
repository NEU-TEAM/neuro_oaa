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

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/drv_package_v2/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating drv_package_v2"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/neuro_package/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating neuro_package"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/robot/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating robot"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/neu_launch/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating neu_launch"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/odom_tf_package/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating odom_tf_package"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/src/neuro_oaa/\r" }
}
expect {
    "$*" { send "git pull\r" }
}
puts "\r==========> Updating neuro_oaa"

puts "\r==========> All package updated"
puts "\r==========> Run catkin_make"

expect {
    "$*" { send "cd /home/aicrobo/catkin_ws/\r" }
}
expect {
    "$*" { send "catkin_make\r" }
}

interact
