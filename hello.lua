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

--number
print("\n--ch04--")
print("1" + 1)

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

--define
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
local tb = {
  aaa = 1,
  bbb = 2,
  ccc = 3
}
print(tb["aaa"])

print("\n--ch13--")
local ls = {"aaa", "bbb", "ccc"}
for index, value in ipairs(ls) do
  print(index, value)
end
