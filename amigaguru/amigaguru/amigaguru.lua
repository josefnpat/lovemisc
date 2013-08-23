amigaguru = {}

function amigaguru.load(args)
  amigaguru.text = amigaguru.generate("00000004.48454C50")
  amigaguru.font = love.graphics.newFont("amigaguru/PressStart2P.ttf")
end

function amigaguru.generate(errorno)
  return "Software Failure. Press left mouse button to continue.\nGuru Meditation #"..errorno
end


function amigaguru.draw()
  local width = amigaguru.font:getWidth(amigaguru.text)
  local a_width,lines = amigaguru.font:getWrap(amigaguru.text,width)
  local height = amigaguru.font:getHeight()
  local space_width = a_width+height
  
  local old_lw = love.graphics.getLineWidth()
  love.graphics.setLineWidth(height)
  local old_color = {love.graphics.getColor()}
  love.graphics.setColor(255,0,0,255)
  local old_font = love.graphics.getFont()
  love.graphics.setFont(amigaguru.font)
  
  love.graphics.printf(amigaguru.text,0,height*2,love.graphics.getWidth(),"center")
  if amigaguru.dt%1 > 0.5 then
    love.graphics.rectangle("line",(love.graphics.getWidth()-space_width)/2,height,space_width,(lines+2)*height)
  end
  
  love.graphics.setLineWidth(old_lw)
  love.graphics.setColor(old_color)
  love.graphics.setFont(old_font)
end

amigaguru.dt = 0
function amigaguru.update(dt)
  amigaguru.dt = amigaguru.dt + dt
end

return amigaguru
