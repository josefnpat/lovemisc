gcgraphlib = {}

gcgraphlib.lib = require("graphlib/graphlib")
gcgraphlib.lib.unit = "Kb"
gcgraphlib.lib.color.data = {0,255,0,255}

function gcgraphlib.draw()
  gcgraphlib.lib.draw()
end

function gcgraphlib.update(dt)
  gcgraphlib.lib.update(dt,math.floor(collectgarbage("count")))
end
