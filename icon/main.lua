iconlib = require("iconlib/iconlib")

temp_icons = {}


for i=1,4 do
  temp_icon = {}
  temp_icon.x = 16*4*(2*i-1)
  temp_icon.y = 16*4
  temp_icon.scale = 8-i
  temp_icon.img = i
  temp_icon.id = i
  temp_icon.count = math.random(0,500)

  table.insert(temp_icons,temp_icon)
end

iconlib.data = temp_icons

function love.draw()
  iconlib.draw()
end

function love.update(dt)
  iconlib.update(dt)
end

function love.mousepressed(x,y,button)
  iconlib.mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
  iconlib.mousereleased(x,y,button)
end

function iconlib.pressed(index,button)
  print("iconslib.pressed(index="..index..",button="..button..")")
end
