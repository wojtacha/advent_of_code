local M = {}

local phrase = {}
local evalBoolean = true

local function printTable(tbl, indent)
  indent = indent or 0
  for k, v in pairs(tbl) do
    local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
    if type(v) == "table" then
      print(formatting)
      printTable(v, indent + 1)
    else
      print(formatting .. tostring(v))
    end
  end
end

function M.eval(char)
  if next(phrase) ~= nil then
    table.insert(phrase, char)
    local part = table.concat(phrase, "")
    local canBeDo = string.find("do()", part, 1, true) ~= nil
    local canBeDont = string.find("don't()", part, 1, true) ~= nil

    if canBeDo or canBeDont then
      if part == "do()" then
        evalBoolean = true
        phrase = {}
      end

      if part == "don't()" then
        evalBoolean = false
        phrase = {}
      end
    else
      phrase = {}
    end
  else
    if char == "d" then
      table.insert(phrase, char)
    end
  end

  return evalBoolean
end

return M
