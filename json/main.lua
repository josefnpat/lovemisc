require("jsonlib/jsonlib")

local temp = {}
temp.x = 12
temp.y = 1234
temp.name = "George"
temp.data = {}
temp.data.time = os.time()

jsonlib.write("test.json",temp)


local temp2 = jsonlib.read("test.json")

print("Current time:"..temp2.data.time)

love.event.quit()
