require("videolib/videolib")

function love.update(dt)
  videolib.update(dt)
end

function love.draw()
  videolib.draw()
  love.graphics.print(love.timer.getFPS(),0,0)
end

function love.load()
  love.graphics.setCaption("sintel_trailer-480p.mp4")
  love.graphics.setMode(845,480,0,0,0)
  videolib.frames.prefix = "frames/frame-"
  videolib.frames.postfix = ".png"
  videolib.frames.total = 1304
  videolib.frames.fps = 25
  videolib.start()
end
