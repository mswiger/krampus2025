local constants = require("game.constants")

local Player = require("game.components.Player")
local Velocity = require("game.components.Velocity")

local BoostSystem = class {
  query = { Player, Velocity },

  init = function(self, assets)
    self.sound = assets:get("assets/boost.ogg")
  end,

  process = function(self, entities)
    local player = entities[1]

    if not player or player[Player].dead then
      return
    end

    player[Velocity].y = constants.BOOST_AMOUNT
    love.audio.play(self.sound:clone())
  end,
}

return BoostSystem
