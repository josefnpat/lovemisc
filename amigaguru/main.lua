ag = require "amigaguru/amigaguru"

love.graphics.setNewFont(12)

function love.load(args)
  ag.load(args)
end

function love.draw()
  ag.draw()
end

function love.update(dt)
  ag.update(dt)
end
