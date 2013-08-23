require("barlib/barlib")

temp_dt = 0
temp_index = 0
blue = {0,0,255}
dark_bgc = {63,63,63}
function love.draw()
  barlib.draw(16,16,temp_index%11,10)
  barlib.draw(16,16+6,(temp_index+5)%11,10,blue,dark_bgc)
end

function love.update(dt)
  temp_dt = temp_dt + dt
  if temp_dt > 0.25 then
    temp_dt = temp_dt - 1
    temp_index = ( temp_index + 1 )
  end
end


