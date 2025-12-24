local Graphic = require("game.components.Graphic")
local Position = require("game.components.Position")

local RenderingSystem = class {
  query = { Graphic, Position },

  process = function(_, entities)
    for _, entity in ipairs(entities) do
      love.graphics.draw(
        entity[Graphic].drawable,
        entity[Position].x,
        entity[Position].y,
        entity[Graphic].rotation
      )
    end
  end,
}

return RenderingSystem
