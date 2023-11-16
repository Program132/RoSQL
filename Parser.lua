local Lexer = require("Lexer")
local Token = require("TokenClass")

Parser = {}

function Parser.run(listTokens)
    if listTokens[1].content == "CREATE" and listTokens[2].content == "TABLE" then
        create_table_instruction(listTokens)
    elseif listTokens[1].content == "INSERT" and listTokens[2].content == "INTO" then
        insert_into_instruction(listTokens)
    else
        return "This instruction does not exist!"
    end
end

function create_table_instruction(listTokens) -- CREATE TABLE <name> (<value> <domain of the value>, ...)
    if #listTokens < 5:
        return "Missing arguments ! Minimum of the instruction is: 'CREATE TABLE <name of your table> ()'"
    end
    
    if listTokens[3].type != "IDENTIFIANT" then
        return "Write like a classic text for the name of your table !"
    end
    
    local tableName = listTokens[3]
    
    if listTokens[4].type != "OPERATOR" or listTokens[4] != "(" then
        return "Open '()' to give your possible values with "
    end
        
    return "Success"
end

function insert_into_instruction(listTokens)
        

    return "Success"
end

return Parser 