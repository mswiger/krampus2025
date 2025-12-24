local function Graphic(g)
  return {
    drawable = g.drawable,
    rotation = g.rotation or 0,
  }
end

return Graphic
