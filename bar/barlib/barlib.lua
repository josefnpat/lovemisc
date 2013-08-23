barlib = {}

barlib.img = love.graphics.newImage("barlib/bar.png")

barlib.default = {}
barlib.default.cur = 10
barlib.default.max = 10
barlib.default.fgc = {0,255,0,255}
barlib.default.bgc = {255,255,255,255}
barlib.img_w = barlib.img:getWidth()

function barlib.draw(x,y,cur,max,fgc,bgc)
  if not cur then cur = barlib.default.cur end
  if not max then max = barlib.default.max end
  if not fgc then fgc = barlib.default.fgc end
  if not bgc then bgc = barlib.default.bgc end
  
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  love.graphics.setColor(fgc)
  for i = 1,max do
    if i > cur then
      love.graphics.setColor(bgc)
    end
    love.graphics.draw(barlib.img,x+(i-1)*barlib.img_w,y)
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

return barlib
