require("overlaylib/overlaylib")

function love.draw()
  overlaylib.draw()
end

function love.mousepressed(x,y,button)
  overlaylib.mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
  overlaylib.mousereleased(x,y,button)
end

function overlaylib.callback(startx,starty,endx,endy)
  print("Selection:","x1:",startx,"y1:",starty,"x2:",endx,"y2:",endy)
end
