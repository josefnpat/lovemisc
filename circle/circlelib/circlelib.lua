circlelib = {}

circlelib.default = {}
circlelib.default.cur = 10
circlelib.default.max = 10
circlelib.default.fgc = {0,255,0,255}
circlelib.default.bgc = {255,255,255,255}
circlelib.default.linec = {127,127,127,255}
circlelib.default.ri = 10
circlelib.default.ro = 20

function circlelib.draw(x,y,cur,max,fgc,bgc,linec,ri,ro)
  if not cur then cur = circlelib.default.cur end
  if not max then max = circlelib.default.max end
  if not fgc then fgc = circlelib.default.fgc end
  if not bgc then bgc = circlelib.default.bgc end
  if not linec then linec = circlelib.default.linec end
  if not ri then ri = circlelib.default.ri end
  if not ro then ro = circlelib.default.ro end
  
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()

  for i=1,(max) do
    if i > cur then
      love.graphics.setColor(bgc)
    else
      love.graphics.setColor(fgc)    
    end
    r = i/max*math.pi*2
    if i==1 then
      pix,piy=x+ri,y
      pox,poy=x+ro,y
    else
      pix,piy,pox,poy=ix,iy,ox,oy
    end
    ix,iy=x+ri*math.cos(r),y+ri*math.sin(r)
    ox,oy=x+ro*math.cos(r),y+ro*math.sin(r)
    love.graphics.polygon("fill",pix,piy,pox,poy,ox,oy,ix,iy)
    love.graphics.setColor(linec)
    love.graphics.polygon("line",pix,piy,pox,poy,ox,oy,ix,iy)
  end

  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end
