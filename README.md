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