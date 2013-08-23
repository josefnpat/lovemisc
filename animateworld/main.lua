require("animateworldlib/animateworldlib")
require("gcgraphlib/gcgraphlib")

function love.load()
  world1 = animateworldlib.load("world_1");
  world2 = animateworldlib.load("world_2");
  world3 = animateworldlib.load("world_3");
  world4 = animateworldlib.load("world_4");
end

function love.draw()
  gcgraphlib.draw()
  love.graphics.draw(world1[frame],50,250)
  love.graphics.draw(world2[frame],250,250)
  love.graphics.draw(world3[frame],450,250)
  love.graphics.draw(world4[frame],650,250)
  love.graphics.print(love.timer.getFPS(),0,0)
end

total_dt = 0;
frame = 1
delay_dt = 1/360
function love.update(dt)
  gcgraphlib.update(dt)
  total_dt = total_dt + dt
  if total_dt > delay_dt then
    total_dt = total_dt - delay_dt
    frame = (frame + 1 )
    if frame > 360 then
      frame = 1
    end
  end
end
