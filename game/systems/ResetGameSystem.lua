local Pipe = require("game.components.Pipe")
local Player = require("game.components.Player")
local Score = require("game.components.Score")
local Text = require("game.components.Text")
local Trash = require("game.components.Trash")

local PlayerConstruct = require("game.constructs.PlayerConstruct")
local ScoreConstruct = require("game.constructs.ScoreConstruct")

local ResetGameSystem = class {
  query = {
    pipes = { Pipe },
    player = { Player },
    score = { Score },
    trash = { Trash },
    text = { Text },
  },

  init = function(self, assets)
    self.assets = assets
  end,

  process = function(self, entities, commands)
    local pipes = entities.pipes
    local player = entities.player[1]
    local score = entities.score[1]
    local text = entities.text
    local trash = entities.trash

    if not player or not score then
      return
    end

    commands:despawn(player)
    commands:despawn(score)

    for _, p in ipairs(pipes) do
      commands:despawn(p)
    end

    for _, t in ipairs(text) do
      commands:despawn(t)
    end

    for _, t in ipairs(trash) do
      commands:despawn(t)
    end

    commands:spawn(PlayerConstruct(self.assets))
    commands:spawn(ScoreConstruct(0))
  end
}

return ResetGameSystem
