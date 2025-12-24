local clamp = require("game.util.clamp")
local constants = require("game.constants")

local Velocity = require("game.components.Velocity")

local GravitySystem = class {
  query = { Velocity },

  process = function(_, entities, _, dt)
    for _, entity in ipairs(entities) do
      entity[Velocity].y = clamp(
        entity[Velocity].y + (constants.GRAVITY * dt),
        -constants.TERMINAL_VELOCITY,
        constants.TERMINAL_VELOCITY
      )
    end
  end,
}

return GravitySystem
