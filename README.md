# lua-sample

> Lua Tests.

## 1.syntax

```lua
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
print(type(x))
print(type(type(x) == "nil"))
print(type(3.14))
print(type("lua"))
array = {"cpp", "lua", "java"}
print(type(array))
map = { lang1 = "cpp", lang2 = "lua", "java"}
print(type(map))

--string
print("\n--ch03--")
html = [[
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
function add(...)
  print("param size: " .. select("#", ...))
  print("param index 1: " .. select(1, ...))

  local sum = 0
  for i, v in ipairs({...}) do
    sum = sum + v
  end
  return sum
end
print(add(1, 2, 3, 4, 5))

--init
print("\n--ch06--")
a, b = 1, 2
a, b = b, a
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
i = 1
while i <= 10 do 
  print(i)
  i = i + 1
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
i = 1
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
```

## 2.openresty

### 2.1 lua-resty-redis

```bash
sh> cd /usr/local/openresty/lualib/redis
sh> wget https://github.com/openresty/lua-resty-redis/raw/master/lib/resty/redis.lua
```

### 2.2 /etc/openresty/openresty.conf

```nginx
#lua_package_path "/usr/local/openresty/lualib/redis/redis.lua";

server {
    listen       80;
    server_name  localhost;

    # content_by_lua_block
    location /hello-lua {
        default_type text/html;
        content_by_lua_block {
            ngx.say("<p>Hello, OpenResty!</p>")
        }
    }

    # content_by_lua_block
    location /hello-lua-file {
        default_type text/html;
        content_by_lua_file /usr/local/openresty/luacustom/hello.lua;
    }

    # lua-resty-redis
    location /hello-lua-redis {
        default_type text/html;
        content_by_lua_file /usr/local/openresty/luacustom/hello-redis.lua;
    }

    # openresty-internal
    location /AuthFiles {
        internal;

        # txt|doc|docx|rtf|rtfd|xls|xlsx|csv|ppt|pptx|pdf|zip|rar|tar|tar\.gz|xz|gz|bz2|bin|apk
        if ($request_uri ~* ^.*\/(.*)\.(txt|docx|xlsx|csv|pptx|pdf|zip|tar\.gz|apk)(\?rename=([^&]+))$) {
            add_header Content-Disposition "attachment;filename=$arg_rename.$2";
        }
        alias /var/www/files/;
        expires 0;
        allow all;
    }

    # ngx.exec
    location /files {
        content_by_lua_block {
            ngx.exec("/AuthFiles/banzhuan.jpg", "filename=lua-test")
        }
    }
}
```

### 2.3 /usr/local/openresty/luacustom/hello-redis.lua

```lua
--[[
OpenResty Lua Redis Tests

@author Aaric
@version 0.1.0-SNAPSHOT
--]]

local redis = require "resty.redis"
local red = redis:new()

red:set_timeouts(1000, 1000, 1000) -- 1 sec

--local ok, err = red:connect("127.0.0.1", 6379)
local ok, err = red:connect("192.168.56.200", 7001)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local res, err = red:auth("redis2020")
if not res then
    ngx.say("failed to authenticate: ", err)
    return
end

ok, err = red:set("greet", "hello world")
if not ok then
    ngx.say("failed to set greet: ", err)
    return
end

ngx.say("set result: ", ok)

local res, err = red:get("greet")
if not res then
    ngx.say("failed to get greet: ", err)
    return
end

if res == ngx.null then
    ngx.say("greet not found.")
    return
end

ngx.say("greet: ", res)
```
