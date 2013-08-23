require("circlelib/circlelib")

function love.draw()

end

temp_dt = 0
temp_index = 0
blue = {0,0,255}
dark_bgc = {63,63,63}
white_line = {255,255,255}
function love.draw()
  circlelib.draw(400,300,(temp_index)%101,100,blue,dark_bgc,white_line,160,200)
  circlelib.draw(400,300,(temp_index)%11,10,null,null,null,80,120)
  circlelib.draw(400,300,(temp_index)%4,3,null,null,null,20,50)
end

function love.update(dt)
  temp_dt = temp_dt + dt
  if temp_dt > 0.08 then
    temp_dt = 0
    temp_index = ( temp_index + 1 )
  end
end


