local AssetManager = require("game.AssetManager")

local Application = class {
  init = function(self)
    love.graphics.setDefaultFilter("nearest", "nearest")

    self.assets = AssetManager()
    self.cosmos = Cosmos()
  end,

  update = function(self, dt)
    self.cosmos:emit("update", dt)
  end,

  draw = function(self)
  end,
}

return Application
