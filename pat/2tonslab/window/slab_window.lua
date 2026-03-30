local uuid

function init()
  uuid = config.getParameter("uuid")

  ButtonYes = CanvasButton:new("buttonYes", clickYes)
  ButtonNo = CanvasButton:new("buttonNo", pane.dismiss)
end

function update()
  local pid = player.id()
  if pid == 0 or world.sendEntityMessage(pid, "pat_2tonslab_paneClose", uuid):result() then
    pane.dismiss()
  end

  ButtonYes:update()
  ButtonNo:update()
  CanvasButton.screenPosition = nil
end

function cursorOverride(screenPosition)
  CanvasButton.screenPosition = screenPosition
end

function clickYes()
  local pid = player.id()
  local pos = world.entityPosition(pid)
  if pos then
    pos[2] = math.min(pos[2] + 150, world.size()[2] - 1)
    world.spawnProjectile("pat_2tonslab", pos, pid, nil, nil, { myNuts = math.huge })
  end

  pane.dismiss()
end

CanvasButton = {}
function CanvasButton:new(widgetName, callback)
  local new = setmetatable({}, { __index = self })

  new.widgetName = widgetName
  new.callback = callback
  new.canvas = widget.bindCanvas(widgetName)

  local data = widget.getData(widgetName)
  new.images = data.images

  new.CanvasClick = function(...) new:click(...) end

  return new
end

function CanvasButton:update()
  local hovering = self.screenPosition and widget.inMember(self.widgetName, self.screenPosition)

  if not hovering and self.pressed then self.pressed = false end
  
  local image = self.images.base
  if self.pressed then
    image = self.images.press
  elseif hovering then
    image = self.images.hover
  end

  self.canvas:clear()
  self.canvas:drawImage(image, {0, 0}, self.images.scale)
end

function CanvasButton:click(_, button, down)
  if button ~= 0 then return end

  if down then
    pane.playSound("/pat/2tonslab/window/click.ogg", 0, 0.75)
    self.pressed = true
  elseif self.pressed then
    self.callback()
    self.pressed = false
  end
end
