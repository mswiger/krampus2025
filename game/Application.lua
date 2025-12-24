local AssetManager = require("game.AssetManager")
local constants = require("game.constants")

local PlayerConstruct = require("game.constructs.PlayerConstruct")
local ScoreConstruct = require("game.constructs.ScoreConstruct")

local BoostSystem = require("game.systems.BoostSystem")
local DeathSystem = require("game.systems.DeathSystem")
local GravitySystem = require("game.systems.GravitySystem")
local MovementSystem = require("game.systems.MovementSystem")
local RenderingSystem = require("game.systems.RenderingSystem")
local ResetGameSystem = require("game.systems.ResetGameSystem")
local PhysicsDebugSystem = require("game.systems.PhysicsDebugSystem")
local PipeSystem = require("game.systems.PipeSystem")
local TextRenderingSystem = require("game.systems.TextRenderingSystem")
local TrashCollectionSystem = require("game.systems.TrashCollectionSystem")
local TrashManagementSystem = require("game.systems.TrashManagementSystem")
local TweenSystem = require("game.systems.TweenSystem")

local Application = class {
  init = function(self)
    math.randomseed(os.time())

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setDefaultFilter("nearest", "nearest")

    self.debug = {
      physics = false,
    }

    self.input = baton.new {
      controls = {
        boost = { "key:space" },
        reset = { "key:f5" },
        debugPhysics = { "key:f9" },
        toggleFullscreen = { "key:f11" },
      },
    }

    self.assets = AssetManager()
    self.music = self.assets:get("assets/bgm.mp3")
    self.music:setLooping(true)
    self.music:play()

    local scaleFactor = math.min(
      love.graphics.getWidth() / constants.INTERNAL_RES_W,
      love.graphics.getHeight() / constants.INTERNAL_RES_H
    )
    self.camera = Camera(constants.INTERNAL_RES_W / 2, constants.INTERNAL_RES_H / 2, scaleFactor)

    self.cosmos = Cosmos()

    self.cosmos:addSystems("boost", BoostSystem(self.assets))
    self.cosmos:addSystems("reset", ResetGameSystem(self.assets))
    self.cosmos:addSystems("update", DeathSystem(self.assets))
    self.cosmos:addSystems("update", GravitySystem())
    self.cosmos:addSystems("update", MovementSystem())
    self.cosmos:addSystems("update", PipeSystem(self.assets))
    self.cosmos:addSystems("update", TrashCollectionSystem(self.assets))
    self.cosmos:addSystems("update", TrashManagementSystem(self.assets))
    self.cosmos:addSystems("update", TweenSystem())
    self.cosmos:addSystems("draw", RenderingSystem())
    self.cosmos:addSystems("draw", TextRenderingSystem(self.assets))
    self.cosmos:addSystems("draw", PhysicsDebugSystem(self.debug))

    self.cosmos:spawn(PlayerConstruct(self.assets))
    self.cosmos:spawn(ScoreConstruct(0))
  end,

  update = function(self, dt)
    if love.keyboard.isDown("escape") then
      love.event.quit()
    end

    self.input:update()
    self.cosmos:emit("update", dt)

    if self.input:pressed("boost") then
      self.cosmos:emit("boost")
    end

    if self.input:pressed("reset") then
      self.cosmos:emit("reset")
    end

    if self.input:pressed("debugPhysics") then
      self.debug.physics = not self.debug.physics
    end

    if self.input:pressed("toggleFullscreen") then
      w, h, flags = love.window.getMode()
      love.window.setMode(w, h, { fullscreen = not flags.fullscreen })

      local scaleFactor = math.min(
        love.graphics.getWidth() / constants.INTERNAL_RES_W,
        love.graphics.getHeight() / constants.INTERNAL_RES_H
      )
      self.camera = Camera(constants.INTERNAL_RES_W / 2, constants.INTERNAL_RES_H / 2, scaleFactor)
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
