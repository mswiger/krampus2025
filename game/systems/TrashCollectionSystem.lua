local constants = require("game.constants")

local Graphic = require("game.components.Graphic")
local Player = require("game.components.Player")
local Position = require("game.components.Position")
local Score = require("game.components.Score")
local Text = require("game.components.Text")
local Trash = require("game.components.Trash")
local Velocity = require("game.components.Velocity")

local TrashCollectionSystem = class {
  query = {
    player = { Graphic, Player, Position, Velocity },
    score = { Score, Text },
    trash = { Graphic, Trash, Position }
  },

  init = function(self, assets)
    self.assets = assets
  end,

  process = function(self, entities, commands)
    local player = entities.player[1]
    local score = entities.score[1]
    local trash = entities.trash

    if not player or player[Player].dead or not score then
      return
    end

    local playerBB = {
      x1 = player[Position].x,
      x2 = player[Position].x + player[Graphic].drawable:getWidth(),
      y1 = player[Position].y,
      y2 = player[Position].y + player[Graphic].drawable:getHeight(),
    }

    for _, t in ipairs(trash) do
      local trashBB = {
        x1 = t[Position].x - constants.TRASH_LEEWAY,
        x2 = t[Position].x + t[Graphic].drawable:getWidth() + (constants.TRASH_LEEWAY * 2),
        y1 = t[Position].y - constants.TRASH_LEEWAY,
        y2 = t[Position].y + t[Graphic].drawable:getHeight() + (constants.TRASH_LEEWAY * 2),
      }

      if (
        (playerBB.x1 >= trashBB.x1 and playerBB.x1 <= trashBB.x2 and playerBB.y1 >= trashBB.y1 and playerBB.y1 <= trashBB.y2) or
        (playerBB.x2 >= trashBB.x1 and playerBB.x2 <= trashBB.x2 and playerBB.y1 >= trashBB.y1 and playerBB.y1 <= trashBB.y2) or
        (playerBB.x2 >= trashBB.x1 and playerBB.x2 <= trashBB.x2 and playerBB.y2 >= trashBB.y1 and playerBB.y2 <= trashBB.y2) or
        (playerBB.x1 >= trashBB.x1 and playerBB.x1 <= trashBB.x2 and playerBB.y2 >= trashBB.y1 and playerBB.y2 <= trashBB.y2)
      ) then
        commands:despawn(t)
        self.assets:get("assets/crunch.ogg"):play()
        score[Score] = score[Score] + 1
        score[Text].value = string.format("%d", score[Score])
      end
    end

  end,
}

return TrashCollectionSystem
