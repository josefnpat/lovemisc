buttonlib = {}
local theme = "blue_200"
buttonlib.img_inactive = love.graphics.newImage("buttonlib/"..theme.."/inactive.png")
buttonlib.img_active = love.graphics.newImage("buttonlib/"..theme.."/active.png")
buttonlib.img_depress = love.graphics.newImage("buttonlib/"..theme.."/depress.png")
buttonlib.img_disabled = love.graphics.newImage("buttonlib/"..theme.."/disabled.png")
buttonlib.font = love.graphics.newFont("buttonlib/DejaVuSansCondensed.ttf",16)
buttonlib.q_left = love.graphics.newQuad(0,0,16,32,33,32)
buttonlib.q_center = love.graphics.newQuad(16,0,1,32,33,32)
buttonlib.q_right = love.graphics.newQuad(17,0,16,32,33,32)
buttonlib.active = false
buttonlib.data = {}

function buttonlib.new(text,x,y,callback)
  local button = {}
  -- functions
  button.draw = buttonlib.draw
  button.update = buttonlib.update
  button.mousepressed = buttonlib.mousepressed
  button.mousereleased = buttonlib.mousereleased
  button.mouseintersect = buttonlib.mouseintersect
  button.getWidth = buttonlib.getWidth
  button.getHeight = buttonlib.getHeight

  -- required vars
  button.text = text
  button.x = x
  button.y = y
  button.callback = callback
  -- init vars
  button.disabled = false
  button.active = false
  
  return button
end

function buttonlib:draw()
  local text_width = buttonlib.font:getWidth(self.text)
  local text_height = buttonlib.font:getHeight(self.text)
  local img
  if self.disabled then
    img = buttonlib.img_disabled
  elseif self.depress then
    img = buttonlib.img_depress
  elseif self.active then
    img = buttonlib.img_active
  else
    img = buttonlib.img_inactive
  end
  love.graphics.drawq(img,buttonlib.q_left,self.x,self.y)
  love.graphics.drawq(img,buttonlib.q_center,self.x+16,self.y,0,text_width,1)
  love.graphics.drawq(img,buttonlib.q_right,self.x+16+text_width,self.y)
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  if self.disabled then
    love.graphics.setColor(255,255,255,127)
  else
    love.graphics.setColor(255,255,255,255)
  end
  local old_font = love.graphics.getFont()
  love.graphics.setFont(buttonlib.font)
  love.graphics.print(self.text,self.x+16,self.y-text_height/2+16)
  if old_font then
    love.graphics.setFont(old_font)
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

function buttonlib:update(dt)
  if self:mouseintersect() then
    self.active = true
  else
    self.active = false
  end
end

function buttonlib:mousepressed(x,y,button)
  if button == "l" and self:mouseintersect() then
    self.depress = true
  else
    self.depress = false
  end
end

function buttonlib:mousereleased(x,y,button)
  if button == "l" then
    self.depress = false
    if self:mouseintersect() then
      if not self.disabled then
        if _G[self.callback] then
          _G[self.callback]()
        else
          print("function `"..self.callback.."` not defined")
        end
      end
    end
  end
end

-- Mouse intersect
function buttonlib:mouseintersect()
  local x,y = love.mouse.getPosition()
  if self.x <= x and x <= self.x + self:getWidth() and self.y <= y and y <= self.y + self:getHeight() then
    return true
  end
end

function buttonlib:getWidth()
  return buttonlib.font:getWidth(self.text)+32
end

function buttonlib:getHeight()
  return 32
end

--[[
function buttonlib.drawb(b,x,y)
  b.x = x
  b.y = y
  local text_width = buttonlib.font:getWidth(b.text)
  local text_height = buttonlib.font:getHeight(b.text)
  local img = buttonlib.img_inactive
  if b.active then
    img = buttonlib.img_active
  end
  if b.depress then
    img = buttonlib.img_depress
  end
  if b.disabled then
    img = buttonlib.img_disabled
  end
  love.graphics.drawq(img,buttonlib.q_left   ,x              ,y)
  love.graphics.drawq(img,buttonlib.q_center ,x+16           ,y,0,text_width,1)
  love.graphics.drawq(img,buttonlib.q_right  ,x+16+text_width,y)
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  if b.disabled then
    love.graphics.setColor(255,255,255,127)
  else
    love.graphics.setColor(255,255,255,255)
  end
  local old_font = love.graphics.getFont()
  love.graphics.setFont(buttonlib.font)
  love.graphics.print(b.text,x+16,y-text_height/2+16)
  if old_font then
    love.graphics.setFont(old_font)
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

function buttonlib.newButton(text,cb)
  local b = {
    x=0,
    y=0,
    text=text,
    cb=cb,
    disabled=false
  }
  local width = buttonlib.font:getWidth(text) + 32
  b.getWidth = function() return width end
  b.getHeight = function() return 32 end
  return b
end


function buttonlib.update(butarray)
  for _,v in pairs(butarray) do
    if buttonlib.mouseIntersect(v) then
      v.active = true
    else
      v.active = false
    end
  end
end

function buttonlib.mousepressed(b,butarray)
  if b == "l" then
    for _,v in pairs(butarray) do
      if buttonlib.mouseIntersect(v) then
        v.depress = true
      else
        v.depress = false
      end
    end
  end
end

function buttonlib.mousereleased(b,butarray)
  if b == "l" then
    for _,v in pairs(butarray) do
      v.depress = false
      if buttonlib.mouseIntersect(v) then
        if not v.disabled then
          if buttonlib.pressed then
            buttonlib.pressed(v.cb)
          else
            print("function buttonlib.pressed(cb) not defined")
          end
        end
      end
    end
  end
end

--]]




return buttonlib
