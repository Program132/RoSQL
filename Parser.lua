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
    local create_table = {}

    if #listTokens < 5 then
        return "Missing arguments ! Minimum of the instruction is: 'CREATE TABLE <name of your table> ()'"
    end
    
    if listTokens[3].type ~= "IDENTIFIANT" then
        return "Write like a classic text for the name of your table !"
    end
    
    local tableName = listTokens[3]

    if listTokens[4].type ~= "OPERATOR" and listTokens[4].content ~= "(" then
        return "Open '()' to give your possible values"
    end

    create_table["name"] = tableName.content
    create_table["values"] = {}

    local index = 5
    while listTokens[index].type ~= "OPERATOR" and listTokens[index].content ~= ")" do
        if not listTokens[index] then
            return "Give a name to your value"
        end
        local valueName = listTokens[index].content
        index = index + 1

        if not listTokens[index] then
            return "Give a domain to "..valueName
        end
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

function insert_into_instruction(listTokens) -- INSERT INTO <name of the table> VALUES (*/<id>, <value> <domain>, ...)
    local insert_table = {}

    if listTokens[3].type ~= "IDENTIFIANT" then
        return "Write the valid table name !"
    end

    local tableName = listTokens[3]

    insert_table["table_target"] = tableName.content

    if listTokens[4].content ~= "VALUES" then
        return "You have to specify 'VALUES' after giving the table"
    end

    if listTokens[5].type ~= "OPERATOR" and listTokens[4].content ~= "(" then
        return "Open '()' to give your default values"
    end


    if listTokens[6].type ~= "INT" and listTokens[6].content ~= "*" then
        return "Give the target -> '*' for every players or give the ID of the Player"
    end

    if listTokens[7].content ~= "," then
        return "You have to put ',' after giving the ID or '*'"
    end

    insert_table["target"] = listTokens[6].content
    insert_table["values"] = {}

    local index = 8
    while listTokens[index].type ~= "OPERATOR" and listTokens[index].content ~= ")" do
        if not listTokens[index] then
            return "Give the value"
        end
        local currentValue = listTokens[index].content
        table.insert(insert_table["values"], currentValue)
        index = index + 1

        local separator = listTokens[index].content
        if separator ~= "," and #listTokens > index+1 and listTokens[index+1].content ~= ")" then
            return "You have to put ',' after giving the value"
        end

        if listTokens[index].content == ")" then
            break
        end

        index = index + 1
    end

    return insert_table
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