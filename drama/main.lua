d = require("dramalib/dramalib")

scene = {}
scene.lines = {}

line = {}
line.speaker = "left"
line.text = "\"Well done Pete!\""

line.left = {}
line.left.img = love.graphics.newImage("assets/6.png")
line.left.name = "Seppi"
line.right = {}
line.right.img = love.graphics.newImage("assets/10.png")
line.right.name = "Pete"
table.insert(scene.lines,line)

line = {}
line.speaker = "right"
line.text = "\"Thanks!\""
table.insert(scene.lines,line)

line = {}
line.speaker = "both"
line.text = "..."
table.insert(scene.lines,line)

line = {}
line.speaker = "none"
line.text = "... ..."
table.insert(scene.lines,line)

line = {}
line.speaker = "left"
line.text = "\"I was mocking you...\""
line.left = {}
line.left.img = love.graphics.newImage("assets/7.png")
line.left.name = "Downer Seppi"
table.insert(scene.lines,line)

line = {}
line.speaker = "right"
line.text = "\"Oh... Well that wasn't very nice at all, I must say! Oh dear.\""
line.right = {}
line.right.img = love.graphics.newImage("assets/8.png")
line.right.name = "Pete (Silly Looking)"
table.insert(scene.lines,line)

function love.load(arg)
  d.load(scene)
end

function love.draw()
  d.draw()
end

function love.keypressed(key,uni)
  d.keypressed(key,uni)
end

function libdrama.done()
  love.event.quit()
end

function love.update(dt)
  libdrama.update(dt)
end

