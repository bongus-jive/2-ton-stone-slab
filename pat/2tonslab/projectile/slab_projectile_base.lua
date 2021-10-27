function init()
	local vel = config.getParameter("_velocity")
	if vel then
		mcontroller.setVelocity(vel)
	end
end

function processAction(action)
	for _,a in ipairs(action) do
		if a.action == "projectile" and a.keepVelocity then
			a.config = a.config or {}
			a.config._velocity = mcontroller.velocity()
		end
		
		projectile.processAction(a)
	end
end

function bounce()
	if not collided then
		collided = true
		processAction(config.getParameter("actionOnCollision", {}))
	end
end