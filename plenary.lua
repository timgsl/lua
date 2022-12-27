local Path = require("plenary.path")
bd = "/Users/tim/src/playground/lua"
bdd = "/Users/tim/src/playground/lua/api"
test = Path:new(bd):make_relative(bdd)

print(test)
