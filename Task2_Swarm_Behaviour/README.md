# Swarm Robotics Task 2: Scalable Aggregation & Flocking Behavior

## 📖 Project Overview
This project implements a scalable **Swarm Aggregation and Dispersion behavior** using the ARGoS simulator. The simulation demonstrates how simple local interaction rules (Attraction and Repulsion) applied to individual agents can result in complex, cohesive global group behavior.

## 📂 Project Structure
* **`swarm.lua`**: The control logic script.
* **`simulation.argos`**: The XML configuration file for the ARGoS simulator.

## 🧠 Behavior Logic
The swarm behavior is based on a **Force-Field / Virtual Physics** approach. Each robot calculates a resultant velocity vector by summing "forces" exerted by its neighbors detected via the Range and Bearing sensor.

### 1. Perception
Each robot scans its environment for neighbors using the `robot.range_and_bearing` sensor. It iterates through every detected neighbor to calculate a cumulative response.

### 2. Interaction Rules (Attraction & Repulsion)
For every neighbor detected, the robot applies a force based on distance:
* **Repulsion Zone (< 40cm):** If a neighbor is too close, a strong negative force (`-80`) is applied to prevent collisions (Dispersion).
* **Neutral Zone (40cm - 60cm):** No specific force is applied, allowing for a stable equilibrium distance between agents.
* **Attraction Zone (> 60cm):** If a neighbor is far away, a positive force (`20`) is applied to draw the robot closer (Aggregation/Cohesion).

### 3. Motion Control
The robot converts these polar coordinates (range and angle) into Cartesian vectors (`speed` and `steering`) using trigonometry:

```lua
speed = speed + attraction * math.cos(angle)
steering = steering + attraction * math.sin(angle)
```

Finally, a base speed is modulated by these accumulated forces to set the differential wheel velocities:

```lua
local base_speed = 10 + speed * 0.2
robot.wheels.set_velocity(base_speed - steering, base_speed + steering)
```

---

## ⚙️ Configuration Details
- **Robot Quantity:** 80 Entities.
- **Environment:** 200x200x1 meter arena with a standard distribution.
- **Sensors:** Range and Bearing (RAB) sensor with a range of 3.0 meters.
- **Controller:** Lua Controller linked to `swarm.lua`.

---

## 🚀 How to Run
Ensure **ARGoS3** is installed on your system.

```bash
argos3 -c simulation.argos
```