local Lexer = require("Lexer")
local Parser = require("Parser")

local tokens = Lexer.ParseCode("CREATE TABLE MyT (mon_nom TEXT, my_name INT)")
local res = Parser.run(tokens)
Parser.show(res)

tokens = Lexer.ParseCode("INSERT INTO MyT VALUES (ID_ROBLOX_USER, 'cc', false, 100.0)")
res = Parser.run(tokens)
Parser.show(res)