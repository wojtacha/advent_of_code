local M = {}
M.__index = M

function M:new()
  local instance = setmetatable({}, M)
  instance.lhs = ""
  instance.rhs = ""
  instance.metcomma = false
  instance.starting_template = { "m", "u", "l", "(" }
  return instance
end

local function isClose(char)
  if char == ")" then
    return true
  end
  return false
end

local function isComma(char)
  if char == "," then
    return true
  end
  return false
end

local function isDigit(char)
  if tonumber(char) then
    return true
  end
  return false
end

function M:expects(char)
  if not next(self.starting_template) then
    if self.lhs == "" then
      if isDigit(char) then
        self.lhs = self.lhs .. char
        return "continue"
      else
        return "break"
      end
    end

    if self.lhs ~= "" and not self.metcomma then
      if isComma(char) then
        self.metcomma = true
        return "continue"
      end

      if isDigit(char) then
        self.lhs = self.lhs .. char
        return "continue"
      else
        return "break"
      end
    elseif self.rhs == "" then
      if isDigit(char) then
        self.rhs = self.rhs .. char
        return "continue"
      else
        return "break"
      end
    else
      if isClose(char) then
        self.metcomma = true
        return "done"
      end
      if isDigit(char) then
        self.rhs = self.rhs .. char
        return "continue"
      else
        return "break"
      end
    end
  elseif char == self.starting_template[1] then
    table.remove(self.starting_template, 1)
    return "continue"
  else
    return "break"
  end
end

function M:done()
  print("dodaje: " .. self.lhs .. " i " .. self.rhs)
  return self.lhs * self.rhs
end

return M
