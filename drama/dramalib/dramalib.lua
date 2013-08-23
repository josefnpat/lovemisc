libdrama = {}

libdrama.vpad_perc = 5
libdrama.hpad_perc = 5
libdrama.vpad = love.graphics.getWidth()*libdrama.vpad_perc/100
libdrama.hpad = love.graphics.getHeight()*libdrama.hpad_perc/100
libdrama.speaker_color = {255,255,255,255}
libdrama.non_speaker_color = {255,255,255,127}
libdrama.text_color = {0,255,0,255}
libdrama.top_perc = 60
libdrama.top = (love.graphics.getHeight()-2*libdrama.vpad)*libdrama.top_perc/100
libdrama.font = "assets/Orbitron-Bold.ttf"
libdrama.font_small = love.graphics.newFont(libdrama.font,16)
libdrama.font_large = love.graphics.newFont(libdrama.font,32)
libdrama.textspeed = 0.05

function libdrama.load(scene)
  libdrama.linedt = 0
  libdrama.linedt_count = 0
  libdrama.line = 1
  libdrama.scene = scene
  libdrama.curline = libdrama.scene.lines[1]
end

function libdrama.draw()
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  local orig_font = love.graphics.getFont()
  
  love.graphics.setFont(libdrama.font_large)
  local line_height = libdrama.font_large:getHeight()
  
  if libdrama.curline.left then
    if libdrama.curline.speaker == "left" or libdrama.curline.speaker == "both" then
      love.graphics.setColor(libdrama.speaker_color)
    else
      love.graphics.setColor(libdrama.non_speaker_color)
    end
    
    if libdrama.curline.left.img then
      local scale = libdrama.top/libdrama.curline.left.img:getHeight()
      love.graphics.draw(libdrama.curline.left.img,love.graphics.getWidth()/4,libdrama.vpad,0,scale,scale,libdrama.curline.left.img:getWidth()/2,0)
    end
    if libdrama.curline.left.name then
      love.graphics.setFont(libdrama.font_small)
      love.graphics.printf(libdrama.curline.left.name,0,libdrama.top+libdrama.vpad,love.graphics.getWidth()/2,"center")
      love.graphics.setFont(libdrama.font_large)
    end
  end
  
  if libdrama.curline.right then
    if libdrama.curline.speaker == "right" or libdrama.curline.speaker == "both" then
      love.graphics.setColor(libdrama.speaker_color)
    else
      love.graphics.setColor(libdrama.non_speaker_color)
    end
    
    if libdrama.curline.right.img then
      local scale = libdrama.top/libdrama.curline.left.img:getHeight()
      love.graphics.draw(libdrama.curline.right.img,love.graphics.getWidth()*3/4,libdrama.vpad,0,-scale,scale,libdrama.curline.right.img:getWidth()/2,0)
    end
    if libdrama.curline.right.name then
      love.graphics.setFont(libdrama.font_small)
      love.graphics.printf(libdrama.curline.right.name,love.graphics.getWidth()/2,libdrama.top+libdrama.vpad,love.graphics.getWidth()/2,"center")
      love.graphics.setFont(libdrama.font_large)
    end
  end
  
  if libdrama.curline.text then
    love.graphics.setColor(libdrama.text_color)
    local cur = libdrama.linedt_count
    local max = string.len(libdrama.curline.text)
    love.graphics.printf(string.sub(libdrama.curline.text,1,math.floor(cur)),libdrama.vpad,libdrama.top+libdrama.vpad+line_height*2,love.graphics.getWidth()-libdrama.vpad*2,"center")
    if cur > max + 500 * libdrama.textspeed then
      love.graphics.setFont(libdrama.font_small)
      love.graphics.setColor(libdrama.non_speaker_color)
      love.graphics.printf("[press any key to continue]",0,love.graphics.getHeight()-libdrama.vpad-line_height,800,"center")
    end
  end
  
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
  if orig_font then
    love.graphics.setFont(orig_font)
  end
end

function libdrama.keypressed(key,uni)
  if libdrama.linedt_count < string.len(libdrama.curline.text) then
    libdrama.linedt_count = string.len(libdrama.curline.text)
  else
    libdrama.parseline()
  end
end

function libdrama.update(dt)
  libdrama.linedt = libdrama.linedt + dt
  if libdrama.linedt > libdrama.textspeed then
    libdrama.linedt = libdrama.linedt - libdrama.textspeed
    libdrama.linedt_count = libdrama.linedt_count + 1
  end
end

function libdrama.parseline()
  libdrama.linedt = 0
  libdrama.linedt_count = 0
  libdrama.line = libdrama.line + 1
  if libdrama.scene.lines[libdrama.line] then
    --left
    if libdrama.scene.lines[libdrama.line].left then
      if libdrama.scene.lines[libdrama.line].left.name then
        libdrama.curline.left.name = libdrama.scene.lines[libdrama.line].left.name
      end -- otherwise don't change
      if libdrama.scene.lines[libdrama.line].left.img then
        libdrama.curline.left.img = libdrama.scene.lines[libdrama.line].left.img
      end -- otherwise don't change
      
    end -- otherwise don't change
    --right
    if libdrama.scene.lines[libdrama.line].right then
      if libdrama.scene.lines[libdrama.line].right.name then
        libdrama.curline.right.name = libdrama.scene.lines[libdrama.line].right.name
      end -- otherwise don't change
      if libdrama.scene.lines[libdrama.line].right.img then
        libdrama.curline.right.img = libdrama.scene.lines[libdrama.line].right.img
      end -- otherwise don't change
      
    end -- otherwise don't change
    
    -- base
    if libdrama.scene.lines[libdrama.line].text then
      libdrama.curline.text = libdrama.scene.lines[libdrama.line].text
    end -- otherwise don't change
    
    if libdrama.scene.lines[libdrama.line].speaker then
      libdrama.curline.speaker = libdrama.scene.lines[libdrama.line].speaker
    end -- otherwise don't change
    
  else
    if libdrama.done then
      libdrama.done()
    end
  end
end

return libdrama
