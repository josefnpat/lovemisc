require("dropdownlib/dropdownlib")
require("fcblib/fcblib")

function love.load()
  list = {}
  list2 = {}
  for i = 1,10 do
    table.insert(list,2^i)
    table.insert(list2,i*10)
  end
  dd1 = dropdownlib.new(list,10,10,200)
  dd2 = dropdownlib.new(list2,220,10,200)
  love.graphics.setColor(127,127,127)
end

function love.draw()
  love.graphics.rectangle("fill",0,0,800,600)
  dd1:draw()
  dd2:draw()
end

function love.update(dt)
  dd1:update(dt)
  dd2:update(dt)
end

function love.mousepressed(x,y,button)
  dd1:mousepressed(x,y,button)
  dd2:mousepressed(x,y,button)
  print("dd1:"..list[dd1.current_index],"dd2:"..list2[dd2.current_index])
end
