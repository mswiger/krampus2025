local function Position(pos)
  local p = pos or {
    x = 0,
    y = 0,
  }
  return {
    x = p.x,
    y = p.y,
  }
end

return Position
