local ls = require("readfile")

local Lines = ls.readFileLines("test.txt")

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, tonumber(str))
  end
  return t
end

local function descending(table)
  for i, v in ipairs(table) do
    local nextCounter = i + 1
    if table[nextCounter] == nil then
      break
    end
    local sum = table[nextCounter] - v
    if sum >= 4 or sum <= 0 then
      return 0
    end
  end
  return 1
end

local function ascending(table)
  for i, v in ipairs(table) do
    local nextCounter = i + 1
    if table[nextCounter] == nil then
      break
    end
    local sum = v - table[nextCounter]
    if sum >= 4 then
      return 0
    end
    if sum <= 0 then
      return 0
    end
  end
  return 1
end

local counter = 0

for _, v in pairs(Lines) do
  local t = split(v)
  if t[1] < t[2] then
    local asc_plus = descending(t)
    counter = counter + asc_plus
  else
    local desc_plus = ascending(t)
    counter = counter + desc_plus
  end
end


print(counter)
