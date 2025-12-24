local constants = require("game.constants")

local Graphic = require("game.components.Graphic")
local Pipe = require("game.components.Pipe")
local Player = require("game.components.Player")
local Position = require("game.components.Position")

local PipeConstruct = require("game.constructs.PipeConstruct")

local PipeSystem = class {
  query = {
    pipes = { Graphic, Pipe, Position },
    player = { Player },
  },

  init = function(self, assets)
    self.drawable = assets:get("assets/pipe.png")
  end,

  process = function(self, entities, commands, dt)
    local player = entities.player[1]

    if not player or player[Player].dead then
      return
    end

    local lastPipeX = 0
    for _, entity in ipairs(entities.pipes) do
      entity[Position].x = entity[Position].x + (constants.HORIZONTAL_VELOCITY * dt)
      lastPipeX = math.max(lastPipeX, entity[Position].x + self.drawable:getWidth())
    end

    if constants.INTERNAL_RES_W - (lastPipeX + self.drawable:getWidth()) >= constants.PIPE_INTERVAL then
      local spawnY = math.random(
        constants.PIPE_MIN_SIZE,
        constants.INTERNAL_RES_H - constants.PIPE_MIN_SIZE - constants.PIPE_GAP
      )
      commands:spawn(PipeConstruct({
        x = constants.INTERNAL_RES_W + self.drawable:getWidth(),
        y = spawnY,
        drawable = self.drawable,
        rotation = math.pi
      }))
      commands:spawn(PipeConstruct({
        x = constants.INTERNAL_RES_W,
        y = spawnY + constants.PIPE_GAP,
        drawable = self.drawable
      }))
    end
  end
}

return PipeSystem
