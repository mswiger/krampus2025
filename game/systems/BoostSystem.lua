local constants = require("game.constants")

local Player = require("game.components.Player")
local Velocity = require("game.components.Velocity")

local BoostSystem = class {
  query = { Player, Velocity },

  process = function(_, entities)
    local player = entities[1]

    if not player then
      return
    end

    player[Velocity].y = constants.BOOST_AMOUNT
  end,
}

return BoostSystem
