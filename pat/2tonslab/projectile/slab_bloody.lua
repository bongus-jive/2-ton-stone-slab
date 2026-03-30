function init()
  local vel = config.getParameter("startVelocity")
  if not vel then return end
  mcontroller.setVelocity(vel)
end
