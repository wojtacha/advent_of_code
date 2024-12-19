local filereader = require("filereader")
local multices = require("multices")

local reader = filereader:new("test.txt")

local underconstruction = nil
local tabwithmultiplexes = {}

local function summary(t)
  local sum = 0
  for _, v in pairs(t) do
    sum = sum + v
  end

  return sum
end

local dupa = function(char)
  local state = ""
  if not underconstruction then
    if char == "m" then
      underconstruction = multices:new()
      state = underconstruction:expects(char)
    end
  else
    state = underconstruction:expects(char)
  end

  if state == "break" then
    underconstruction = nil
  end

  if state == "done" then
    local value = 0
    if underconstruction then
      value = underconstruction:done()
      underconstruction = nil
    end
    table.insert(tabwithmultiplexes, value)
  end
end

reader:read(dupa)

print(summary(tabwithmultiplexes))
