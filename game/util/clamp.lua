local function clamp(v, min, max)
  return math.min(math.max(v, min), max)
end

return clamp
