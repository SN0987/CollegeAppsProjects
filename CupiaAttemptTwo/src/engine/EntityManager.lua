local GameMath = require "engine.GameMath"
local EntityManager =  {}
EntityManager.__index = EntityManager
local globals = require("globals")

--all entities should use a spritebatch 
function EntityManager:new(spritesheet) 
    local em = setmetatable({}, EntityManager) 

    
    em.spritebatch = love.graphics.newSpriteBatch(spritesheet, globals.WORLD_WIDTH/globals.TILE_SIZE) 
    

    em.entities = { }
    em.player = nil 
    
    return em 
end 



function EntityManager:removeByPos(x,y) 
    
    for k,v in ipairs(self.entities) do 
        if v.x == x and v.y == y then 
            if v.batchId ~= nil then 
                self.spritebatch:set(v.batchId,0, 0, 0, 0,0)
            end 
            table.remove(self.entities,k) 
        end 
    end 

end 


function EntityManager:add(e) 


    e.spritebatch = self.spritebatch
    e.em = self
    if e.id ~= "player" then
        

        local tag = 0
        for k,v in ipairs(self.entities) do 

            if v.id == e.id then 
                tag = tag + 1 
            end 
        end

        e.id = e.id .. tag 
        table.insert(self.entities, e) 
    else 
        self.player = e
    end 

    
end         


--returns a table 

function EntityManager:getEntity(id) 


    local entitylist = {}
    for k,v  in ipairs(self.entities) do 
        local spos, epos = string.find(v.id, id, 1, true) 


        if spos then 
            table.insert(entitylist,v) 
        end
        
    end 

    return entitylist 

end 

function EntityManager:getPlayer() 
    return self.player
end



function EntityManager:handleCollision(e) 
    
end 

function EntityManager:update(dt) 
    local player = self:getPlayer()

    if player ~= nil then

        
        player:update(dt) 

    end
    for i = 1, #self.entities do 
        
        local v = self.entities[i] 



        if player ~= nil then 

         
            if GameMath.withInDiagonalDistance(player,v, globals.WIDTH + 150) and v.id ~= "player" then 
                v:updateCollisionAxis()        
                --[[for j = 1, #self.entities-1 do 
                    local e = self.entities[j+1]
                    v:findCollision(e)
                end 
                v:moveX(dt) 
                v:collisionX() 

                v:moveY(dt)
                v:collisionY() ]] 

                v:update(dt) 
          
            end 
        end 
        
     
     
    end 






    



end 

function EntityManager:draw()   
    

        
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.spritebatch,0,0)
    love.graphics.setColor(1,1,1,1)


    

    
    for k,v in ipairs(self.entities) do 
       
        v:draw() 
     
    end 


    if self.player ~= nil then 
        self.player:draw()
    end 
end 



return EntityManager  