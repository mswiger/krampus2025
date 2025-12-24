local function Velocity(velocity)
  return {
    x = velocity.x or 0,
    y = velocity.y or 0,
  }
end

return Velocity
