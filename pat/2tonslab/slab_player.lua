local paneCfg = { baseConfig = "/pat/2tonslab/window/slab.sussy" }

function init()
  local chance = root.assetJson("/pat/2tonslab/window/slab.sussy:initChance")
  if math.random() < chance then openPane() end

  local function setHandler(name, func, localOnly)
    message.setHandler(name, function(_, isLocal, ...)
      if localOnly and not isLocal then return end
      return func(...)
    end)
  end

  setHandler("pat_2tonslab_pane", openPane)
  setHandler("pat_2tonslab_paneClose", shouldClose, true)
  setHandler("pat_2tonslab_kill", killPlayer, true)
end

function openPane()
  paneCfg.uuid = sb.makeUuid()
  player.interact("ScriptPane", paneCfg)
end

function shouldClose(paneId)
  if not paneCfg.uuid then paneCfg.uuid = paneId end
  return paneId ~= paneCfg.uuid
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
