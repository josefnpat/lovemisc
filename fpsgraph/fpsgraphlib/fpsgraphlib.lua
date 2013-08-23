fpsgraphlib = {}

fpsgraphlib.lib = require("graphlib/graphlib")
fpsgraphlib.lib.unit = " fps"
fpsgraphlib.lib.delay = 0.1

function fpsgraphlib.draw()
  fpsgraphlib.lib.draw()
end

function fpsgraphlib.update(dt)
  fpsgraphlib.lib.update(dt,love.timer.getFPS())
end
