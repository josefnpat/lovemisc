mui = {}

-- MUI Window Manager System
-- Love Hooks

mui.windows = {}

function mui:load(arg)
  for _,window in ipairs(self.windows) do
    window:load(arg)
  end
end

function mui:draw()
  for _,window in ipairs(self.windows) do
    window:draw()
  end
end

function mui:update(dt)
  for _,window in ipairs(self.windows) do
    window:update(dt)
  end
end

function mui:keypressed(key,unicode)
  for _,window in ipairs(self.windows) do
    window:keypressed(key,unicode)
  end
end

function mui:keyreleased(key)
  for _,window in ipairs(self.windows) do
    window:keyreleased(key)
  end
end

function mui:mousepressed(x,y,button)
  for _,window in ipairs(self.windows) do
    if mui.inrange(window) then
      window:mousepressed(x,y,button)
    end
  end
end

function mui:mousereleased(x,y,button)
  for _,window in ipairs(self.windows) do
    if mui.inrange(window) then
      window:mousereleased(x,y,button)
    end
  end
end

function mui:add(window)
  table.insert(self.windows,window)
end

-- MUI Window System
-- Love Hooks

mui.window = {}

function mui.window:load(arg)
--[[
  for _,widget in ipairs(self.widgets) do
    widget:load(arg)
  end
  --]]
end

function mui.window:draw()
  for _,widget in ipairs(self.widgets) do
    widget:draw()
  end
  love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
end

function mui.window:update(dt)
  for _,widget in ipairs(self.widgets) do
    widget:update(dt)
  end
end

function mui.window:keypressed(key,unicode)
  for _,widget in ipairs(self.widgets) do
    widget:keypressed(key,unicode)
  end
end

function mui.window:keyreleased(key)
  for _,widget in ipairs(self.widgets) do
    widget:keyreleased(key)
  end
end

function mui.window:mousepressed(x,y,button)
  for _,widget in ipairs(self.widgets) do
    if mui.inrange(widget) then
      widget:mousepressed(x,y,button)
    end
  end
end

function mui.window:mousereleased(x,y,button)
  for _,widget in ipairs(self.widgets) do
    if mui.inrange(widget) then
      widget:mousereleased(x,y,button)
    end
  end
end

function mui.window:add(widget)
  table.insert(self.widgets,widget)
end

function mui.window.new()
  local window = {}
  window.widgets = {}
  window.load = mui.window.load
  window.draw = mui.window.draw
  window.update = mui.window.update
  window.keypressed = mui.window.keypressed
  window.keyreleased = mui.window.keyreleased
  window.mousepressed = mui.window.mousepressed
  window.mousereleased = mui.window.mousereleased
  window.add = mui.window.add

  -- Window Properties
  window.x = 0
  window.y = 0
  window.w = 800
  window.h = 600
  
  function window.setLoc(self,x,y)
    self.x,self.y = x,y
  end
  
  function window.getLoc(self)
    return self.x,self.y
  end
  
  function window.setDim(self,w,h)
    self.w,self.h = w,h
  end
  
  function window.getDim(self)
    return self.w,self.h
  end
  
  return window
end

-- MUI Widget System

mui.widget = {}

mui.widget.types = {}

local files = love.filesystem.enumerate('mui/widgets')
mui.widget.types = {}
for k, file in ipairs(files) do
  local temp_widget_type = require('mui/widgets/'..file..'/'..file)
  mui.widget.types[file] = temp_widget_type
end

function mui.widget.new(type)
  local temp = mui.widget.types["raw"].new()
  if mui.widget.types[type] then
    local temp_widget = mui.widget.types[type].new()
    for k,v in pairs(temp_widget) do
      temp[k] = v
    end
  end
  temp:load()
  return temp
end

function mui.inrange(obj,x,y)
  if not x then
    x = love.mouse.getX()
  end
  if not y then
    y = love.mouse.getY()
  end
  if x > obj.x and x < obj.x + obj.w and y > obj.y and y < obj.y + obj.h then
    return true
  else
    return false
  end
end

return mui
