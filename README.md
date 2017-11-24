# Base:
### Subscribe
/ctrl/vision/grasp/location geometry_msgs/PoseStamped
/ctrl/voice/nav_location_goal geometry_msgs/PoseStamped

### Publish
/feed/base/task_status std_msgs/Int8 -1: out of time & aborted 1: success 0: else

 ---
# Arm:
### Subscribe
/ctrl/vision/grasp/pose geometry_msgs/PoseStamped
/ctrl/voice/arm/left std_msgs/Int8

### Publish
/feed/arm/left/move/result

 ---
# Vision
### Publish
/ctrl/vision/grasp/pose geometry_msgs/PoseStamped
/ctrl/vision/grasp/location geometry_msgs/PoseStamped

 ---
# Voice
### Publish
/ctrl/voice/nav_location_goal geometry_msgs/PoseStamped
/ctrl/voice/arm/left std_msgs/Int8 1: reset 2: open left gripper 3: move forward 4: move backward 5: move left 6: move right

### Subscribe
/feed/base/task_status std_msgs/Int8 -1: out of time & aborted 1: success 0: else
