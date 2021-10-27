function init()
	uuid = config.getParameter("uuid")
	
	canvYes = {c = widget.bindCanvas("yes"), data = true}
	canvNo = {c = widget.bindCanvas("no")}
	
	function canvYes:draw(p) draw(self.c, "yes", p) end
	function canvNo:draw(p) draw(self.c, "no", p) end
	
	canvYes:draw()
	canvNo:draw()
end

function update(dt)
	if uuid ~= player.getProperty("pat_2tonslab_uuid") then
		pane.dismiss()
	end
end

function draw(canvas, image, a)
	canvas:clear()
	canvas:drawImage("/pat/2tonslab/window/buttons.png:"..image..(a and "_push" or ""), {0, 0}, 0.2)
end

function hover(canvas)

end

function click(canvas, position, button, isButtonDown)
	if button ~= 0 then return end
	
	local size = canvas.c:size()
	local inButton = position[1] > 0 and position[1] <= size[1] and position[2] > 0 and position[2] <= size[2]
	
	if isButtonDown and inButton then
		pane.playSound("/pat/2tonslab/window/click.ogg", 0, 0.75)
	end
	
	if not isButtonDown or inButton then
		canvas:draw(isButtonDown)
		
		if not isButtonDown and canvas.lastButtonDown and inButton then
			if canvas.data then
				world.sendEntityMessage(player.id(), "pat_2tonslab", canvas.data)
			end
			pane.dismiss()
		end
		
		canvas.lastButtonDown = isButtonDown
	end
end

function clickYes(...) click(canvYes, ...) end
function clickNo(...) click(canvNo, ...) end
