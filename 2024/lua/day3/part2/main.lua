local filereader = require("filereader")
local multices = require("multices")
local DoDont = require("dodont")

local reader = filereader:new("test.txt")
local underconstruction = nil
local numberstable = {}
local enabled = true

local function summary(t)
  local sum = 0
  for _, v in pairs(t) do
    sum = sum + v
  end

  return sum
end

local memoryreader = function(char)
  enabled = DoDont.eval(char)

  if enabled then
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

      table.insert(numberstable, value)
    end
  else
    underconstruction = nil
  end
end

reader:read(memoryreader)

print(summary(numberstable))
