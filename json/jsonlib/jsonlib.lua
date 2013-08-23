require("jsonlib/json")

jsonlib = {}

function jsonlib.read(filename)
  local f = assert(io.open(filename, "r"))
  local t = f:read()
  f:close()
  return json.decode(t)
end

function jsonlib.write(filename,data)
  local f = assert(io.open(filename, "w"))
  local t = f:write(json.encode(data))
  f:close()
end


return jsonlib
