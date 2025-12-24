local Position = require("game.components.Position")
local Text = require("game.components.Text")

local function TextConstruct(text)
  local t = text or {}
  return Construct {
    [Text] = {
      value = t.value,
      size = t.size,
      color = t.color,
      limit = t.limit,
      align = t.align,
    },
    [Position] = { x = t.x, y = t.y },
  }
end

return TextConstruct
