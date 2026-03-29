function init()
  status.clearPersistentEffects("die")
  
  slabPane()
  message.setHandler("pat_2tonslab_pane", slabPane)

  message.setHandler("pat_2tonslab", function(_, isLocal, a)
    if isLocal then
      if a == "spawn" then
        local m = mcontroller.position()
        local y = math.min(m[2] + 150, world.size()[2] - 1)
        
        world.spawnProjectile("pat_2tonslab", {m[1], y}, player.id(), {0,0}, false, {myNuts = math.huge})
        
      elseif a == "kill" then
        status.applySelfDamageRequest({
          damage = status.resourceMax("health"),
          damageType = "IgnoresDef",
          damageSourceKind = "hammer",
          sourceEntityId = player.id()
        })
        status.addEphemeralEffect("pat_2tonslab_effect")
      end
    end
  end)
end

function slabPane()
  local uuid = sb.makeUuid()
  math.pat_2tonslab_uuid = uuid
  
  pane = root.assetJson("/pat/2tonslab/window/slab.sussy")
  pane.uuid = uuid
  player.interact("ScriptPane", pane)
end
