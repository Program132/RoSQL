local Token = require("TokenClass")

Lexer = {}

function Lexer.ParseCode(code)
    local allTokens = {}
    local currentToken = Token:new()

    for i = 1, #code do
        local char = code:sub(i, i)
        if char == "(" or char == ")" or char == ',' then
            currentToken, allTokens = OverToken(currentToken, allTokens)
            currentToken:updateType("OPERATOR")
            currentToken:appendContent(char)
            currentToken, allTokens = OverToken(currentToken, allTokens)
        elseif char == '0' or char == '1' or char == "2" or char == "3" or char == "4" or char == "5" or char == "6" or char == "7" or char == "8" or char == "9" then
            if currentToken.type == "DOUBLE" then
                currentToken:appendContent(char)
            else
                currentToken:updateType("INT")
                currentToken:appendContent(char)
            end
        elseif char == '.' and currentToken.type == "INT" then
            currentToken:updateType("DOUBLE")
            currentToken:appendContent(char)
        elseif char == '"' or char == "'" then
            if currentToken.type == "WHITESPACE" then
                currentToken:updateType("POSSIBLE_STRING")
            elseif currentToken.type == "POSSIBLE_STRING" then
                currentToken:updateType("STRING")
                currentToken, allTokens = OverToken(currentToken, allTokens)
            end
        elseif char == ' ' then
            if currentToken.type ~= "POSSIBLE_STRING" then
                currentToken, allTokens = OverToken(currentToken, allTokens)
            end
        else
            if currentToken.type == "WHITESPACE" or currentToken.type == "INT" or currentToken.type == "DOUBLE" then
                currentToken, allTokens = OverToken(currentToken, allTokens)    
                currentToken:updateType("IDENTIFIANT")
            end
            currentToken:appendContent(char)
        end
    end
    
    currentToken, allTokens = OverToken(currentToken, allTokens)

    for i = 1, #allTokens do
        token = allTokens[i]
        if token.type == "IDENTIFIANT" and (token.content == "true" or token.content == "false") then
            token:updateType("BOOL")
        end
    end
    
    return allTokens
end

function OverToken(currentToken, listTokens)
    if currentToken.type ~= "WHITESPACE" then
        table.insert(listTokens, currentToken)
    end
    return Token:new(), listTokens
end

function Lexer.show(listTokens)
    for i, token in pairs(listTokens) do
        print("i: "..i..", "..token.content)
    end
end

return Lexer