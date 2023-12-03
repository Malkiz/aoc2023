local open = io.open

local function read_file(path)
  local file = open(path, "rb")  -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read "*a" -- *a or *all reads the whole file
  file:close()
  return content
end

local fileContent = read_file("lua/day3/input.txt");

if not fileContent then
  print("File not found")
  os.exit()
end

-- print(fileContent)

-- fileContent looks like this:
-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..

-- local space = '.'
-- local symbolTypes = { '#', '*', '$', '+', '%', '@', '-', '/', '=', '&' }

local numbers = {}
local symbols = {}

local function getNextSymbol(line, index)
  local nextIndex = line:find("[^%d.]", index)
  if not nextIndex then
    return nil, nil
  end
  return nextIndex, line:sub(nextIndex, nextIndex)
end

local row = 0
for line in fileContent:gmatch("[^\r\n]+") do
  row = row + 1
  local col = 1
  for number in line:gmatch("%d+") do
    col = line:find(number, col)
    -- print(number, row, col)
    table.insert(numbers, { number = tonumber(number), row = row, col = col, endCol = col + #number - 1 })
  end

  col = 1
  while col <= #line do
    local nextIndex, symbol = getNextSymbol(line, col)
    if symbol and nextIndex <= #line then
      -- print(symbol, row, nextIndex)
      table.insert(symbols, { symbol = symbol, row = row, col = nextIndex })
      col = nextIndex + 1
    else
      col = #line + 1
    end
  end
end

local function isNumberAdjacentToSymbol(row, col, endCol)
  for _, symbol in ipairs(symbols) do
    local minSymbolRow = symbol.row - 1
    local maxSymbolRow = symbol.row + 1
    local minSymbolCol = symbol.col - 1
    local maxSymbolCol = symbol.col + 1
    if row >= minSymbolRow and row <= maxSymbolRow and
        ((col >= minSymbolCol and col <= maxSymbolCol) or (endCol >= minSymbolCol and endCol <= maxSymbolCol)) then
      return true
    end
  end
  return false
end

print(#symbols)

local sum = 0
for _, number in ipairs(numbers) do
  if isNumberAdjacentToSymbol(number.row, number.col, number.endCol) then
    sum = sum + number.number
  end
end

print(sum)
