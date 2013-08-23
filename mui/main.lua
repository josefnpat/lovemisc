mui = require("mui/mui")

-- Love Hooks

function love.load(arg)
  -- window example 
  window = mui.window.new()
  window:setLoc(32,32)
  window:setDim(800-64,600-64)
  mui:add(window)

  -- raw widget example

  raw = mui.widget.new("raw")
  raw:setLoc(64,64)
  raw:setDim(32,32)
  window:add(raw)
  
  -- text widget example
  
  text = mui.widget.new("text")
  text:setLoc(128,64)
  text:setDim(128,32)
  text:setText("Hello World")
  window:add(text)

  -- button widget example

  button = mui.widget.new("binary")
  button:setLoc(256+32,64)
  button:setDim(32,32)
  function button.mousepressed(self,x,y,button)
    self:setToggle(true)
  end
  function button.mousereleased(self,x,y,button)
    self:setToggle(false)
    console:echo("Button pushed",1)
  end
  function button.update(self,dt)
    if not mui.inrange(self) then
      self.toggle = false
    end  
  end
  window:add(button)
  
  -- switch widget example

  switch = mui.widget.new("binary")
  switch:setLoc(256+96,64)
  switch:setDim(32,32)
  function switch.mousepressed(self,x,y,button)
    self:setToggle()
    if self:getToggle() then
      console:echo("Switch toggled on",1)
    else
      console:echo("Switch toggled off",1)
    end
  end
  window:add(switch)

  -- switches example

  switches = {}

  switches[1] = mui.widget.new("binary")
  switches[1]:setToggle(true)
  switches[1]:setLoc(32*2,128)
  switches[1]:setDim(32,32)
  switches[1].mousepressed = function (self,x,y,button)
    console:echo("Switch 1 toggled",1)
    switches[1]:setToggle(true)
    switches[2]:setToggle(false)
    switches[3]:setToggle(false)
    switches[4]:setToggle(false)
  end
  switches[2] = mui.widget.new("binary")
  switches[2]:setLoc(32*3,128)
  switches[2]:setDim(32,32)
  switches[2].mousepressed = function (self,x,y,button)
    console:echo("Switch 2 toggled",1)
    switches[1]:setToggle(false)
    switches[2]:setToggle(true)
    switches[3]:setToggle(false)
    switches[4]:setToggle(false)
  end
  switches[3] = mui.widget.new("binary")
  switches[3]:setLoc(32*4,128)
  switches[3]:setDim(32,32)
  switches[3].mousepressed = function (self,x,y,button)
    console:echo("Switch 3 toggled",1)
    switches[1]:setToggle(false)
    switches[2]:setToggle(false)
    switches[3]:setToggle(true)
    switches[4]:setToggle(false)
  end
  switches[4] = mui.widget.new("binary")
  switches[4]:setLoc(32*5,128)
  switches[4]:setDim(32,32)
  switches[4].mousepressed = function (self,x,y,button)
    console:echo("Switch 4 toggled",1)
    switches[1]:setToggle(false)
    switches[2]:setToggle(false)
    switches[3]:setToggle(false)
    switches[4]:setToggle(true)
  end

  window:add(switches[1])
  window:add(switches[2])
  window:add(switches[3])
  window:add(switches[4])

  -- flashing light example

  light = mui.widget.new("binary")
  light:setLoc(32*7,128)
  light:setDim(32,32)
  light.dt = 0
  function light.update(self,dt)
    self.dt = self.dt + dt
    if self.dt % 1 > 0.5 then
      self:setToggle(true)
    else
      self:setToggle(false)
    end
  end
  window:add(light)


  -- slider example

  slider = mui.widget.new("real")
  slider:setValue(0.5)
  slider:setLoc(64,192)
  slider:setDim(256,32)
  function slider.mousereleased(self,x,y,button)
    self.focus = false
    console:echo("slider "..self:getValue(),1)
  end
  window:add(slider)

  -- slider with resolution example

  slider = mui.widget.new("real")
  slider:setValue(0.5)
  slider.draw2 = slider.draw
  function slider.draw(self)
    self:draw2()
  end
  function slider.update(self,dt)
    if mui.inrange(self) then
      if self.focus then
        x = love.mouse.getX()
        self.value = math.floor(((x - self.x)/self.w)*10+0.5)/10
      end
    else
      self.focus = false
    end
  end
  slider:setLoc(64,256)
  slider:setDim(256,32)
  function slider.mousereleased(self,x,y,button)
    self.focus = false
    console:echo("slider "..self:getValue(),1)
  end
  window:add(slider)

  -- loading bar example

  bar = mui.widget.new("real")
  bar:setLoc(64,386)
  bar:setDim(256,32)
  function bar.update(self,dt)
    self.value = (self.value + dt)%1
  end
  window:add(bar)

  -- console example

  console = mui.widget.new("console")
  console:setLoc(500-64,300-64)
  console:setDim(300,300)
  console:echo("Welcome to the example.",1)
  function console.callback(self,line)
    if line == "help" then
      self:echo("ctrl-c: cancel")
      self:echo("ctrl-l: clear")
      self:echo("help: this screen")     
    else
      self:echo("Invalid command.")
    end
  end
  function console.mousepressed(self)
    self:echo("STOP CLICKING HERE.",1)
  end
  window:add(console)

  mui:load(arg)
end

function love.draw()
  mui:draw()
  love.graphics.print(love.timer.getFPS(),0,0)
end

function love.update(dt)
  mui:update(dt)
end

function love.keypressed(key,unicode)
  mui:keypressed(key,unicode)
end

function love.keyreleased(key)
  mui:keyreleased(key)
end

function love.mousepressed(x,y,button)
  mui:mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
  mui:mousereleased(x,y,button)
end
