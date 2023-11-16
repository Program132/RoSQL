local Lexer = require("Lexer")
local Token = require("TokenClass")

Parser = {}

function Parser.run(listTokens)
    if listTokens[1].content == "CREATE" and listTokens[2].content == "TABLE" then
        return create_table_instruction(listTokens)
    elseif listTokens[1].content == "INSERT" and listTokens[2].content == "INTO" then
        return insert_into_instruction(listTokens)
    else
        return "This instruction does not exist!"
    end
end

function create_table_instruction(listTokens) -- CREATE TABLE <name> (<value> <domain of the value>, ...)
    if #listTokens < 5 then
        return "Missing arguments ! Minimum of the instruction is: 'CREATE TABLE <name of your table> ()'"
    end
    
    if listTokens[3].type ~= "IDENTIFIANT" then
        return "Write like a classic text for the name of your table !"
    end
    
    local tableName = listTokens[3]

    if listTokens[4].type ~= "OPERATOR" or listTokens[4].content ~= "(" then
        return "Open '()' to give your possible values with "
    end

    local create_table = {}
    create_table["name"] = tableName.content
    create_table["values"] = {}

    local index = 5
    while listTokens[index].type ~= "OPERATOR" and listTokens[index].content ~= ")" do
        local valueName = listTokens[index].content
        index = index + 1

        local valueDomain = listTokens[index].content
        index = index + 1

        local separator = listTokens[index].content
        if separator ~= "," and #listTokens > index+1 and listTokens[index+1].content ~= ")" then
            return "You have to put ',' after giving the value and his domain"
        end

        create_table["values"][valueName] = {}
        create_table["values"][valueName]["name"] = valueName
        create_table["values"][valueName]["domain"] = valueDomain

        if listTokens[index].content == ")" then
            break
        end

        index = index + 1
    end

    return create_table
end

function insert_into_instruction(listTokens)
    return {}
end

function Parser.show(t, indent)
    indent = indent or 0
    for cle, valeur in pairs(t) do
        if type(valeur) == "table" then
            print(string.rep("  ", indent) .. cle .. ":")
            Parser.show(valeur, indent + 1)
        else
            print(string.rep("  ", indent) .. cle .. ": " .. tostring(valeur))
        end
    end
end

return Parser 