local function Graphic(g)
  if not g then
    error("Must supply a drawable when creating a Graphic component")
  end

  return {
    drawable = g.drawable,
    rotation = g.rotation or 0,
    layer = g.layer or 0,
  }
end

return Graphic
