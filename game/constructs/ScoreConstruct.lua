local Score = require("game.components.Score")

local TextConstruct = require("game.constructs.TextConstruct")

local function ScoreConstruct(score)
  return Construct {
    [Score] = score,
    TextConstruct {
      value = string.format("%d", score),
      color = { 1, 0, 0, 1 },
      align = "center",
      size = 12,
      x = 0,
      y = 0,
    },
  }
end

return ScoreConstruct
