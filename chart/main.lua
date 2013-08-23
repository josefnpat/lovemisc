chartlib = require('chartlib/chartlib')

chart_random = chartlib.new(400)
chart_fps = chartlib.new(200)
chart_count = chartlib.new(200)

function love.draw()
  chart_random:draw("Random",0,0,nil,100)
  chart_fps:draw("FPS",100,250,nil,100)
  chart_count:draw("Count",100,400,nil,180)
end

i = 0
function love.update(dt)
  chart_random:push(math.random(0,100))
  chart_fps:push(love.timer.getFPS())  
  i = i + 1
  chart_count:push(i)
end
