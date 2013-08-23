dropdownlib = {}

dropdownlib.font = love.graphics.newFont("dropdownlib/DejaVuSansCondensed.ttf")
dropdownlib.font_height = dropdownlib.font:getHeight()
dropdownlib.padding = 4
dropdownlib.buttons = love.graphics.newImage("dropdownlib/buttons.png")
dropdownlib.button_size = 14
dropdownlib.button_down = love.graphics.newQuad(0,0,dropdownlib.button_size,dropdownlib.button_size,dropdownlib.buttons:getWidth(),dropdownlib.buttons:getHeight())
dropdownlib.button_up = love.graphics.newQuad(dropdownlib.button_size,0,dropdownlib.button_size,dropdownlib.button_size,dropdownlib.buttons:getWidth(),dropdownlib.buttons:getHeight())

dropdownlib.color = {}
dropdownlib.color.background = {192,192,192}
dropdownlib.color.text = {0,0,0}
dropdownlib.color.hover = {255,127,127}

function dropdownlib.new(list,x,y,w)
  dd = {}
  -- parse input
  dd.list = list
  dd.x = x
  dd.y = y
  dd.w = w
  -- internal vars
  dd.active = false
  dd.current_index = 1
  dd.hover = nil
  -- functions
  dd.draw = dropdownlib.draw
  dd.update = dropdownlib.update
  dd.mousepressed = dropdownlib.mousepressed
  dd.keypressed = dropdownlib.keypressed
  dd.getvalue = dropdownlib.getvalue
  -- yay!
  return dd
end

function dropdownlib:draw()
  local old_font = love.graphics.getFont()
  love.graphics.setFont(dropdownlib.font)
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(dropdownlib.color.background)
  if self.active then
    love.graphics.rectangle("fill",self.x,self.y,self.w,(dropdownlib.font_height+dropdownlib.padding*2)*#self.list)
  else
    love.graphics.rectangle("fill",self.x,self.y,self.w,dropdownlib.font_height+dropdownlib.padding*2)
    love.graphics.drawq(dropdownlib.buttons,dropdownlib.button_down,
      self.x+self.w-dropdownlib.button_size-dropdownlib.padding,
      self.y+dropdownlib.padding
    )
  end
  love.graphics.setColor(dropdownlib.color.text)
  if self.active then
    if self.hover then
      love.graphics.setColor(dropdownlib.color.hover)
      love.graphics.rectangle("fill",self.x,self.y+(dropdownlib.font_height+dropdownlib.padding*2)*(self.hover-1), self.w, dropdownlib.font_height+dropdownlib.padding*2)
      love.graphics.setColor(dropdownlib.color.text)
    end
    for i,v in ipairs(self.list) do
      love.graphics.print(v,self.x+dropdownlib.padding,self.y+dropdownlib.padding+(i-1)*(dropdownlib.font_height+dropdownlib.padding*2))
    end
  else
      love.graphics.print(self.list[self.current_index],self.x+dropdownlib.padding,self.y+dropdownlib.padding)
  end
  if old_font then
    love.graphics.setFont(old_font)
  end
  love.graphics.setColor(r,g,b,a)
end

function dropdownlib:update(dt)
  if self.active then
    local x,y = love.mouse.getPosition()
    if x > self.x and x < self.x + self.w and 
      y > self.y and y < self.y + (dropdownlib.font_height+dropdownlib.padding*2)*#self.list then
      self.hover = math.floor((y-self.y)/(dropdownlib.font_height+dropdownlib.padding*2))+1
    else
      self.hover = nil
    end
  end
end

function dropdownlib:mousepressed(x,y,button)
  if self.hover then
    self.current_index = self.hover
  end
  if x > self.x and
    x < self.x+self.w and
    y < self.y+dropdownlib.button_size+dropdownlib.padding*2 and
    y > self.y then
    self.active = not self.active
  else
    self.active = false
    self.hover = nil
  end
end

function dropdownlib:getvalue()
  return self.list[self.current_index]
end

return dropdownlib
