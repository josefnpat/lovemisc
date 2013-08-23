chartlib = {}

function chartlib.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function chartlib.new(buffersize)
  local chart = {}
  -- Config
  chart.roundto = 1 --number of decimal places to round to
  chart.color = {}
  chart.color.axis = {255,255,255}
  chart.color.bars = {255,0,0}
  chart.color.text = {255,255,255}
  chart.color.avg  = {0,255,0}
  chart.buffersize = buffersize
  -- Private Variables
  chart._count = 0
  chart._data = {}
  -- Functions
  chart.draw = chartlib.draw
  chart.push = chartlib.push
  chart.pop = chartlib.pop
  chart.count = chartlib.count
  return chart
end

function chartlib:draw(title,x,y,w,h)
  x,y = x+0.5,y+0.5 -- Make the lines CRISP
  if not w then
    w = self.buffersize
  end
  local old_r,old_g,old_b = love.graphics.getColor()
  if self._data[1] then
    local max = self._data[1]
    local total = 0
    for i,v in ipairs(self._data) do
      total = total + v
      if v > max then
        max = v
      end
    end
    love.graphics.setColor(self.color.bars)
    for i,v in ipairs(self._data) do
      love.graphics.line(x+i,y+h,x+i,y+h-v*h/max)
    end
    love.graphics.setColor(self.color.avg)
    local avg = total/self._count
    local yscale = y+h-avg*h/max
    love.graphics.line(x,yscale,x+w,yscale)
    love.graphics.printf(chartlib.round(avg,self.roundto),x-1,yscale,w,"right")--avg

    love.graphics.setColor(self.color.text)
    love.graphics.printf(chartlib.round(max,self.roundto),x-1,y,w,"right")--max
    love.graphics.print(title,x,y)--title
  end
  love.graphics.setColor(self.color.axis)
  love.graphics.rectangle("line",x,y,w,h)
  love.graphics.setColor(old_r,old_g,old_b)
end

function chartlib:push(val)
  self._count = self._count + 1
  table.insert(self._data,val)
  if self._count > self.buffersize then
    self:pop()
  end
end

function chartlib:pop()
  if self._count > 0 then
    self._count = self._count - 1
    return table.remove(self._data,1)
  end
end

function chartlib:count()
  return self._count
end

return chartlib
