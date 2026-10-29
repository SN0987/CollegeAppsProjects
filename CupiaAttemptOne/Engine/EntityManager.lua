local consts = require "consts"
local EntityManager = {}
EntityManager.__index = EntityManager

function EntityManager:new() 
    local em = setmetatable({},EntityManager)
    em.entities = {}
    return em 
end 

function EntityManager:add(entity) 
    table.insert(self.entities,entity)
end 


--control how many times this function is called 
function EntityManager:getEntity(id) 
    for k,v in ipairs(self.entities) do 
        if v.id == id then 
            return v

        end 
    end 
end 

function EntityManager:getAllEntities() 
    for k,v in ipairs(self.entities) do 
        return v 
    end 
end 




function EntityManager:getEntityList(id) 
    local entities = {}
    for k,v in ipairs(self.entities) do 
        if v.id == id then 
            table.insert(entities,v)
        else 
            print("Entity Name: " .. id .. "Not Found")
        end 
    end 
    return entities
end 


function EntityManager:handleCollision(camera) 
-- Reset grounded state
    for _, v in ipairs(self.entities) do 
        if v.collider_status == "dynamic" then
            v.is_grounded = false
        end
    end 

    for i = 1, #self.entities do 
        for j = i + 1, #self.entities do 
            local a = self.entities[i]
            local b = self.entities[j]

            local col = a:overLap(b)
            if col then 

              
                -- Ensure a is static and b is dynamic
                if a.collider_status == "static" and b.collider_status == "dynamic" then

                   
                    local ax2, ay2 = a.x + a.width, a.y + a.height
                    local bx2, by2 = b.x + b.width, b.y + b.height

                    local x_overlap = math.min(ax2, bx2) - math.max(a.x, b.x)
                    local y_overlap = math.min(ay2, by2) - math.max(a.y, b.y)

                    if x_overlap < y_overlap then
                        -- Horizontal resolution
                        if b.x < a.x then
                            b.x = a.x - b.width
                        else
                            b.x = a.x + a.width
                        end
                        b.vel.x = 0
                    else
                        -- Vertical resolution
                        if b.y < a.y then
                            b.y = a.y - b.height
                            b.is_grounded = true
                            if a.id == "Trampoline" and b.id == "Player" then 
                                b.is_grounded = true 
                                b.jumping.speed = b.jumping.speed * 2.5
                                b:jump()
                            end 
                        else
                            b.y = a.y + a.height
                        end
                        b.vel.y = 0
                    end
                end

            
              
                if a.collider_status == "dynamic" and b.collider_status == "dynamic" then

                
                    local ax2, ay2 = a.x + a.width, a.y + a.height
                    local bx2, by2 = b.x + b.width, b.y + b.height

                    local x_overlap = math.min(ax2, bx2) - math.max(a.x, b.x)
                    local y_overlap = math.min(ay2, by2) - math.max(a.y, b.y)

                    if x_overlap > 0 and y_overlap > 0 then -- make sure they're actually overlapping
                        if x_overlap < y_overlap then
                            -- Horizontal resolution: push both apart equally
                            local separation = x_overlap / 2
                            if a.x < b.x then
                                a.x = a.x - separation
                                b.x = b.x + separation
                            else
                                a.x = a.x + separation
                                b.x = b.x - separation
                            end
                            a.vel.x = 0
                            b.vel.x = 0
                        else
                            -- Vertical resolution
                            local separation = y_overlap / 2
                            if a.y < b.y then
                                a.y = a.y - separation
                                b.y = b.y + separation
                                a.is_grounded = true
                            else
                                a.y = a.y + separation
                                b.y = b.y - separation
                                b.is_grounded = true
                            end
                            a.vel.y = 0
                            b.vel.y = 0
                        end
                    end
                end

                if a.collider_status == "dynamic" and b.collider_status == "static" then
                    
                    local ax2
                    local ax2, ay2 = a.x + a.width, a.y + a.height
                    local bx2, by2 = b.x + b.width, b.y + b.height

                    local x_overlap = math.min(ax2, bx2) - math.max(a.x, b.x)
                    local y_overlap = math.min(ay2, by2) - math.max(a.y, b.y)

                    if x_overlap < y_overlap then
                        -- Horizontal resolution
                        if a.x < b.x then
                            a.x = b.x - a.width
                        else
                            a.x = b.x + b.width
                        end
                        a.vel.x = 0
                    else
                        -- Vertical resolution
                        if a.y < b.y then
                            a.y = b.y - a.height
                            a.is_grounded = true
                            if a.id == "Player" and b.id == "Trampoline" then
                                a.is_grounded = true 
                                a.jumping.speed = a.jumping.speed * 2.5
                                a:jump()
                            end 
                        else
                            a.y = b.y + b.height
                        end
                        a.vel.y = 0
                    end
                end
            end
        end
    end
end

function EntityManager:enableJumping(dt,entity) 
    if entity.jumping.bool then 

     
        entity.vel.y = -entity.jumping.speed 

        entity.jumping.timer = entity.jumping.timer + dt 
        if entity.jumping.timer >= entity.jumping.jump_time then 
            entity.jumping.bool = false 
            entity.gravity = entity.resetGravity
        end 
    end 

    if entity.jumping.bool == false then 
        entity.jumping.timer = 0
    end 
end 



function EntityManager:enableGravity(dt,v) 
  
    if v.collider_status == "dynamic" then 

     
        if v.is_grounded == false and v.jumping.bool == false  then 
            v.gravity = v.gravity + v.accelGravity
          
            v.vel.y = v.vel.y + v.gravity * dt
        end
    end
       
end 

function EntityManager:swapManagersWithPlayer() 
    local posOne 
    local posTwo 
    local posThree 
    local player,armorM, equipmentM 
    for k,v in ipairs(self.entities) do 
        if v.id == "Player" then 
            posOne = k 
            player = v 
        end 

        if v.id == "ArmorManager" then 
            posTwo = k
            armorM = v 

        end 

        if v.id == "EquipmentManager" then 
            posThree = k
            equipmentM = v 
        end 
    end     

    self.entities[posOne] = equipmentM 
    self.entities[posTwo] = player
    self.entities[posThree] = armorM

    

end

function EntityManager:update(dt,camera,ui_manager) 

    for k,v in ipairs(self.entities) do 
        self:enableJumping(dt,v)
        self:enableGravity(dt,v)
    end 
 
    for k,v in ipairs(self.entities) do 
        if v.collider_status == "dynamic" then 
            v.x = v.x + v.vel.x * dt 
            v.y = v.y + v.vel.y * dt

        end 

        if v.health ~= nil then 
            if v.health <= 0 then 
                table.remove(self.entities,k)
                camera:shake(0.5)

                if v.boss then 
                    consts.player.bossClear = false 
                end 

                if v.id == "BloodCake" then
                    
    
                    ui_manager:removeAllElementsByName(v.label.name)
                end

                if v.id == "MeasuringCup" then 
                    consts.player:resetSpeed()
                end 
            end 
        end 

        if v.delete then 

            if v.id ~= "Player" then 
                table.remove(self.entities,k)
            end
       
        end 
        
       
    end 

    self:handleCollision(camera)
    for k,v in ipairs(self.entities) do 

        if v.id ~= "Flag" then 
            v:update(dt,camera)
        end 
        
    end 
 

    
    
    


  
end 


function EntityManager:draw(camera) 
    for k,v in ipairs(self.entities) do
        
        v:draw(camera)
    end
end 
return EntityManager 