## Quick Launch Scripts
These bash scripts are for quick launching NEUROBOT from workstation, to use this, you only need to make sure the
robt and the workstation are in the same local network.
### Prerequisites
1. Install expect
2. It is recommended that we add neuro/bin to $PATH, so that we can run scripts by name (without ./ before that).
Otherwise, you may need to `roscd neuro/bin` and run the code with `./`.
3. Change the permission if necessary. For example: `chmod u+x start_oaa.bash`
### Using it
1. `./start_oaa.bash`, to start all functions of NEUROBOT.
2. `./start_vision.bash`, to start only the vision functions.
3. `./to_host.tcl`, to quick ssh to robot without input password. Nevertheless, you may need modify
the IP in it