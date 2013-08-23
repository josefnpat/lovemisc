local text = {}

function text.new()
  local widget = {}
  function widget.load(self,args)
    if not self.text then
      self.text = "Text Widget"
    end
  end
  function widget.draw(self)
    local font = love.graphics.getFont()
    local lineheight,lines = font:getWrap(self.text, self.w)
    height = font:getHeight() * lines
    love.graphics.printf(self.text,self.x,self.y+(self.h-height)/2,self.w,"center")
    love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
  end
  function widget.setText(self,text)
    self.text = text
  end
  function widget.getText(self)
    return self.text
  end
  return widget
end

return text
