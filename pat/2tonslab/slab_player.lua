function init()
	status.clearPersistentEffects("die")
	
	uuid = sb.makeUuid()
	player.setProperty("pat_2tonslab_uuid", uuid)
	
	pane = root.assetJson("/pat/2tonslab/window/slab.sussy")
	pane.uuid = uuid
	player.interact("ScriptPane", pane)

	message.setHandler("pat_2tonslab", function(_, isLocal, a)
		if isLocal then
			if a == true then
				local m = mcontroller.position()
				local y = math.min(m[2] + 150, world.size()[2] - 1)
				
				world.spawnProjectile("pat_2tonslab", {m[1], y}, player.id(), {0,0}, false, {myNuts = math.huge})
				
			elseif a == "kill" then
				status.setPersistentEffects("die", {{stat = "maxHealth", effectiveMultiplier = 0}})
			end
		end
	end)
end
