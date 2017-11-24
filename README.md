# Base (1):
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 4000 | /ctrl/vision/grasp/location   | geometry_msgs/PoseStamped | Relative distance to graspable area |
|   Sub   | 5000 | /ctrl/voice/nav_location_goal | geometry_msgs/PoseStamped | Location goal in map for robot to arrive |
|   Pub   | 1000 | /feed/base/task_status        | std_msgs/Int8             | -1: out of time & aborted 1: success 0: else |

 ---
# Arm (2):
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 4001 | /ctrl/vision/grasp/pose    | geometry_msgs/PoseStamped | Target pose in robot base_link frame |
|   Sub   | 5001 | /ctrl/voice/arm/left       | std_msgs/Int8             | State value for controling robot left arm. 1: reset 2: open left 																			    gripper 3: move forward 4: move backward 5: move left 6: move right |
|   Pub   | 2000 | /feed/arm/left/move/result | std_msgs/Int8             | 1: success 0: else |

 ---
# Vision (4)
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Pub   | 4000 | /ctrl/vision/grasp/location | geometry_msgs/PoseStamped | Relative distance to graspable area |
|   Pub   | 4001 | /ctrl/vision/grasp/pose     | geometry_msgs/PoseStamped | Target pose in robot base_link frame |

 ---
# Voice (5)
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 1000 | /feed/base/task_status        | std_msgs/Int8 | -1: out of time & aborted 1: success 0: else |
|   Pub   | 5000 | /ctrl/voice/nav_location_goal | geometry_msgs/PoseStamped | Location goal in map for robot to arrive |
|   Pub   | 5001 | /ctrl/voice/arm/left          | std_msgs/Int8 | State value for controling robot left arm. 1: reset 2: open left 																			   gripper 3: move forward 4: move backward 5: move left 6: move right |
