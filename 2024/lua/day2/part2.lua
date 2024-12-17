local ls = require("readfile")

local Lines = ls.readFileLines("test1.txt")

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

local function shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for i, v in ipairs(o) do     -- Iterate sequentially over the table
      if type(v) == 'table' then
        s = s .. dump(v) .. ', ' -- Recursively handle nested tables
      else
        s = s .. tostring(v) .. ', '
      end
    end
    return s:sub(1, -3) .. ' }' -- Remove the trailing comma and space
  else
    return tostring(o)
  end
end

local function calcSign(t)
  if t[1] < t[2] then
    return 1
  end
  return -1
end

local function isValid(t, sign)
  print("===============================ZIOBRO KURWO JEBANA =============================")
  print(dump(t))
  print("sign " .. sign)
  for i, v in ipairs(t) do
    local nextCounter = i + 1
    if t[nextCounter] == nil then
      break
    end
    local sum = sign * (t[nextCounter] - v)
    print("sum: " .. sum .. " = " .. t[nextCounter] .. " - " .. v)
    if sum > 3 or sum < 1 then
      print("not valid")
      return false
    end
  end
  print("is valid")
  return true
end

local function isSafe(t)
  local sign = calcSign(t)
  if isValid(t, sign) then
    return 1
  end
  for i, _ in ipairs(t) do
    local myT = shallow_copy(t)
    table.remove(myT, i)
    sign = calcSign(myT)
    if isValid(myT, sign) then
      return 1
    end
  end
  return 0
end

local counter = 0
-- kurwa no tak
for _, v in pairs(Lines) do
  local t = split(v)
  local tab = isSafe(t)
  counter = counter + tab
end

print(counter)
