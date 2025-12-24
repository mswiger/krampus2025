local Graphic = require("game.components.Graphic")
local Position = require("game.components.Position")

local function PlayerConstruct(assets)
  return Construct {
    [Graphic] = assets:get("assets/raccoon.png"),
    [Position] = { x = 32, y = 120 },
  }
end

return PlayerConstruct
