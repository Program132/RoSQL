# RoSQL

SQL Like Language for the Roblox Plugin **RoDatabase**.

# Documentation

## Types of values

- Integer : **INT**
- Double or Float : **NUMBER**
- String : **TEXT**
- Boolean or bool : **BOOL**

## Create a table

Format to follow : **CREATE TABLE <name of your table> ( <name of value> <domain of the value> )**
    
Examples :
- *CREATE TABLE void_in_this_table ()*
- *CREATE TABLE users_info (name TEXT, numberPunishments INT)*
- *CREATE TABLE users_info_v2 (name TEXT, numberPunishments INT, isBanned BOOL, reason_ban_if_do TEXT)*
- *CREATE TABLE my_land (name_of_the_city TEXT, population INT, size INT)*

Example with code :
```
local Lexer = require("Lexer")
local Parser = require("Parser")

local tokens = Lexer.ParseCode("CREATE TABLE MyT (mon_nom TEXT, my_name INT)")
local res = Parser.run(tokens)
Parser.show(res)
```

```
name: MyT
values:
    my_name:
        name: my_name
        domain: INT
    mon_nom:
        name: mon_nom
        domain: TEXT
```

## Insert default values for someone or everyone

Format to follow if you want to insert a default value for everyone : **INSERT INTO <name of the table> VALUES (*, <value> <domain>, ...)**
In this format, ** \* ** tells the program that it will be for everyone

Format to follow if you want to insert a default value for a player : **INSERT INTO <name of the table> VALUES (<id of the roblox user>, <value> <domain>, ...)**
In this format, ** \id of the roblox user ** will give the default value(s) to this player.

Examples :
- *INSERT INTO info_users VALUES (1, "Hello it's my description", 16)*
-> ID, description TEXT, age INT
- *INSERT INTO info_confidential VALUES (1, true, 10)*
-> ID, is13yearsold BOOL, numberOfFriends INT

Example with code :
```
local Lexer = require("Lexer")
local Parser = require("Parser")

local tokens = Lexer.ParseCode("CREATE TABLE MyT (mon_nom TEXT,)")
local res = Parser.run(tokens)
tokens = Lexer.ParseCode("INSERT INTO MyT VALUES (1, 'cc', false, 100.0)")
res = Parser.run(tokens)
Parser.show(res)
```
```
target: 1
table_target: MyT
values:
    1: cc
    2: false
    3: 100.0
```

# Links

[Plugin](https://create.roblox.com/marketplace/asset/15364884409/RoDatabase%3Fkeyword=&pageNumber=&pagePosition=)
[DevForum Post](https://devforum.roblox.com/t/rodatabase-plugin-for-datastores/2702468/2)