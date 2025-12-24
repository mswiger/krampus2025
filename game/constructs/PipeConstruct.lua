local Graphic = require("game.components.Graphic")
local Pipe = require("game.components.Pipe")
local Position = require("game.components.Position")

local function PipeConstruct(pipe)
  local p = pipe or {}
  return Construct {
    [Graphic] = { drawable = p.drawable, rotation = p.rotation },
    [Pipe] = true,
    [Position] = { x = p.x, y = p.y },
  }
end

return PipeConstruct
