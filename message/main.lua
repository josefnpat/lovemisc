require("messagelib/messagelib")

function love.load()
  messagelib.load()
  -- set scale, then modify variables.
  --messagelib.setScale(2)
  messagelib.enqueue("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non dolor nec odio ornare dictum. Aliquam erat volutpat. Pellentesque mattis augue ipsum, quis tincidunt diam. Donec massa nisi, viverra at tristique eget, porta ut lorem. Donec mattis quam urna. In hac habitasse platea dictumst. Aliquam tempor eros nec lectus sodales id hendrerit dolor faucibus. Sed et magna in felis pharetra scelerisque vestibulum ac nunc.")
end

function love.draw()
  love.graphics.setColor(127,127,127)--GREY!
  love.graphics.rectangle("fill",0,0,800,600)
  messagelib.draw()
end

function love.update(dt)
  messagelib.update(dt)
end

function love.keypressed(key,uni)
  if key=="tab" then
    messagelib.enqueue("WHAT NOW BITCH?"..(string.rep("X ",math.random(1,100))))
  end
  messagelib.keypressed(key,uni)
end
