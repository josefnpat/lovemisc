bubblelib = {}

bubblelib.corner = love.graphics.newImage("bubblelib/corner.png")
bubblelib.font = love.graphics.newFont("bubblelib/DejaVuSansCondensed.ttf",16)
bubblelib.color = {15,15,15,255}
bubblelib.background_color = {240,240,240,255}

function bubblelib.getWidthMaxWithNewlines(text)
  local raw = explode("\n",text)
  max = 0
  for i,v in ipairs(raw) do
    if bubblelib.font:getWidth(v) > max then
      max = bubblelib.font:getWidth(v)
    end
  end
  return #raw,max
end

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function bubblelib.draw(text,x,y,cur,max,speakerx,speakery)
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  if not max then max = 1 end
  if not cur then cur = max end
  local lines,w = bubblelib.getWidthMaxWithNewlines(text)
  local h = bubblelib.font:getHeight(text) * lines
  love.graphics.setColor(bubblelib.background_color)

  love.graphics.draw(bubblelib.corner,x,y,0,1,1,bubblelib.corner:getWidth(),bubblelib.corner:getHeight())
  love.graphics.draw(bubblelib.corner,x+w,y,math.pi/2,1,1,bubblelib.corner:getWidth(),bubblelib.corner:getHeight())
  love.graphics.draw(bubblelib.corner,x+w,y+h,math.pi,1,1,bubblelib.corner:getWidth(),bubblelib.corner:getHeight())
  love.graphics.draw(bubblelib.corner,x,y+h,math.pi*3/2,1,1,bubblelib.corner:getWidth(),bubblelib.corner:getHeight())

  love.graphics.rectangle("fill",x-bubblelib.corner:getWidth(),y,w+bubblelib.corner:getWidth()*2,h)
  love.graphics.rectangle("fill",x,y-bubblelib.corner:getHeight(),w,h+bubblelib.corner:getHeight()*2)
  
  if not speakerx then speakerx = x+w/2 end
  
  if speakery then
    love.graphics.triangle("fill",x+w/2-16,y+h,x+w/2+16,y+h,speakerx,speakery)
  end
  
  love.graphics.setColor(bubblelib.color)
  local old_font = love.graphics.getFont()
  love.graphics.setFont(bubblelib.font)
  if cur and max then
    love.graphics.print(string.sub(text,1,math.floor(string.len(text)*cur/max)),x,y)
  else
    love.graphics.print(text,x,y)  
  end
  if old_font then
    love.graphics.setFont(old_font)
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

return bubblelib
