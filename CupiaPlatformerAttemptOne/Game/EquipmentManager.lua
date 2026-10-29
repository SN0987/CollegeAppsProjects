
local Entity = require("Engine.Entity")

local EquipmentManager = setmetatable({},{__index=Entity})
EquipmentManager.__index = EquipmentManager

function EquipmentManager:new() 
    local em = setmetatable(Entity:new(0,0,0,0,"EquipmentManager","none",nil),EquipmentManager)


    em.things = {}
    em.entityManager = nil
    em.loaded = false 

    return em 
end 


function EquipmentManager:add(e) 
    table.insert(self.things,e)
end 

function EquipmentManager:getThing(id)

    for k,v in ipairs(self.things) do 
        if v.id == id then 
            return v 
        end 
    end 

end 



function EquipmentManager:update(dt,camera)

    local player
    if self.loaded then 
    
       player = self.entityManager:getEntity("Player")
    end 
   

    for k,v in ipairs(self.things) do
        
        v:update(dt,camera,player)

        if self.loaded then 
            v:collideWithPlayer(dt,player,camera)
            v:dropWithPlayer(dt,player,camera)
        end  
    

        
    end 

    for k,v in ipairs(self.things) do 
        if v.delete then 
            player.equipped = false 
            player.equipment = nil 
            table.remove(self.things,k)
        end 
    end 
end 

function EquipmentManager:draw(camera) 
    for k,v in ipairs(self.things) do 
        v:draw(camera)
    end 
end 


return EquipmentManager