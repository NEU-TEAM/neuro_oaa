## Quick Launch Scripts
These bash scripts are for quick launching NEUROBOT from workstation, to use this, you only need to make sure the
robt and the workstation are in the same local network.
### Prerequisites
1. Install expect
### Using it
1. `roscd neuro_oaa/bin`, which will make sure we are in the right working directory.
2. `./start_oaa.bash`, to start all functions of NEUROBOT.
3. `./start_vision.bash`, to start only the vision functions.
4. `./to_host.tcl`, to quick ssh to robot without input password. Nevertheless, you may need modify
the IP in it