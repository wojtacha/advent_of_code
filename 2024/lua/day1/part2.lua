Sum = 0
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

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function multi_list_to_table(lines)
  local M = {}
  local table_a = {}
  local table_b = {}
  -- print all line numbers and their contents
  for _, v in pairs(lines) do
    local cos = split(v)
    table.insert(table_a, tonumber(cos[1]))
    table.insert(table_b, tonumber(cos[2]))
  end

  table.sort(table_a)
  table.sort(table_b)
  M.left = table_a
  M.right = table_b

  return M
end

local function ocurrences(value, table)
  local occ = 0
  for _, v in ipairs(table) do
    if value == v then
      occ = occ + 1
    end
  end
  return occ
end

function Main()
  -- tests the functions above
  local file = "test.txt"
  local lines = lines_from(file)
  local sortedTables = multi_list_to_table(lines)

  for _, v in ipairs(sortedTables.left) do
    local occurence = ocurrences(v, sortedTables.right)
    Sum = Sum + (v * occurence)
  end
  print(Sum)
end

Main()
