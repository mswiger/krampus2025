local Graphic = require("game.components.Graphic")
local Player = require("game.components.Player")
local Position = require("game.components.Position")
local Velocity = require("game.components.Velocity")

local function PlayerConstruct(assets)
  local startX = 32
  local startY = 120
  local drawable = assets:get("assets/raccoon.png")

  return Construct {
    [Graphic] = {
      drawable = drawable,
      rotation = 0,
      layer = 1,
    },
    [Player] = { dead = false },
    [Position] = { x = startX, y = startY },
    [Velocity] = { x = 0, y = 0 },
  }
end

return PlayerConstruct
