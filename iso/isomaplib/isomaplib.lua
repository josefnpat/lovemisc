isolib = require("isolib/isolib")

isomaplib = {}

isomaplib.debug = false

isomaplib.x,isomaplib.y = 0,0
isomaplib.screen = {}
isomaplib.screen.x = 0
isomaplib.screen.y = 0
isomaplib.screen.w = love.graphics.getWidth()-isomaplib.screen.x*2
isomaplib.screen.h = love.graphics.getHeight()-isomaplib.screen.y*2

isomaplib.keybind = {}
isomaplib.keybind.right = "right"
isomaplib.keybind.left = "left"
isomaplib.keybind.up = "up"
isomaplib.keybind.down = "down"
isomaplib.keybind.speed = 16*32

isomaplib.map = {}

function isomaplib.load_map(map)
  isomaplib.map = map
end

function isomaplib.set_scale(scale)
  isolib.width = isolib.width * scale
  isolib.height = isolib.height * scale
  isomaplib.keybind.speed = isomaplib.keybind.speed / scale
end

function isomaplib.draw()
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  local ox,oy = isolib.raw_to_coord(isomaplib.screen.x,isomaplib.screen.y)
  local fx,fy = isolib.raw_to_coord(isomaplib.screen.x+isomaplib.screen.w,isomaplib.screen.y+isomaplib.screen.h)
  local k = 0
  for i=ox,fx do
    k = k + 1
    for j= oy-k,oy+k do
      local rawx,rawy = isolib.coord_to_raw(i-1,j)
      --if on the "screen"
      if rawx <= isomaplib.screen.x + isomaplib.screen.w and rawy <= isomaplib.screen.y + isomaplib.screen.h then
        if isomaplib.map[i] and isomaplib.map[i][j] and isomaplib.draw_callback then
          isomaplib.draw_callback(i,j,isomaplib.map[i][j])
        end
      end
    end
  end
  
  if isomaplib.debug then
    love.graphics.setColor(255,255,255)
    love.graphics.print("cx:"..isomaplib.x.." y:"..isomaplib.y,0,16)
    love.graphics.print("ox:"..isolib.offset.x.." ioy:"..isolib.offset.y,0,32)
    love.graphics.setColor(255,0,0)
    love.graphics.circle("line",isomaplib.screen.w/2+isomaplib.screen.x,isomaplib.screen.h/2+isomaplib.screen.y,16)
    love.graphics.rectangle("line",isomaplib.screen.x,isomaplib.screen.y,isomaplib.screen.w,isomaplib.screen.h)--debug
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

function isomaplib.update(dt)
  local rx,ry = love.mouse.getPosition()
  isomaplib.x,isomaplib.y = isolib.raw_to_coord(rx,ry)
  local prev
  if love.keyboard.isDown(isomaplib.keybind.right) then
    prev = isolib.offset.x
    isolib.offset.x = math.floor(isolib.offset.x - isomaplib.keybind.speed * 2 * dt)
    if not isomaplib.valid_raw(isomaplib.screen.x + isomaplib.screen.w/2,isomaplib.screen.y + isomaplib.screen.h/2) then
      isolib.offset.x = prev
    end
  end
  if love.keyboard.isDown(isomaplib.keybind.left) then
    prev = isolib.offset.x
    isolib.offset.x = math.floor(isolib.offset.x + isomaplib.keybind.speed * 2 * dt)
    if not isomaplib.valid_raw(isomaplib.screen.x + isomaplib.screen.w/2,isomaplib.screen.y + isomaplib.screen.h/2) then
      isolib.offset.x = prev
    end
  end
  if love.keyboard.isDown(isomaplib.keybind.up) then
    prev = isolib.offset.y
    isolib.offset.y = math.floor(isolib.offset.y + isomaplib.keybind.speed * dt)
    if not isomaplib.valid_raw(isomaplib.screen.x + isomaplib.screen.w/2,isomaplib.screen.y + isomaplib.screen.h/2) then
      isolib.offset.y = prev
    end
  end
  if love.keyboard.isDown(isomaplib.keybind.down) then
    prev = isolib.offset.y
    isolib.offset.y = math.floor(isolib.offset.y - isomaplib.keybind.speed * dt)
    if not isomaplib.valid_raw(isomaplib.screen.x + isomaplib.screen.w/2,isomaplib.screen.y + isomaplib.screen.h/2) then
      isolib.offset.y = prev
    end
  end
end

function isomaplib.rawonmap(mx,my)
  if mx <= isomaplib.screen.x + isomaplib.screen.w and mx >= isomaplib.screen.x and
    my <= isomaplib.screen.y + isomaplib.screen.h and my >= isomaplib.screen.y then
    return true
  end
end

function isomaplib.center_raw(mx,my)
  local x,y = isolib.raw_to_coord(mx,my)
  isomaplib.center_coord(x,y)
end

function isomaplib.center_coord(x,y)
  isolib.center_coord(x,y,isomaplib.screen.x,isomaplib.screen.y,isomaplib.screen.w,isomaplib.screen.h)
end

function isomaplib.valid_coord(x,y)
  if isomaplib.map[x] and isomaplib.map[x][y] then
    return true
  end
end

function isomaplib.valid_raw(mx,my)
  local x,y = isolib.raw_to_coord(mx,my)
  return isomaplib.valid_coord(x,y)
end

return isomaplib
