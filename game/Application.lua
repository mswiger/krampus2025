local AssetManager = require("game.AssetManager")

local PlayerConstruct = require("game.constructs.PlayerConstruct")

local BoostSystem = require("game.systems.BoostSystem")
local GravitySystem = require("game.systems.GravitySystem")
local MovementSystem = require("game.systems.MovementSystem")
local RenderingSystem = require("game.systems.RenderingSystem")
local TweenSystem = require("game.systems.TweenSystem")

local Application = class {
  INTERNAL_RES_W = 480,
  INTERNAL_RES_H = 270,

  init = function(self)
    love.graphics.setDefaultFilter("nearest", "nearest")

    self.input = baton.new {
      controls = {
        boost = { "key:space" },
      },
    }

    self.assets = AssetManager()
    self.music = self.assets:get("assets/bgm.mp3")
    self.music:setLooping(true)
    self.music:play()

    local scaleFactor = math.min(
      love.graphics.getWidth() / self.INTERNAL_RES_W,
      love.graphics.getHeight() / self.INTERNAL_RES_H
    )
    self.camera = Camera(self.INTERNAL_RES_W / 2, self.INTERNAL_RES_H / 2, scaleFactor)

    self.cosmos = Cosmos()

    self.cosmos:addSystems("boost", BoostSystem())
    self.cosmos:addSystems("update", GravitySystem())
    self.cosmos:addSystems("update", MovementSystem())
    self.cosmos:addSystems("update", TweenSystem())
    self.cosmos:addSystems("draw", RenderingSystem())

    self.cosmos:spawn(PlayerConstruct(self.assets))
  end,

  update = function(self, dt)
    self.input:update()
    self.cosmos:emit("update", dt)

    if self.input:pressed("boost") then
      self.cosmos:emit("boost")
    end
  end,

  draw = function(self)
    love.graphics.clear(115 / 255, 239 / 255, 247 / 255)

    self.camera:attach()
    self.cosmos:emit("draw")
    self.camera:detach()
  end,
}

return Application
