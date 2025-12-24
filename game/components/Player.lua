local function Player(player)
  local p = player or {}
  return {
    dead = p.dead or false
  }
end

return Player
