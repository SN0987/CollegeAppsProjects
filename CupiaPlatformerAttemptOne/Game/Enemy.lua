local Sprite = require("Game.Sprite")
local consts = require("consts")
local Particle = require("Engine.Particle")
local Enemy = setmetatable({},{__index=Sprite})
local Hurt = require("Engine.Hurt")
Enemy.__index = Enemy 


function Enemy:new(x,y,width,height,id,em)
    local e = setmetatable(Sprite:new(x,y,width,height,id,"dynamic"),Enemy)
    

    e.reach = {
        x = 100, 
        y=100
    }
    
    e.state_counters = {
        move = 0,
    }

    e.state_times = {
        move = 2
    }
    e.em = em 
    e.level = nil 

    e.state = "Move-Left"
    e.speedX = -350
    

    e.hit = {
        bool = false,
        counter = 0,
        time = 0.05,
        collided = 0,


    }
    e.hurt = Hurt:new(e.hit.time,"assets/shaders/hurt.glsl")
    e.boss = false 
    e.playerCol = false 
    return e 
end 

function Enemy:withInPlayerDistance() 
    --local player = self.em:getEntity("Player")
    local distanceX = consts.player.x-self.x 


    if distanceX <= self.reach.x and distanceX >= 0 or distanceX >= -self.reach.x and distanceX <= 0 then 
        return true 
    end 

end 



function Enemy:onHit(dt,equipment,camera) 
    if self.hit.bool then 
        self.hit.counter = self.hit.counter + dt 
        self.hurt.isHurt = true 
        if self.level ~= nil then 
            self.level:pause(self.hit.time)
        end 
        
        if self.hit.counter >= self.hit.time then
            self.hit.counter = 0 
            self.hit.bool = false  
            self.hit.collided = 0

            
       

           
            if equipment ~= nil then 
                if equipment.id == "Sword" then 
                self.health = self.health - 800 * dt
                elseif equipment.id == "Gun" then 
                    self.health = self.health - 600 * dt 
                elseif equipment.id == "Bow" then 
                    self.health = self.health - 1200 * dt
                end 
            

                if equipment.id == "Sword" then 
                    equipment.health = equipment.health - 600 * dt 
                end 
               
            end 
           
        end
    end 

    self.hurt:update(dt)
end 

function Enemy:checkCol(player,col) 
    if col and self.hit.collided <= 0 then 
        self.hit.bool = true 
        self.hit.collided = 1
    end 
end 

function Enemy:collideWithPlayer(player) 
  

    if player.equipment ~= nil then 

        if player.equipment.id == "Sword" then 
            local col = player.equipment:hitBoxOverlap(self) 
            if player.equipment.attackBool then 
                self:checkCol(player,col)
            end 
        end  
       

        if player.equipment.id == "Gun" then 

            --refering to left, right , up, down projectiles
            for k,v in pairs(player.equipment.projectiles) do 
                local col = v:detectCollisionWithRect(self.hitbox)
                self:checkCol(player,col)
            end 
        end 

        if player.equipment.id == "Bow" then 
            --print("fnfgn")
            local col = player.equipment.projectiles:detectCollisionWithRect(self.hitbox)
            self:checkCol(player,col)
            
        end 
    end 

    if self:hitBoxOverlap(player) and not self.playerCol then 
      
        if not self.boss then 
            if not self.hurt.isHurt then 
                player:beHurt()
            end 
        end 

        if self.boss then 
            if self.state == "Attack" and self.hurt.isHurt then 
                player:beHurt()
            elseif self.state ~= "Attack" and not self.hurt.isHurt then 
                player:beHurt()
            end 
        end 
    end 

    self.playerCol = self:hitBoxOverlap(player)

    
end 


function Enemy:setMovingState() 

    if self.vel.x < 0 then 
        self.state = "Move-Right"
    elseif self.vel.x > 0 then 
        self.state = "Move-Left"
    else
        self.state = "Move-Right"
    end 
end 


function Enemy:MoveHorizontally(dt,speedX) 

    if self.state == "Move-Left" or self.state == "Move-Right" then
        self.state_counters.move = self.state_counters.move+dt 

        if self.state_counters.move >= self.state_times.move then 
            
            self.state_counters.move = 0

            if self.state == "Move-Left" then
                
                self.state = "Move-Right"
                speedX = speedX*-1
            elseif self.state == "Move-Right" then 
                self.state = "Move-Left"
                speedX = speedX*-1
            end
        end 

    end

    if self.y >= consts.HEIGHT  then 

        if not self.boss then 
            self.delete = true 
        end 
       
    end 

    return speedX 

end 

function Enemy:update(dt,camera)

end 


function Enemy:draw(camera)

end 

return Enemy 
