graphlib = {}
graphlib.data = {}
graphlib.x = love.graphics.getWidth()/20
graphlib.y = graphlib.x
graphlib.width = love.graphics.getWidth()/4
graphlib.height = love.graphics.getHeight()/4
graphlib.unit = " units"
graphlib.color = {}
graphlib.color.frame = {255,255,255,255}
graphlib.color.data = {0,255,255,255}
graphlib.delay = 0.01
graphlib.delay_dt = 0
function graphlib.draw()
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(graphlib.color.frame)
  if graphlib.max then
    local scale = graphlib.height/graphlib.max
    for i,v in ipairs(graphlib.data) do
      love.graphics.setColor(graphlib.color.data)
      love.graphics.line(i+graphlib.x,
                         graphlib.height+graphlib.y,
                         i+graphlib.x,
                         (graphlib.max-v)*scale+graphlib.y)
    end
    love.graphics.setColor(graphlib.color.frame)
    love.graphics.line(graphlib.x,
                       graphlib.y,
                       graphlib.x,
                       graphlib.height+graphlib.y,
                       graphlib.width+graphlib.x,
                       graphlib.height+graphlib.y)
    love.graphics.print(graphlib.max..graphlib.unit,
                        graphlib.width+graphlib.x,
                        graphlib.y)
    love.graphics.print("0"..graphlib.unit,
                        graphlib.width+graphlib.x,
                        graphlib.height+graphlib.y)
  else
    love.graphics.print("Waiting for graphlib.update().",0,0);
  end
  love.graphics.setColor(r,g,b,a)
end

function graphlib.update(dt,val)
  graphlib.delay_dt = graphlib.delay_dt + dt
  if graphlib.delay_dt > graphlib.delay then
    graphlib.delay_dt = graphlib.delay_dt - graphlib.delay
    
    if not graphlib.max then
      graphlib.max = val
    end
    if val > graphlib.max then
      graphlib.max = val
    end
    table.insert(graphlib.data,val)
    if #graphlib.data > graphlib.width then
      table.remove(graphlib.data,1)
    end  
  end
end

return graphlib
