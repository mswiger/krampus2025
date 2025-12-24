local clamp = require("game.util.clamp")

local Graphic = require("game.components.Graphic")
local Velocity = require("game.components.Velocity")

local GravitySystem = class {
  GRAVITY = 0.01,
  TERMINAL_VELOCITY = 2,

  query = { Graphic, Velocity },

  process = function(self, entities)
    for _, entity in ipairs(entities) do
      entity[Velocity].y = clamp(entity[Velocity].y + self.GRAVITY, -self.TERMINAL_VELOCITY, self.TERMINAL_VELOCITY)
      entity[Graphic].rotation = (entity[Velocity].y / self.TERMINAL_VELOCITY) * (math.pi / 2)
    end
  end,
}

return GravitySystem
