Types = {
    WHITESPACE = "WHITESPACE",
    IDENTIFIANT = "IDENTIFIANT",
    INT = "INT",
    DOUBLE = "DOUBLE",
    POSSIBLE_STRING = "POSSIBLE_STRING",
    STRING = "STRING",
    BOOL = "BOOL",
    OPERATOR = "OPERATOR"
}

Token = {}

function Token.new()
   local t = {}
   t.content = ""
   t.type = Types.WHITESPACE
   setmetatable(t, {__index = Token})
   return t
end

function Token.debug(self)
    return "\nTOKEN: "..self.content.."\n"..Types[self.type].."\n"
end

function Token.updateContent(self, newContent)
    self.content = newContent
end

function Token.appendContent(self, x)
    self.content = self.content..x
end

function Token.updateType(self, newType)
    if Types[newType] ~= nil then
        self.type = newType
    end
end

return Token