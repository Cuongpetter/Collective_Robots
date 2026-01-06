# Collective Robots Project

For support the learning Collective Robots course, this project demonstrates two robotics tasks using simulation and autonomous control:

## Task 1: Autonomous SLAM & Mapping (TurtleBot3)
- Uses ROS 2 and Gazebo to simulate a TurtleBot3 robot.
- The robot autonomously explores an environment, avoids obstacles using Lidar, and builds a 2D map with Cartographer SLAM.
- The system automatically saves the generated map files when mapping is complete.

## Task 2: Swarm Aggregation & Flocking (ARGoS)
- Implements scalable swarm behavior in the ARGoS simulator.
- Robots use simple attraction and repulsion rules to aggregate and disperse, resulting in cohesive group movement.
- The control logic is written in Lua and demonstrates force-field based interaction among agents.