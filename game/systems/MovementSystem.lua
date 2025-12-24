local Position = require("game.components.Position")
local Velocity = require("game.components.Velocity")

local GravitySystem = class {
  query = { Position, Velocity },

  process = function(_, entities)
    for _, entity in ipairs(entities) do
      entity[Position].x = entity[Position].x + entity[Velocity].x
      entity[Position].y = entity[Position].y + entity[Velocity].y
    end
  end,
}

return GravitySystem
