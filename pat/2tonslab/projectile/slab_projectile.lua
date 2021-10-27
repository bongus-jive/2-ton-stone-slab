require "/pat/2tonslab/projectile/slab_projectile_base.lua"

function init()
	projectile.setPower(config.getParameter("myNuts", 0))
	
	target = projectile.sourceEntity()
	if not target then projectile.die() end
end

function update(dt)
	if world.entityExists(target) then
		local tpos = world.entityPosition(target)
		mcontroller.setXPosition(tpos[1])
		
		if targetHit or tpos[2] + 1 > mcontroller.position()[2] then
			if not targetHit then
				targetHit = true
				hitAction()
				world.sendEntityMessage(target, "pat_2tonslab", "kill")
			end
		else
			projectile.setTimeToLive(1.5)
		end
	end
end

function hit(id)
	if id == target and not targetHit then
		targetHit = true
		hitAction()
	end
end

function hitAction()
	processAction(config.getParameter("actionOnHitTarget", {}))
	projectile.die()
end
