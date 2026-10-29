local copy = {}



--come back to understand this 
function copy.deep(orig, copies)
    copies = copies or {}
    
    if type(orig) ~= "table" then
        return orig
    elseif copies[orig] then
        return copies[orig] -- prevent infinite loops
    end

    local c = {}
    copies[orig] = c
    for k, v in pairs(orig) do
        c[copy.deep(k, copies)] = copy.deep(v, copies)
    end
    return setmetatable(c, getmetatable(orig))
end

return copy

