local GameMath = require "engine.GameMath" 
local Entity = {} 
Entity.__index = Entity  
 
 
--use id or serial to access entities  
function Entity:new(x,y,width,height,id)  
    local e = setmetatable({}, Entity) 
    e.x = x  
    e.y = y  
    e.width = width  
    e.height = height  
 
    e.id = id 
 
 
    e.vel = { 
        x = 0, 
        y = 0 
 
    } 
    e.col_status = "none" 
    e.defaultVel = { 
 
        x = 0, 
        y = 0 
 
    } 
 
    e.accel = { 
 
        x = 0, 
        y = 0 
    } 
 
 
    e.maxSpeed = { 
        x = 500, 
        y = 500 
    } 
 
 
    e.enabledJumping = false  
 
    e.jumpTable = { 
        bool = false,  
        time = 0.25, 
        speed = 300, 
        timer = 0, 
        gravity = 250,  
        isGrounded = false,  
    } 
    e.tracker = "nothing" 
 
 
    e.em = nil 
 
    --intialized through the entity manager
    e.spritebatch = nil  
 
    --[[e.collisionAxis = { 
        x = {
            pos = 0,
            width = 0,
        },

        y = {
            pos = 0,
            height = 0,
        }
    } ]]

    --[[e.collisionAxis = {
        y = nil,
        x = nil
    }]] 
    
    e.colCoords = nil 
 
    e.hit = { 
        right = false,  
        left = false,  
        down = false, 
        up = false  
    } 
 
 
    e.colCoords = { 
        x = 0, y = 0, width = 0, height = 0 
    } 
 
    e.isCol = false  
    e.colBool = { 
        x = false, 
        y = false  
    } 
 
 
    --to control collisions with gravity
    e.posTracker = { 
        x = 0,  
        y = 0 
    } 
    return e  
end  
 
 
function Entity:updateCollisionAxis()  
    --[[self.collisionAxis.right = self.x + self.width  
    self.collisionAxis.left = self.x  
    self.collisionAxis.up = self.y   
    self.collisionAxis.down = self.y + self.height   ]]
end 
 
 
function Entity:collisionX()    
     
    if self.colCoords ~= nil and self.isCol then  
        local e = self.colCoords 

        if self.col_status == "dynamic" then  
             
            if e.col_status == "static" then  

                if self.vel.x < 0 then  
                    self.x = e.x + e.width 
                    self.vel.x = 0 
                    self.hit.left = true  
                end  
 
                if self.vel.x > 0 then  
                    self.x = e.x - self.width 
                    self.vel.x = 0  
                    self.hit.right = true  
                end  
            end  
        end  
    end  
end  
 
 
function Entity:collisionY()    
 
    if self.isCol and self.colCoords ~= nil then  
        local e = self.colCoords
 
        if self.col_status == "dynamic" then  

            if e.col_status == "static" then  

                --moving upward
                if self.vel.y < 0 then  
                    self.y = e.y + e.height 
                    self.vel.y = 0 
                    self.jumpTable.bool = false  
                    self.jumpTable.isGrounded = false
                    self.hit.up = true  
 
                --moving downward
                elseif self.vel.y > 0 then  
                    self.y = e.y - self.height 
                    self.vel.y = 0 
                    self.jumpTable.isGrounded = true  
                    self.jumpTable.bool = false
                    self.jumpTable.timer = 0
                    self.hit.down = true  

                end  
            end  
        end  

        
    else 

    
    end  
end  


function Entity:findCollision() 
     
    self.isCol = false  
    
    self.colCoords = nil 
 
    for k,v in ipairs(self.em.entities) do  
        if v.id ~= self.id then      
          
            if GameMath.rectangleCollision(self,v) and self.col_status ~= "none" and v.col_status ~= "none" then  
            
                self.isCol = true  
                
                self.colCoords = v
                break  
 
            end  
     
        end  
    end  
end  
 
 
function Entity:manageJumpTable()  
 
end  
 
 
function Entity:setJumpTable(speed, gravity, time)   
    self.jumpTable.speed = speed  
    self.jumpTable.gravity = gravity  
    self.jumpTable.time = time  
    self.enabledJumping = true 
end  
 
 
 
 
function Entity:setKinematics(vx,vy,defaultX, defaultY, ax,ay,maxX,maxY) 
     
    self.vel.x = vx 
    self.vel.y = vy  
 
    self.defaultVel.x = defaultX  
    self.defaultVel.y = defaultY  
    self.accel.x = ax  
    self.accel.y = ay  
    self.maxSpeed.x = maxX 
    self.maxSpeed.y = maxY  
 
end  
 
 
function Entity:accelerateX(dt, sign)  
 
    if sign > 0 then  
        if self.vel.x < self.maxSpeed.x then  
            self.vel.x = self.vel.x + self.accel.x * dt  
        end  
    elseif sign < 0 then 
        if self.vel.x > -self.maxSpeed.x then  
            self.vel.x = self.vel.x - self.accel.x * dt  
        end  
    end  
     
end  
 
 
function Entity:accelerateY(dt,sign)  
 
    if sign > 0 then  
        if self.vel.y < self.maxSpeed.y then  
            self.vel.y = self.vel.y + self.accel.y * dt  
        end  
    elseif sign < 0 then 
        if self.vel.y > -self.maxSpeed.y then  
            self.vel.y = self.vel.y - self.accel.y * dt  
        end  
    end  
 
end  
 
 
 
 
 
 
 
 
--could also serve as state so if an enemy accelerates it resets at a certain state  
function Entity:resetVelocityX(dt,key,sign) 
 
    if key == "nothing" then  
        self.vel.x = self.defaultVel.x  
    elseif key ~= self.tracker then  
 
        if sign > 0 then  
            self.vel.x = self.defaultVel.x  
             
        else  
            self.vel.x = -self.defaultVel.x 
        end  
     
        self.tracker = key  
    end  
end  
 
 
function Entity:resetVelocityY(dt,key,sign) 
 
    if key == "nothing" then  
        self.vel.y = self.defaultVel.y  
    elseif key ~= self.tracker then  
      
        if sign > 0 then  
            self.vel.y = self.defaultVel.y  
        else  
            self.vel.y = -self.defaultVel.y 
        end  
        self.tracker = key  
    end  
end  
 
 
function Entity:updateGravity()  
 
    --if we are jumping or standing on something,
    --gravity should not overwrite our vertical velocity
    if not self.jumpTable.isGrounded and not self.jumpTable.bool then  
        self.vel.y = self.jumpTable.gravity 
    end  
 
    --if we aren't currently colliding with something,
    --we are no longer grounded


    --[[if self.colCoords ~= nil then 
        --check for x overlap 

     local xOverlap = self.x >= self.colCoords.x + self.colCoords.width and  (self.x+self.width) <= self.colCoords.x 
        if not xOverlap then 
            
            self.jumpTable.isGrounded = false 
        end 
    end ]]
end       
 
 
function Entity:updateJumping(dt)  
    if self.enabledJumping then  
 
        if self.jumpTable.bool then  
 
            self.vel.y = -self.jumpTable.speed 
            self.jumpTable.timer = self.jumpTable.timer + dt 
            
            if self.jumpTable.timer >= self.jumpTable.time then  
                self.jumpTable.bool = false  
            end  
        end  
         
        if self.jumpTable.timer >= self.jumpTable.time then  
            self.jumpTable.timer = 0 
        end  
    end  
end  
 
 
 
 
function Entity:resetTrackerY()  
    self.posTracker.y = 0 
end  
 
 
function Entity:resetTrackerX()  
    self.posTracker.x = 0 
end  
 
 
function Entity:moveX(dt) 
    local oldX = self.x  
 
    self.x = self.x + self.vel.x * dt  
 
    self.posTracker.x = self.posTracker.x + (self.x-oldX)  
end  
 
 
 
function Entity:moveY(dt) 
    local oldY = self.y  
 
    self.x = self.x + 0
    self.y = self.y + self.vel.y * dt 
 
    self.posTracker.y = self.posTracker.y + (self.y-oldY) 
end  
 
 
function Entity:jump()  
    if self.jumpTable.isGrounded and not self.jumpTable.bool then  
        self.jumpTable.bool = true  
        self.jumpTable.isGrounded = false
        self.jumpTable.timer = 0
    end  
end  
 
 
function Entity:update(dt) 
 
end  
 
 
function Entity:draw() 
 
end  
  
return Entity