--[[
Lua Tests

@author Aaric
@version 0.1.0-SNAPSHOT
--]]

-- print
print("\n--ch01--")
print("hello " .. "lua!")
print(_VERSION)

-- type
print("\n--ch02--")
local x
print(type(x))
print(type(type(x) == "nil"))
print(type(3.14))
print(type("lua"))
local array = {"cpp", "lua", "java"}
print(type(array))
local map = { lang1 = "cpp", lang2 = "lua", "java"}
print(type(map))

--string
print("\n--ch03--")
local html = [[
<html>
<title>Document</tille>
<body>
  <h1>Hello Lua!<h1>
</body>
</html>
]]
print(html)
print(#html)
print(tostring(123))

--number
print("\n--ch04--")
print("1" + 1)
print(tonumber("123"))

--bool | nil = false, 0 = true
local ba, bb, bn, bz = true, false, nil, 0
print(ba and bb)
print(ba or bb)
print(not bb)
print(bn and bz)
print(bn or bz)
print(not bz)
print(bz >10 and "yes" or "no")

--function
print("\n--ch05--")
--[[
function add(a, b)
  return a + b
end
print(add(1, 1))
]]
local function add(...)
  print("param size: " .. select("#", ...))
  print("param index 1: " .. select(1, ...))

  local sum = 0
  for i, v in ipairs({...}) do
    sum = sum + v
  end
  return sum
end
print(add(1, 2, 3, 4, 5))

--eval
print("\n--ch06--")
local a, b = 1, 2
local a, b = b, a
print(a, b)
print(a .. " + " .. b .. " = " .. add(a, b))

--if else
print("\n--ch07--")
if true then
  print(true)
else
  print(false)
end

--while
print("\n--ch08--")
local counter = 1
while counter <= 10 do 
  print(counter)
  counter = counter + 1
end

--for
print("\n--ch09--")
for i = 1, 5 do
  print(i)
end
for i = 1, #array, 1 do
  print(array[i])
end
for i, v in ipairs(array) do
 print(i, v)
end

--repeat
print("\n--ch10--")
local i = 1
repeat
  print(i)
  i = i + 1
until i > 10

--operator
-- +,-,*,/,%,^,-
-- ==,~=,>,<,>=,<=
-- and,or,not
print("\n--ch11--")
print(a + b)
print(a ~= b)
print(not 0)

print("\n--ch12--")
--table list
local tbList = {"aaa", "bbb", "ccc"}
print(tbList[1])
for index, value in ipairs(tbList) do
  print(index, value)
end
table.insert(tbList, 1, "zzz")
print(table.remove(tbList, 1))
print(#tbList)

--table map
local tbMap = {
  aaa = 1,
  bbb = 2,
  ccc = 3,
  [",;"] = 4
}
print(tbMap[",;"])
local tbMapCount = 0
for key, value in pairs(tbMap) do
  tbMapCount = tbMapCount + 1
  print(key, value)
end
print(tbMapCount)
print(_G["table"]["insert"])

print("\n--ch13--")
local str = string.char(0x30, 0x31, 0x32, 0x33)
local c = string.byte(str, 1)
print(str, c)
