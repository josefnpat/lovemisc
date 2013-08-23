animateworldlib = {}

function animateworldlib.load(folder_name)
  worlddata = {}
  for i = 1,360 do
    worlddata[i]=love.graphics.newImage(folder_name.."/"..i..".gif")
  end
  print(""..folder_name.." loaded.")
  return worlddata
end

return animateworldlib

