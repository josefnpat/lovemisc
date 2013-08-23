bubblelib = require("bubblelib/bubblelib")

tux = love.graphics.newImage("bubblelib/tux.png")

function love.draw()
  local temp_cur
  if cur > 100 then
    temp_cur = 100
  else
    temp_cur = cur
  end
  bubblelib.draw("Hello World!\nHow are you?",100,100,temp_cur,100,nil,160)
  love.graphics.draw(tux,100,164)
end

dt_t = 0
cur = 0
function love.update(dt)
  dt_t = dt_t + dt
  if dt_t > 0.5 then
    cur = (cur + 1)%151
  end
end
