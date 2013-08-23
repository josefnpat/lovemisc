isomaplib = require("isomaplib/isomaplib")

map = {}
size = 25
for x=-size,size do
  map[x] = {}
  for y=-size,size do
    map[x][y] = {}
    map[x][y].type = math.random(1,50)
    map[x][y].color = {math.random(127,255),math.random(127,255),math.random(127,255)}
  end
end

isomaplib.load_map(map)

img = love.graphics.newImage("tile.png")
unit = love.graphics.newImage("unit.png")
cursor = love.graphics.newImage("cursor.png")

isomaplib.set_scale(1)
isomaplib.debug = true
isomaplib.center_coord(0,0)

function love.keypressed(key,uni)
  if key == " " then
    isomaplib.screen.x = math.random(0,love.graphics.getWidth()/2)
    isomaplib.screen.y = math.random(0,love.graphics.getHeight()/2)
    isomaplib.screen.w = love.graphics.getWidth()-isomaplib.screen.x*2
    isomaplib.screen.h = love.graphics.getHeight()-isomaplib.screen.y*2
  elseif key =="escape" then
    love.event.quit()
  end
end

function love.draw()
  isomaplib.draw()
  love.graphics.print("fps:"..love.timer.getFPS(),0,0)
end

dt_temp = 0
function love.update(dt)
  dt_temp = dt_temp + dt
  isomaplib.update(dt)
end

function love.mousepressed(mx,my,button)
  if button == "l" and isomaplib.rawonmap(mx,my) and isomaplib.valid_raw(mx,my) then
    isomaplib.center_raw(mx,my)
  end
end

function isomaplib.draw_callback(x,y,map_data)
  -- rainbows!
  love.graphics.setColor(0,(y*x)%127+63,0)
  isolib.draw(img,x,y)
  -- init alpha
  local alpha = 255
  -- if mouse over
  if x == isomaplib.x and y == isomaplib.y then
    if dt_temp%1 >0.5 then
      alpha = 192
    else
      alpha = 127
    end
    love.graphics.setColor(0,255,0,alpha)
    isolib.draw(cursor,x,y)    
  end
  -- units
  love.graphics.setColor(map_data.color[1],map_data.color[2],map_data.color[3],alpha)
  if map_data.type == 1 then
    isolib.draw(unit,x,y)
  end
end
