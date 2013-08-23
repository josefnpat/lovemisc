videolib = {}

videolib.frames = {}

videolib.audio = "output.mp3"
videolib.audio_source = love.audio.newSource( videolib.audio, "stream" )

function videolib.start()
  videolib.playing = true
  videolib.frame = 1
  videolib.dt = 0
  love.audio.play(videolib.audio_source)
end

function videolib.update(dt)
  if videolib.playing then
    videolib.dt = videolib.dt + dt
    while videolib.dt > 1/videolib.frames.fps do
      videolib.dt = videolib.dt - 1/videolib.frames.fps
      videolib.frame = videolib.frame + 1
      videolib.newframe = true
    end
    if videolib.newframe then
      videolib.newframe = nil
      if videolib.frame > videolib.frames.total then
        love.audio.stop(videolib.audio_source)
        videolib.frame_current = nil
        videolib.playing = nil
      else
        videolib.frame_current = love.graphics.newImage(videolib.frames.prefix..videolib.frame..videolib.frames.postfix)
      end
    end
  end
end

function videolib.draw()
  if videolib.playing and videolib.frame_current then
    love.graphics.draw(videolib.frame_current,0,0)
  end
end

return videolib
