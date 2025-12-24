local Position = require("game.components.Position")
local Text = require("game.components.Text")

local TextRenderingSystem = class {
  query = { Position, Text },

  init = function(self, assets)
    self.assets = assets
  end,

  process = function(self, entities)
    for _, entity in ipairs(entities) do
      love.graphics.setFont(self.assets:get("assets/bitstream-vera-mono.ttf", entity[Text].size))
      love.graphics.setColor(unpack(entity[Text].color))
      love.graphics.printf(entity[Text].value, entity[Position].x, entity[Position].y, entity[Text].limit, entity[Text].align)
      love.graphics.setColor(1, 1, 1, 1)
    end
  end,
}

return TextRenderingSystem
