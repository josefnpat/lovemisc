overlaylib = {}

overlaylib.cursor = love.graphics.newImage("overlaylib/cursor.png")
love.mouse.setVisible( false )
--success = love.graphics.setMode( love.graphics.getWidth(),love.graphics.getHeight(), false, false, 0 )
overlaylib.start = nil
overlaylib.default = {}
overlaylib.default.color = {0,255,0,255}
function overlaylib.draw(color)
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  if color then
    love.graphics.setColor(color)
  else
    love.graphics.setColor(overlaylib.default.color)
  end
  local x,y = love.mouse.getPosition()
  if overlaylib.start then
    love.graphics.rectangle("line",overlaylib.start.x,overlaylib.start.y,(x-overlaylib.start.x),(y-overlaylib.start.y))
  end
  love.graphics.draw(overlaylib.cursor,x,y)
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

function overlaylib.mousepressed(x,y,button)
  if button == "l" then
    overlaylib.start = {x=x,y=y}
  end
end

function overlaylib.mousereleased(x,y,button)
  if button == "l" and overlaylib.start then
    if overlaylib.callback then
      overlaylib.callback(overlaylib.start.x,overlaylib.start.y,x,y)
    else
      print("function overlaylib.callback(startx,starty,endx,endy) not defined")
    end
    overlaylib.start = nil
  end
end
return overlaylib
