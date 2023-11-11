local Lexer = require("Lexer")

local example1 = "CREATE TABLE MyT (name TEXT, banned BOOL, points DOUBLE)"
local example2 = "INSERT INTO MyT VALUES (ID_ROBLOX_USER, 'cc', false, 0.5)"

local tokens = Lexer.ParseCode(example2)

for i = 1, #tokens do
    print(tokens[i]:debug())
end