local M = {}

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

function M.readFileLines(file)
  return lines_from(file)
end

return M
