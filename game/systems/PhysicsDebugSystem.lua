local Graphic = require("game.components.Graphic")
local Position = require("game.components.Position")

local function drawRotatedRectangle(mode, x, y, width, height, angle)
  local cosa, sina = math.cos(angle), math.sin(angle)

  local dx1, dy1 = width*cosa,   width*sina
  local dx2, dy2 = -height*sina, height*cosa

  local px1, py1 = x,         y
  local px2, py2 = x+dx1,     y+dy1
  local px3, py3 = x+dx1+dx2, y+dy1+dy2
  local px4, py4 = x+dx2,     y+dy2

  love.graphics.polygon(mode, px1,py1, px2,py2, px3,py3, px4,py4)
end

local PhysicsDebugSystem = class {
  query = { Graphic, Position },

  init = function(self, debug)
    self.debug = debug
  end,

  process = function(self, entities)
    if self.debug.physics == false then
      return
    end

    love.graphics.setColor(1, 0, 0)

    for _, entity in ipairs(entities) do
      drawRotatedRectangle(
        "line",
        entity[Position].x,
        entity[Position].y,
        entity[Graphic].drawable:getWidth(),
        entity[Graphic].drawable:getHeight(),
        entity[Graphic].rotation
      )
    end

    love.graphics.setColor(1, 1, 1, 1)
  end
}

return PhysicsDebugSystem
