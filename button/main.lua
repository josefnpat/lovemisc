buttonlib = require("buttonlib/buttonlib")

function love.load()
  buttons = {
    b1 = buttonlib.new("Submit",32,32,"button_sub"),
    b2 = buttonlib.new("Cancel",32,64,"button_can"),
    b3 = buttonlib.new("Format HD",32,96,"button_dis")
  }
  buttons.b3.disabled = true
end

function love.draw()
  for _,v in pairs(buttons) do
    v:draw()
  end
end

function love.update(dt)
  for _,v in pairs(buttons) do
    v:update(dt)
  end
end

function love.mousepressed(x,y,button)
  for _,v in pairs(buttons) do
    v:mousepressed(x,y,button)
  end
end

function love.mousereleased(x,y,button)
  for _,v in pairs(buttons) do
    v:mousereleased(x,y,button)
  end
end

function button_sub()
  print("EAT THIS DICKWAD.")
end
