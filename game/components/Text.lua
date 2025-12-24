local constants = require("game.constants")

local function Text(text)
  local t = text or {}
  return {
    value = t.value or "",
    size = t.size or 12,
    color = t.color or { 1, 1, 1 },
    limit = t.limit or constants.INTERNAL_RES_W,
    align = t.align or "left"
  }
end

return Text
