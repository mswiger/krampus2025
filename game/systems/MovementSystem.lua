local Position = require("game.components.Position")
local Velocity = require("game.components.Velocity")

local GravitySystem = class {
  query = { Position, Velocity },

  process = function(_, entities, _, dt)
    for _, entity in ipairs(entities) do
      entity[Position].x = entity[Position].x + (entity[Velocity].x * dt)
      entity[Position].y = entity[Position].y + (entity[Velocity].y * dt)
    end
  end,
}

return GravitySystem
