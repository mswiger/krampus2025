local constants = require("game.constants")

local Graphic = require("game.components.Graphic")
local Pipe = require("game.components.Pipe")
local Player = require("game.components.Player")
local Position = require("game.components.Position")
local Trash = require("game.components.Trash")
local Velocity = require("game.components.Velocity")

local TextConstruct = require("game.constructs.TextConstruct")

local function getRotatedRectangle(x, y, width, height, angle)
  local cosa, sina = math.cos(angle), math.sin(angle)

  local dx1, dy1 = width*cosa,   width*sina
  local dx2, dy2 = -height*sina, height*cosa


  local px1, py1 = x,         y
  local px2, py2 = x+dx1,     y+dy1
  local px3, py3 = x+dx1+dx2, y+dy1+dy2
  local px4, py4 = x+dx2,     y+dy2

  local nx = math.min(px1, px2, px3, px4)
  local ny = math.min(py1, py2, py3, py4)

  return nx, ny, width, height
end

local DeathSystem = class {
  query = {
    player = { Graphic, Player, Position, Velocity },
    pipes = { Graphic, Pipe, Position },
    trash = { Graphic, Trash, Position },
  },

  init = function(self, assets)
    self.assets = assets
  end,

  process = function(self, entities, commands)
    local player = entities.player[1]
    local pipes = entities.pipes
    local trash = entities.trash

    if not player or player[Player].dead then
      return
    end

    local playerBB = {
      x1 = player[Position].x,
      x2 = player[Position].x + player[Graphic].drawable:getWidth(),
      y1 = player[Position].y,
      y2 = player[Position].y + player[Graphic].drawable:getHeight(),
    }

    if playerBB.y1 < 0 or playerBB.y2 > constants.INTERNAL_RES_H then
      self:killPlayer(player, commands)
    end

    for _, pipe in ipairs(pipes) do
      local x, y, w, h = getRotatedRectangle(
        pipe[Position].x,
        pipe[Position].y,
        pipe[Graphic].drawable:getWidth(),
        pipe[Graphic].drawable:getHeight(),
        pipe[Graphic].rotation
      )

      local pipeBB = {
        x1 = x,
        x2 = x + w,
        y1 = y,
        y2 = y + h,
      }

      if (
        (playerBB.x1 >= pipeBB.x1 and playerBB.x1 <= pipeBB.x2 and playerBB.y1 >= pipeBB.y1 and playerBB.y1 <= pipeBB.y2) or
        (playerBB.x2 >= pipeBB.x1 and playerBB.x2 <= pipeBB.x2 and playerBB.y1 >= pipeBB.y1 and playerBB.y1 <= pipeBB.y2) or
        (playerBB.x2 >= pipeBB.x1 and playerBB.x2 <= pipeBB.x2 and playerBB.y2 >= pipeBB.y1 and playerBB.y2 <= pipeBB.y2) or
        (playerBB.x1 >= pipeBB.x1 and playerBB.x1 <= pipeBB.x2 and playerBB.y2 >= pipeBB.y1 and playerBB.y2 <= pipeBB.y2)
      ) then
        self:killPlayer(player, commands)
      end
    end

    for _, t in ipairs(trash) do
      if t[Position].x + t[Graphic].drawable:getWidth() < 0 then
        self:killPlayer(player, commands)
      end
    end
  end,

  killPlayer = function(self, player, commands)
    player[Player].dead = true
    player[Velocity].x = 0
    player[Velocity].y = constants.TERMINAL_VELOCITY
    self.assets:get("assets/boom.mp3"):play()
    commands:spawn(TextConstruct({
      value = "Game Over\nPress F5 to try again!",
      align = "center",
      x = 0,
      y = constants.INTERNAL_RES_H / 2,
      color = { 1, 0, 0, 1 },
    }))
  end,
}

return DeathSystem
