local real = {}

function real.new()
  local widget = {}
  widget.value = 0
  function widget.setValue(self,value)
    self.value = value
  end
  function widget.getValue(self)
    return self.value
  end
  function widget.draw(self)
    love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
    love.graphics.rectangle("fill",self.x+2,self.y+2,(self.w-4)*self.value,self.h-4)
  end
  widget.focus = false
  function widget.mousepressed(self,x,y,button)
    self.focus = true
  end
  function widget.mousereleased(self,x,y,button)
    self.focus = false
  end
  function widget.update(self,dt)
    if mui.inrange(self) then
      if self.focus then
        x = love.mouse.getX()
        self.value = (x - self.x)/self.w
      end
    else
      self.focus = false
    end
  end
  return widget
end

return real
