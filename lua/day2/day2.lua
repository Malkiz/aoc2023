local open = io.open

local function read_file(path)
  local file = open(path, "rb")  -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read "*a" -- *a or *all reads the whole file
  file:close()
  return content
end

local fileContent = read_file("lua/day2/input.txt");

if not fileContent then
  print("File not found")
  os.exit()
end

local max = { red = 12, green = 13, blue = 14 }
local sum = 0

for line in fileContent:gmatch("[^\r\n]+") do
  local gameNumber = line:match("Game (%d+):")
  local isValid = true
  for round in line:gmatch("[^;]+") do
    for number, color in round:gmatch("(%d+) (%a+)") do
      if tonumber(number) > max[color] then
        -- print("Game " .. gameNumber .. " is invalid")
        isValid = false
        break
      end
    end
  end

  if isValid then
    -- print("Game " .. gameNumber .. " is valid")
    sum = sum + tonumber(gameNumber)
  end
end

print("Sum: " .. sum)
