local Entity = require("Engine.Entity")
local ArmorManager = setmetatable({},{__index=Entity})
ArmorManager.__index = ArmorManager


--to help with the draw order 

function ArmorManager:new(em)
    local a = setmetatable(Entity:new(0,0,0,0,"ArmorManager","none",nil),ArmorManager)

    a.em = em 

    a.armors = {}

    return a 
end 


function ArmorManager:add(armor) 
    table.insert(self.armors,armor)
end 

function ArmorManager:update(dt,camera)

    for k,v in ipairs(self.armors) do 
        v:update(dt,camera)
    end 

    for k,v in ipairs(self.armors) do 
        if v.availableArmor <= 0  or v.delete then 
            table.remove(self.armors,k)
        end 
    end 
end 


function ArmorManager:draw() 
    for k,v in ipairs(self.armors) do 
        v:draw()
    end 
end 


return ArmorManager 