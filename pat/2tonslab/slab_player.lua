function init()
  openPane()

  local function setHandler(name, func, localOnly)
    message.setHandler(name, function(_, isLocal, ...)
      if localOnly and not isLocal then return end
      return func(...)
    end)
  end

  setHandler("pat_2tonslab_pane", openPane)
  setHandler("pat_2tonslab_spawn", spawnSlab, true)
  setHandler("pat_2tonslab_kill", killPlayer, true)
end

function openPane()
  local uuid = sb.makeUuid()
  math.pat_2tonslab_uuid = uuid

  local pane = root.assetJson("/pat/2tonslab/window/slab.sussy")
  pane.uuid = uuid
  player.interact("ScriptPane", pane)
end

function spawnSlab()
  local pos = mcontroller.position()
  pos[2] = math.min(pos[2] + 150, world.size()[2] - 1)
  world.spawnProjectile("pat_2tonslab", pos, player.id(), nil, nil, { myNuts = math.huge })
end

function killPlayer()
  status.applySelfDamageRequest({
    damage = status.resourceMax("health"),
    damageType = "IgnoresDef",
    damageSourceKind = "hammer",
    sourceEntityId = player.id()
  })

  status.addPersistentEffect("pat_2tonslab", { stat = "maxHealth", effectiveMultiplier = 0 })
  status.clearPersistentEffects("pat_2tonslab")
end
