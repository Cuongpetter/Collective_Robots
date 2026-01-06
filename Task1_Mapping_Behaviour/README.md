# TurtleBot3 Autonomous SLAM & Mapping

## 📖 Project Overview
This project implements an autonomous navigation and mapping system using **ROS 2 Humble** and **TurtleBot3** in a custom **Gazebo** simulation.

The robot autonomously explores the environment using Lidar sensor data to avoid obstacles while simultaneously building a 2D map using the **Cartographer** SLAM algorithm. The system includes an auto-save feature that preserves the generated map immediately upon completion.

**Key Features:**
* **Autonomous Navigation:** Logic-based obstacle avoidance using Lidar.
* **SLAM Mapping:** Real-time 2D map generation.
* **Auto-Save:** Automatically saves map files (`.pgm` and `.yaml`) when the script stops.

## ⚙️ Environment Configuration

### Prerequisites
* **OS:** Ubuntu 22.04 (WSL2 recommended for Windows users)
* **ROS Distribution:** ROS 2 Humble Hawksbill
* **Required Packages:**
    ```bash
    sudo apt install ros-humble-turtlebot3-gazebo \
                     ros-humble-turtlebot3-cartographer \
                     ros-humble-nav2-map-server
    ```

### Environment Variables
Add these lines to your `~/.bashrc` file to ensure the simulation loads the correct robot model and plugins every time:

```bash
source /opt/ros/humble/setup.bash
export TURTLEBOT3_MODEL=burger
export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:/opt/ros/humble/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ros/humble/lib
```

After saving, run `source ~/.bashrc` to apply changes.

---

## 🚀 How to Run the Project
You will need **3 separate terminals**.

### Step 1: Launch Simulation
Opens Gazebo and loads your custom world file.

```bash
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py world:=~/Task1/project_world
```

**Note:** In case the TurtleBot3 Burger failed loading into the simulation world, open a new terminal and run this code:

```bash
ros2 run gazebo_ros spawn_entity.py -entity burger -file /opt/ros/humble/share/turtlebot3_gazebo/models/turtlebot3_burger/model.sdf -x -2.0 -y -0.5 -z 0.01
```

### Step 2: Start SLAM (Mapping)
Starts the mapping node.

```bash
ros2 launch turtlebot3_cartographer cartographer.launch.py use_sim_time:=True
```

### Step 3: Run Autonomous Drive & Save
Starts the Python script that drives the robot.

```bash
python3 ~/Task1/auto_drive_save.py
```

---

## 💾 Saving the Map
1. Let the robot explore until the map looks complete in RViz.
2. Go to the **Step 3** terminal.
3. Press `Ctrl + C`.
4. The script will automatically save `my_auto_map.pgm` and `my_auto_map.yaml` to your project folder before exiting.

---

## 📂 Files Included
- `auto_drive_save.py`: Python file for TurtleBot3 driving and Map saving.
- `project_world`: Gazebo world file.
- `my_auto_map.pgm` / `.yaml`: The generated map files.