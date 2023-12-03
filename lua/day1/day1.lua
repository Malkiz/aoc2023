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

local sum = 0
for line in fileContent:gmatch("[^\r\n]+") do
  local digits = {}
  for digit in line:gmatch("%d") do
    table.insert(digits, digit)
  end

  local firstDigit = digits[1]
  local lastDigit = digits[#digits]
  local bothDigits = firstDigit .. lastDigit
  sum = sum + tonumber(bothDigits)
end

print(sum)
