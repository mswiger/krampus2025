local constants = require("game.constants")
local lerp = require("game.util.lerp")

local Graphic = require("game.components.Graphic")
local Velocity = require("game.components.Velocity")

local TweenSystem = class {
  query = { Graphic, Velocity },

  process = function(_, entities, _, dt)
    for _, entity in ipairs(entities) do
      entity[Graphic].rotation = lerp(
        entity[Graphic].rotation,
        (entity[Velocity].y / constants.TERMINAL_VELOCITY) * (math.pi / 2),
        dt
      )
    end
  end,
}

return TweenSystem
