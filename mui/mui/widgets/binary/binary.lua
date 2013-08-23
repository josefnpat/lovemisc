local binary = {}

function binary.new()
  local widget = {}
  
  widget.toggle = false
  function widget.getToggle(self)
    return self.toggle
  end
  
  function widget.setToggle(self,tog)
    if tog == nil then
      self.toggle = not self.toggle
    else
      self.toggle = tog
    end
  end
  
  function widget.draw(self)
    if self.toggle then
      love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
    else
      love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
    end
  end
  
  return widget
end

return binary
