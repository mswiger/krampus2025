local constants = require("game.constants")

local Graphic = require("game.components.Graphic")
local Pipe = require("game.components.Pipe")
local Position = require("game.components.Position")
local Trash = require("game.components.Trash")

local TrashConstruct = require("game.constructs.TrashConstruct")

local TrashManagementSystem = class {
  query = {
    pipes = { Graphic, Pipe, Position },
    trash = { Graphic, Position, Trash },
  },

  init = function(self, assets)
    self.drawables = {
      assets:get("assets/apple.png"),
      assets:get("assets/chicken.png"),
      assets:get("assets/can.png"),
    }
  end,

  process = function(self, entities, commands, dt)
    local trash = entities.trash
    local pipes = entities.pipes

    for _, entity in ipairs(trash) do
      entity[Position].x = entity[Position].x + (constants.HORIZONTAL_VELOCITY * dt)
    end


    local lastPipeX = 0
    local lastPipeWidth = 0
    for _, entity in ipairs(pipes) do
      lastPipeWidth = entity[Graphic].drawable:getWidth()
      lastPipeX = math.max(lastPipeX, entity[Position].x + lastPipeWidth)
    end

    if constants.INTERNAL_RES_W - (lastPipeX + lastPipeWidth) >= constants.PIPE_INTERVAL then
      local spawnY = math.random(
        constants.PIPE_MIN_SIZE,
        constants.INTERNAL_RES_H - constants.PIPE_MIN_SIZE - constants.PIPE_GAP + 1
      )
      commands:spawn(TrashConstruct({
        x = constants.INTERNAL_RES_W + constants.PIPE_INTERVAL * 1.5,
        y = spawnY,
        drawable = self.drawables[math.random(1, #self.drawables)],
      }))
    end
  end
}

return TrashManagementSystem
