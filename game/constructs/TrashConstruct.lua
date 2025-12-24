local Graphic = require("game.components.Graphic")
local Trash = require("game.components.Trash")
local Position = require("game.components.Position")

local function TrashConstruct(trash)
  local p = trash or {}
  return Construct {
    [Graphic] = { drawable = p.drawable },
    [Trash] = true,
    [Position] = { x = p.x, y = p.y },
  }
end

return TrashConstruct
