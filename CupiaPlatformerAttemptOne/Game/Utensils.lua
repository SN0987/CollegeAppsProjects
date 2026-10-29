local Enemy = require("Game.Enemy")
local consts = require("consts")
local Utensils = setmetatable({},{__index=Enemy})
local Particle = require("Engine.Particle")
Utensils.__index = Utensils 

function Utensils:new(x,y,speed,em)
    local u = setmetatable(Enemy:new(x,y,96,96,em),Utensils)
    u.collider_status = "none"
    u.gravity = 0
    u.accelGravity = 0
    u.speed = speed
    u.img = consts.AssetManager:getImage("Utensils","Enemies/utensils.png")
    u.quad = love.graphics.newQuad(love.math.random(0,2)*16,0,16,16,u.img:getWidth(),u.img:getHeight())

    local states = {"Up","Down"}

    u.state = states[love.math.random(1,#states)]
    
    u.hitbox.width = 32
    u.hitbox.height = 84
    u.hitbox.x = x 
    u.hitbox.y = y 
    u.playerCol = false 
    u.em = em 

    if u.state == "Up" then 
        u.y = consts.HEIGHT+u.height
    elseif u.state == "Down" then 

        u.y = -u.height
    end 

  
    return u

end 

function Utensils:update(dt,camera) 
    
    

    
    
    if consts.player:hitBoxOverlap(self) and not self.playerCol then 
        consts.player:beHurt()
    end 

    self.playerCol = consts.player:hitBoxOverlap(self)

    if self.state == "Up" then 

        self.vel.y = -self.speed 

        
        if self.y < -self.height then 
            self.state = "Down"
        end 
        self.hitbox.y = self.y 
       
    elseif self.state == "Down" then 
        self.vel.y = self.speed
        
        if self.y > consts.HEIGHT + self.height then 
            self.state = "Up"
        end 

        self.hitbox.y = self.y - 84 
        
    end     

    self.y = self.y + self.vel.y * dt

    --(dt,leftDust,rightDust, upDust, downDust,camera) 
    
    
 
    self.hitbox.x = self.x + 32 
end 

function Utensils:draw()
   
    local scaleX = self.width/16
    local scaleY = self.height/16 

    
    if self.state == "Down" then 
        scaleY = -scaleY
    else
        scaleY = scaleY
    end     



    love.graphics.draw(self.img, self.quad, self.x,self.y,0,scaleX,scaleY )
end 






return Utensils 