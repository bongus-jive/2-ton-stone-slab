local targetId
local targetHit = false

function init()
  projectile.setPower(config.getParameter("myNuts", 0))
  
  targetId = projectile.sourceEntity()
  if not targetId then projectile.die() end
end

function update()
  if targetHit then return end
  
  local targetPos = world.entityPosition(targetId)
  if not targetPos then return end
  
  mcontroller.setXPosition(targetPos[1])
  projectile.setTimeToLive(1)

  local pos = mcontroller.position()
  if targetPos[2] + 1 > pos[2] then
    hitTarget()
  end
end

function hit(id)
  if id == targetId then hitTarget() end
end

function hitTarget()
  if targetHit then return end
  targetHit = true

  world.spawnProjectile("pat_2tonslab_blood", mcontroller.position(), targetId, nil, nil, { startVelocity = mcontroller.velocity() })
  world.sendEntityMessage(targetId, "pat_2tonslab_kill")
  projectile.die()
end
