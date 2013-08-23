iconlib = {}

iconlib.img_icons = love.graphics.newImage("iconlib/icons.png")
iconlib.img_icons:setFilter("nearest","nearest")
iconlib.img_bg = love.graphics.newImage("iconlib/bg.png")
iconlib.img_bg:setFilter("nearest","nearest")
iconlib.img_bg_w = iconlib.img_bg:getWidth()
iconlib.font = love.graphics.newFont("iconlib/DejaVuSansCondensed.ttf",16)

local i = 1
iconlib.quads = {}
for y=1,iconlib.img_icons:getHeight()/iconlib.img_bg_w do
  for x=1,iconlib.img_icons:getWidth()/iconlib.img_bg_w do
    iconlib.quads[i] = love.graphics.newQuad(
                         (x-1)*iconlib.img_bg_w,
                         (y-1)*iconlib.img_bg_w,
                         iconlib.img_bg_w,
                         iconlib.img_bg_w,
                         iconlib.img_icons:getWidth(),
                         iconlib.img_icons:getHeight() )
    i = i + 1
  end
end

iconlib.default = {}
iconlib.default.nohover = {127,127,127,255}
iconlib.default.hover = {191,191,191,255}
iconlib.default.click = {255,255,255,255}
iconlib.default.count_fgc = {255,255,255,255}
iconlib.default.count_bgc = {23,57,23,255}
iconlib.default.count_padding = 2
iconlib.click = false
iconlib.data = {}

function iconlib.draw()
  local orig_r,orig_g,orig_b,orig_a = love.graphics.getColor()
  for i,icon in ipairs(iconlib.data) do
    if i == iconlib.current then
      if iconlib.click then
        love.graphics.setColor(iconlib.default.click)
      else
        love.graphics.setColor(iconlib.default.hover)
      end
    else
      love.graphics.setColor(iconlib.default.nohover)
    end
    love.graphics.draw(iconlib.img_bg,icon.x,icon.y,0,icon.scale)
    love.graphics.drawq(iconlib.img_icons,iconlib.quads[icon.img],icon.x,icon.y,0,icon.scale)
    if icon.count then
      love.graphics.setColor(iconlib.default.count_bgc)
      local old_font = love.graphics.getFont()
      love.graphics.setFont(iconlib.font)
      love.graphics.rectangle("fill",icon.x,icon.y,iconlib.font:getWidth(icon.count)+iconlib.default.count_padding*2,iconlib.font:getHeight(icon.count)+iconlib.default.count_padding*2)
      love.graphics.setColor(iconlib.default.count_fgc)
      love.graphics.print(icon.count,icon.x+iconlib.default.count_padding,icon.y+iconlib.default.count_padding)
      if old_font then
        love.graphics.setFont(old_font)
      end
    end
  end
  love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
end

function iconlib.update(dt)
  iconlib.current = iconlib.mouseover()
end

function iconlib.mouseover()
  local mx,my = love.mouse.getPosition()
  for i,icon in ipairs(iconlib.data) do
    if mx >= icon.x and mx <= icon.x+iconlib.img_bg_w*icon.scale and 
       my >= icon.y and my <= icon.y+iconlib.img_bg_w*icon.scale then
      return i
    end
  end
end

function iconlib.mousepressed(x,y,button)
  iconlib.click = true
end

function iconlib.mousereleased(x,y,button)
  iconlib.click = false
  if iconlib.current then
    if iconlib.pressed then
      iconlib.pressed(iconlib.current,button)
    else
      print("iconslib.pressed() not defined.")
    end
  end
end

return iconlib
