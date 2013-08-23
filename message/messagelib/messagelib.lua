messagelib = {}

function messagelib.load()
  messagelib.text = {}
  messagelib.text.font = love.graphics.newFont("messagelib/UbuntuMono-Bold.ttf",24)
  messagelib.text.color = {0,0,0,255}
  
  messagelib.bg = {}
  messagelib.bg.base = love.graphics.newImage("messagelib/bg_base.png")
  messagelib.bg.base:setFilter("nearest","nearest")
  messagelib.bg.next = love.graphics.newImage("messagelib/bg_next.png")
  messagelib.bg.next:setFilter("nearest","nearest")
  messagelib.bg.color = {255,255,255,255}
  
  messagelib.queue = {}
  messagelib.current = nil
  messagelib.dt = 0
  
  messagelib.base_padding = 8
  
  messagelib.setScale(1)
  
  -- public
  messagelib.text_speed = 0.05
end

function messagelib.setScale(scale)
  messagelib.scale = scale
  
  messagelib.text.font = love.graphics.newFont("messagelib/UbuntuMono-Bold.ttf",12*scale)
  
  messagelib.padding = messagelib.base_padding*scale
  messagelib.w = messagelib.bg.base:getWidth()*scale
  messagelib.h = messagelib.bg.base:getHeight()*scale
  messagelib.string_width = messagelib.w-2*messagelib.padding
  
  messagelib.x = math.floor((love.graphics.getWidth()-messagelib.w)/2)
  messagelib.y = math.floor((love.graphics.getHeight()-messagelib.h)/2)
end

function messagelib.draw()
  if messagelib.current then
    -- backup color and font
    local r,g,b,a = love.graphics.getColor()
    local old_font = love.graphics.getFont()
    -- background frame
    love.graphics.setColor(messagelib.bg.color)
    love.graphics.draw(messagelib.bg.base,messagelib.x,messagelib.y,0,messagelib.scale,messagelib.scale)
    if messagelib.done then
      love.graphics.draw(messagelib.bg.next,messagelib.x,messagelib.y,0,messagelib.scale,messagelib.scale)
    end
    -- Text
    love.graphics.setFont(messagelib.text.font)
    love.graphics.setColor(messagelib.text.color)
    love.graphics.printf(messagelib.getCurrentString(),messagelib.x+messagelib.padding,messagelib.y+messagelib.padding,messagelib.string_width,"left")
    -- restore color and font
    love.graphics.setColor(r,g,b,a)
    if old_font then
      love.graphics.setFont(old_font)
    end
  end
end

function messagelib.getCurrentString(n)
  local temp_i
  if n then
    temp_i = messagelib.index + 1
  else
    temp_i = messagelib.index
  end
  return string.sub(messagelib.current,messagelib.start,temp_i)
end

function messagelib.getCurrentLines(n)
  local w,l = messagelib.text.font:getWrap(messagelib.getCurrentString(n),messagelib.w-2*messagelib.padding)
  return l
end

messagelib.index,messagelib.start = 1,1

function messagelib.update(dt)
  if #messagelib.queue > 0 or messagelib.current then
    messagelib.max_lines = math.floor((messagelib.h-2*messagelib.padding)/messagelib.text.font:getHeight())--add to load
    if not messagelib.current and #messagelib.queue > 0 then
      messagelib.current = table.remove(messagelib.queue,1)
    end
    if messagelib.getCurrentLines(1) <= messagelib.max_lines then
      messagelib.dt = messagelib.dt + dt
      if messagelib.dt > messagelib.text_speed then
        messagelib.dt = messagelib.dt - messagelib.text_speed
        messagelib.index = messagelib.index + 1
      end
    else
      messagelib.done = true
    end
    if messagelib.index > #messagelib.current then
      messagelib.done = true
    end
  end
end

-- this function takes spacebar, and will switch to the next part of the message, or the next item in the queue.
function messagelib.keypressed(key,uni)
  if key == " " then
    if messagelib.done then
      if messagelib.index >= #messagelib.current then
        messagelib.index = 1
        messagelib.current = nil
      end
      messagelib.start = messagelib.index
      messagelib.done = nil
      messagelib.dt = 0
    end
  end
end

-- This function queues the next message
function messagelib.enqueue(message)
  table.insert(messagelib.queue,message)
end

-- returns if there is a message on the queue stack.
function messagelib.running()
  if messagelib.current then
    return true
  end
end

return messagelib
