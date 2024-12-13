local function file_exists(name)
  local file = io.open(name, "r")

  if file then
    file:close()
  end
  return file ~= nil
end

local function lines_from(file)
  if not file_exists(file) then
    return {}
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

-- tests the functions above
local file = "test.txt"
local lines = lines_from(file)

local table_a = {}
local table_b = {}
-- print all line numbers and their contents
for _, v in pairs(lines) do
  local cos = mysplit(v)
  table.insert(table_a, tonumber(cos[1]))
  table.insert(table_b, tonumber(cos[2]))
end

table.sort(table_a)
table.sort(table_b)

local sum = 0
for i, v in pairs(table_a) do
  sum = sum + math.abs(table_b[i] - v)
end

print(sum)
