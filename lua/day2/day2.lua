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

local sum = 0

for line in fileContent:gmatch("[^\r\n]+") do
  local gameNumber = line:match("Game (%d+):")
  local max = { red = 0, green = 0, blue = 0 }
  for round in line:gmatch("[^;]+") do
    for number, color in round:gmatch("(%d+) (%a+)") do
      if tonumber(number) > max[color] then
        -- print("Game " .. gameNumber .. " is invalid")
        max[color] = tonumber(number)
      end
    end
  end

  local power = max.red * max.green * max.blue
  sum = sum + power
end

print("Sum: " .. sum)
