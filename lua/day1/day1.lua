local open = io.open

local function read_file(path)
  local file = open(path, "rb")  -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read "*a" -- *a or *all reads the whole file
  file:close()
  return content
end

local fileContent = read_file("lua/day1/input.txt");

if not fileContent then
  print("File not found")
  os.exit()
end

local subStrings = {
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
}
local strToNum = {
  zero = 0,
  one = 1,
  two = 2,
  three = 3,
  four = 4,
  five = 5,
  six = 6,
  seven = 7,
  eight = 8,
  nine = 9
}

local function getNextIndex(line, index)
  local minIndex = math.huge
  local minSubString = nil
  for _, subString in ipairs(subStrings) do
    local subStringIndex = line:find(subString, index)
    if subStringIndex and subStringIndex < minIndex then
      minIndex = subStringIndex
      minSubString = subString
    end
  end
  return minIndex, minSubString
end

local sum = 0
for line in fileContent:gmatch("[^\r\n]+") do
  local digits = {}
  local index = 1
  while index <= #line do
    local nextIndex, subString = getNextIndex(line, index)
    local digit = strToNum[subString] or subString
    if digit then
      table.insert(digits, digit)
    end
    index = nextIndex + 1
  end

  local firstDigit = digits[1]
  local lastDigit = digits[#digits]
  local bothDigits = firstDigit .. lastDigit
  sum = sum + tonumber(bothDigits)
end

print(sum)
