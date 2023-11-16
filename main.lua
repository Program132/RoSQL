local Lexer = require("Lexer")
local Parser = require("Parser")

local tokens = Lexer.ParseCode("CREATE TABLE MyT (mon_nom TEXT,)")
local res = Parser.run(tokens)
tokens = Lexer.ParseCode("INSERT INTO MyT VALUES (1, 'cc', false, 100.0)")
res = Parser.run(tokens)
Parser.show(res)