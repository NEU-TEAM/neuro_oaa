# Base (1):
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 4000 | /ctrl/vision/grasp/location   | geometry_msgs/PoseStamped | Relative distance to graspable area |
|   Sub   | 4003 | /ctrl/vision/put/location     | geometry_msgs/PoseStamped | Relative distance to put area in **base_link** frame |
|   Sub   | 5000 | /ctrl/voice/nav_location_goal | geometry_msgs/PoseStamped | Location goal in map for robot to arrive |
|   Pub   | 1000 | /feed/base/task_status        | std_msgs/Int8             | -1: out of time & aborted 1: success 0: else |

 ---
# Arm (2):
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 4001 | /ctrl/vision/grasp/pose    | geometry_msgs/PoseStamped | Target pose in robot base_link frame |
|   Sub   | 4002 | /ctrl/vision/detect/table  | geometry_msgs/PoseStamped | Table pose in **base_link** frame |
|   Sub   | 4004 | /ctrl/vision/put/pose      | geometry_msgs/PoseStamped | Put pose in **base_link** frame |
|   Sub   | 5001 | /ctrl/voice/arm/left       | std_msgs/Int8             | State value for controlling robot left arm. 1: reset 2: open left gripper 3: move forward 4: move backward 5: move left 6: move right |
|   Pub   | 2000 | /feed/arm/left/move/result | std_msgs/Int8             | 1: success 0: else |
|   Pub   | 2001 | /feed/arm/left/plan/result | std_msgs/Int8             | 1: success -1: failed 0: else |

 ---
# Vision (4)
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Pub   | 4000 | /ctrl/vision/grasp/location | geometry_msgs/PoseStamped | Relative distance to graspable area |
|   Pub   | 4001 | /ctrl/vision/grasp/pose     | geometry_msgs/PoseStamped | Target pose in robot base_link frame |
|   Pub   | 4002 | /ctrl/vision/detect/table   | geometry_msgs/PoseStamped | Table pose in **base_link** frame |
|   Pub   | 4003 | /ctrl/vision/put/location   | geometry_msgs/PoseStamped | Relative distance to put area in **base_link** frame |
|   Pub   | 4004 | /ctrl/vision/put/pose       | geometry_msgs/PoseStamped | Put pose in **base_link** frame |
|   Pub   | 4005 | /ctrl/vision/recognize/hand | std_msgs/Int8             | Hand gesture. -1: No hand 0: Number 10 1~9: Number 1~9 (Till now only 5 is used) |

 ---
# Voice (5)
| Pub/Sub |  ID  | Topic | Type | Explanation |
| ------- | ---- | ----  | ---- |------------ |
|   Sub   | 1000 | /feed/base/task_status        | std_msgs/Int8 | -1: out of time & aborted 1: success 0: else |
|   Pub   | 5000 | /ctrl/voice/nav_location_goal | geometry_msgs/PoseStamped | Location goal in map for robot to arrive |
|   Pub   | 5001 | /ctrl/voice/arm/left          | std_msgs/Int8 | State value for controlling robot left arm. 1: reset 2: open left gripper 3: move forward 4: move backward 5: move left 6: move right |

 ---
## Param standard naming
1. For params transit between different modules, the name start with /comm. For param only used inside the module, start
with the name of that module, like /vision
2. Use /param after /comm or /vision so that we know it is a param name when writing code
3. Use /ctrl and /feed to represent control param and feedback param
4. At last use meaningful statement to represent the function of the param. For bool, use /is_ or /has_ as prefix

### Param list for communication
| Name                    |  Set      | Get     |  Delete    | Type       | Explanation                                                              |
| ----------------------- | --------- | ------  | ---------- | ---------- |------------------------------------------------------------------------- |
| /comm/param/ctrl/is_put | voice arm | vision  | vision     | int        | Whether the robot should put down the object in hand. 0: not put >=1 put |
| /comm/param/ctrl/is_ready_to_serve  | vision  | voice  | - | bool       | Whether the robot capture voice, controlled by hand gesture |
