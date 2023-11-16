local Lexer = require("Lexer")
local Parser = require("Parser")

local example1 = "CREATE TABLE MyT (name TEXT, banned BOOL, points DOUBLE)"
local example2 = "INSERT INTO MyT VALUES (ID_ROBLOX_USER, 'cc', false, 100.0)"

local tokens = Lexer.ParseCode(example1)
result = Parser.run(tokens)

tokens = Lexer.ParseCode(example2)
result = Parser.run(tokens)