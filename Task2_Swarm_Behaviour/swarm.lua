-- Initialize robot: Set wheel velocities to zero at startup
function init()
	robot.wheels.set_velocity(0, 0)
end

-- Reset function: Reinitialize robot to starting state
function reset()
	init()
end

-- Cleanup function: Called when robot is destroyed
function destroy() end

-- Main control loop: Executed at each time step
function step()
	-- Initialize velocity components
	local speed = 0      -- Forward/backward force accumulator
	local steering = 0   -- Left/right turning force accumulator

	-- Iterate through all detected neighbors via Range and Bearing sensor
	for i = 1, #robot.range_and_bearing do
		local range = robot.range_and_bearing[i].range                    -- Distance to neighbor (cm)
		local angle = robot.range_and_bearing[i].horizontal_bearing       -- Bearing angle to neighbor (radians)

		-- Calculate attraction/repulsion force based on distance
		local attraction = 0
		if range > 60 then
			-- Attraction Zone: Pull towards distant neighbors (cohesion)
			attraction = 20
		elseif range < 40 then
			-- Repulsion Zone: Push away from close neighbors (collision avoidance)
			attraction = -80
		end
		-- Neutral Zone (40-60 cm): No force applied (equilibrium distance)

		-- Convert polar coordinates (range, angle) to Cartesian velocity components
		speed = speed + attraction * math.cos(angle)        -- Forward/backward component
		steering = steering + attraction * math.sin(angle)  -- Left/right component
	end

	-- Calculate differential wheel velocities
	-- Base speed is modulated by accumulated forces
	local base_speed = 10 + speed * 0.2
	robot.wheels.set_velocity(base_speed - steering, base_speed + steering)
end
