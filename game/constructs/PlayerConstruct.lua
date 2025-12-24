local Graphic = require("game.components.Graphic")
local Position = require("game.components.Position")
local Velocity = require("game.components.Velocity")

local function PlayerConstruct(assets)
  return Construct {
    [Graphic] = {
      drawable = assets:get("assets/raccoon.png"),
      rotation = 0,
    },
    [Position] = { x = 32, y = 120 },
    [Velocity] = { x = 0, y = 0 },
  }
end

return PlayerConstruct
