require("graphlib/graphlib")

function love.load()
  graphlib.unit = " fucks given"
end

function love.draw()
  graphlib.draw()
end

function love.update(dt)
  graphlib.update(dt,math.random(-5,100))
end
