loaderlib = {}

loaderlib.w = 400
loaderlib.h = 32
loaderlib.x = (love.graphics.getWidth() - loaderlib.w)/2
loaderlib.y = (love.graphics.getHeight() - loaderlib.h)/2
loaderlib.text = "Reticulating Splines"
loaderlib.current = 0
loaderlib.max = 100
loaderlib.padding = 3
loaderlib.ticks = 10
loaderlib.ticksize = loaderlib.w/loaderlib.ticks
loaderlib.color = {}
loaderlib.color.outline = {255,255,255,255}
loaderlib.color.bar = {255,127,0,255}
loaderlib.color.text = {192,192,192,255}

function loaderlib.draw()
  local r,g,b,a=love.graphics.getColor()
  love.graphics.setColor(loaderlib.color.outline)
  love.graphics.rectangle("line",loaderlib.x,loaderlib.y,loaderlib.w,loaderlib.h)
  for i = 0,loaderlib.ticks do
    love.graphics.line(loaderlib.x+i*loaderlib.ticksize,loaderlib.y+loaderlib.h,loaderlib.x+i*loaderlib.ticksize,loaderlib.y+loaderlib.h+8)
  end
  love.graphics.setColor(loaderlib.color.bar)
  love.graphics.rectangle("fill",loaderlib.x+loaderlib.padding,loaderlib.y+loaderlib.padding,loaderlib.w*loaderlib.current/loaderlib.max-loaderlib.padding*2,loaderlib.h-loaderlib.padding*2)
  love.graphics.setColor(loaderlib.color.text)
  love.graphics.printf(loaderlib.text,loaderlib.x,loaderlib.y-64,loaderlib.w,"center")
  love.graphics.setColor(r,g,b,a)
end

return loaderlib
