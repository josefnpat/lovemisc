require("loaderlib/loaderlib")

function love.draw()
  loaderlib.draw()
end

dt_temp = 0
function love.update(dt)
  dt_temp = dt_temp + dt
  if dt_temp > 0.1 then
    dt_temp = dt_temp - 0.1
    loaderlib.current = loaderlib.current + 1
    if loaderlib.current > loaderlib.max then
      loaderlib.current = loaderlib.max
    end
  end
  if loaderlib.current == 100 then
    loaderlib.text = "Done!"
  elseif loaderlib.current == 80 then
    loaderlib.text = "Almost done!"
  end
end
