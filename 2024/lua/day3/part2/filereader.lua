local M = {}

M.__index = M

function M:new(filename)
  local instance = setmetatable({}, M)
  instance.filename = filename
  return instance
end

function M:read(func)
  local file = io.open(self.filename, "r")
  if not file then
    return {}
  end

  repeat
    local c = file:read(1)
    func(c)
  until c == nil

  if file then
    file:close()
  end
end

return M
