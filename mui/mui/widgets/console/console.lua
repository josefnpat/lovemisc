local text = {}

function text.new()
  local widget = {}
  function widget.load(self,args)
    if not self.lines then
      self.lines = {}
    end
    self.font = love.graphics.newFont("mui/widgets/console/UbuntuMono-Regular.ttf")

    self.key_disable = { --keys to disable in case they are not in use.
      "up","down","left","right","home","end","pageup","pagedown",--Navigation keys
      "insert","tab","clear","delete",--Editing keys
      "f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12","f13","f14","f15",--Function keys
      "numlock","scrollock","ralt","lalt","rmeta","lmeta","lsuper","rsuper","mode","compose",--Modifier keys
      "pause","escape","help","print","sysreq","break","menu","power","euro","undo"--Miscellaneous keys
    }
    self.key_capslock = false
    self.key_shift = false
    self.key_ctrl = false
    self.key_alt = false
    self.blink = false
    self.blink_dt = 0
    self.blink_t = 0.25
    self.blink_cursor = "_"
    self.prompt = "$\194\160"
    self.padding = 2
  end
  function widget.in_table(t,s)
    for i,v in pairs(t) do
      if (v==s) then 
        return true
      end
    end
  end
  function widget.update(self,dt)
    self.blink_dt = self.blink_dt + dt
    if self.blink_dt > self.blink_t then
      self.blink = not self.blink
      self.blink_dt = self.blink_dt - self.blink_t
    end
  end
  function widget.draw(self)
    local ofont = love.graphics.getFont()
    love.graphics.setFont(self.font)
    local ocolor = {love.graphics.getColor()}
    love.graphics.setColor(0,127,0,255)
    love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
    love.graphics.setColor(0,255,0,255)
    local valid_size = false
    local text
    repeat
      text = ""
      for i,v in ipairs(self.lines) do
        if i == #self.lines then
          text = text .. self.prompt .. v
        else
          text = text .. v .. "\n"
        end
      end

      if self.blink then
        text = text .. self.blink_cursor
      end

      local lineheight,lines = self.font:getWrap(text, self.w-self.padding*2)
      local height = self.font:getHeight() * lines
      if height > self.h - self.padding*2 then
        table.remove(self.lines,1)
      else
        valid_size = true
      end
    until valid_size
    love.graphics.setScissor(self.x,self.y,self.w,self.h)
    love.graphics.printf(text,self.x+self.padding,self.y+self.padding,self.w-self.padding*2,"left")
    love.graphics.setScissor()
    love.graphics.setFont(ofont)
    love.graphics.setColor(ocolor)
  end
  function widget.keypressed(self,key,unicode)
    local current_line = table.remove(self.lines) or ""
    if key == "backspace" then -- remove last character
      current_line = string.sub(current_line,1,-2)
    elseif key == "rshift" or key == "lshift" then -- enable shift
      self.key_shift = true
    elseif key == "capslock" then -- enable capslock
      self.key_capslock = true
    elseif key == "lctrl" or key == "rctrl" then -- enable ctrl
      -- This does not account for someone who pushes both ctrl keys.
      -- Who does that anyway?
      self.key_ctrl = true
    elseif key == "c" and self.key_ctrl then -- ctrl-c to cancel
      table.insert(self.lines,current_line.."^c")
      current_line = ""
    elseif key == "l" and self.key_ctrl then -- ctrl-l to clear
      self.lines = {}
    elseif key == "p" and self.key_ctrl then -- ctrl-p for last executed line
      if self.last_line then
        current_line = self.last_line
      end
    elseif key == "return"  or key == "kpenter" then -- return key
      table.insert(self.lines,self.prompt..current_line)
      if self.callback then
        self.last_line = current_line
        self:callback(current_line)
      end
      current_line = ""
    elseif string.sub(key,1,2) == "kp" then --keypad to std keypad values
      current_line = current_line .. string.sub(key,3,-1)
    elseif self.in_table(self.key_disable,key) then
      -- do nothing, this key is disabled.
    else -- alphabet and multi key presses
      if self.key_shift or self.key_capslock then
        key = string.char(unicode)
      end
      current_line = current_line .. key  
    end

    table.insert(self.lines,current_line)
  end
  function widget.keyreleased(self,key,unicode)
    if key == "rshift" or key == "lshift" then -- disable shift
      self.key_shift = false
    elseif key == "capslock" then-- disable capslock
      self.key_capslock = false
    elseif key == "lctrl" or key == "rctrl" then --disable ctrl
      self.key_ctrl = false
    end
  end
  function widget.echo(self,text,newline)
    if self.lines then
      if newline then
        last_line = table.remove(self.lines) or ""
      end
    else
      self.lines = {}
    end
    table.insert(self.lines,text)
    if newline then
      if last_line then
        table.insert(self.lines,last_line)
      else
        table.insert(self.lines,"")
      end
    end
  end
  return widget
end

return text
