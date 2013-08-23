-- TODO: This initializes the default font before getFont() can get to this.
-- This can be removed for the tag after 0.8.0, but will break compatability
-- https://bitbucket.org/rude/love/changeset/c9f31b85db1d9b7d5af00cd628684668dad3f78e
love.graphics.setNewFont(12)

local raw = {}

function raw.new()
  local widget = {}
  
  -- Love hooks
  
  function widget.load(self,arg)
    --print("undefined: load",arg)
  end
  function widget.draw(self)
    local font = love.graphics.getFont()
    local text = "Raw"
    local lineheight,lines = font:getWrap(text, self.w)
    height = font:getHeight() * lines
    love.graphics.printf(text,self.x,self.y+(self.h-height)/2,self.w,"center")
    love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
  end
  function widget.update(self,dt)
    --print("raw update",dt)
  end
  function widget.keypressed(self,key,unicode)
    --print("undefined: keypressed",key,unicode)
  end
  function widget.keyreleased(self,key)
    --print("undefined: keyreleased",key)
  end
  function widget.mousepressed(self,x,y,button)
    --print("undefined: mousepressed",x,y,button)
  end
  function widget.mousereleased(self,x,y,button)
    --print("undefined: mousereleased",x,y,button)
  end
  
  -- Widget Properties
  widget.x = 0
  widget.y = 0
  widget.w = 32
  widget.h = 32
  
  function widget.setLoc(self,x,y)
    self.x,self.y = x,y
  end
  
  function widget.getLoc(self)
    return self.x,self.y
  end
  
  function widget.setDim(self,w,h)
    self.w,self.h = w,h
  end
  
  function widget.getDim(self)
    return self.w,self.h
  end
  
  return widget
end

return raw
