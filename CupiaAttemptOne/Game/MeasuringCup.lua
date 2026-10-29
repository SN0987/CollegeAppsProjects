local Enemy = require("Game.Enemy")
local MeasuringCup = setmetatable({},{__index=Enemy})
local consts = require("consts")
MeasuringCup.__index = MeasuringCup

function MeasuringCup:new(x,y,em) 


    local e = setmetatable(Enemy:new(x,y,32,32,em),MeasuringCup)

    e.em = em 

    e.speedX = -50
    
    e.reach.x = 75 
    e.reach.y = 75
    e.hitbox.x = x 
    e.hitbox.y = y 
    e.hitbox.width = 32
    e.hitbox.height = 32  

    e.attacked = false 

    e.health = 50

    e.img = consts.AssetManager:getImage("MeasuringCup","Enemies/measuring_cup.png")
    e.animator:add(e.img,1,16,16,"Normal-Right",8,4)
    e.animator:add(e.img,0,16,16,"Normal-Left",8,4)
    e.animator:add(e.img,3,16,16,"Shocked-Left",8,4)
    e.animator:add(e.img,2,16,16,"Shocked-Right",8,4)

    e.animator:setName("Normal-Left")
    return e 
end 


function MeasuringCup:update(dt,camera) 


    self.speedX = self:MoveHorizontally(dt,self.speedX)
    self.vel.x = self.speedX 


    self.animator:update(dt)
    if self:withInPlayerDistance() then 

        if not self.attacked then 
            consts.player.jumping.speed = consts.player.jumping.speed * 0.5
            consts.player.accel.x = consts.player.accel.x*0.5 
            consts.player.maxSpeed = consts.player.maxSpeed * 0.5
            self.attacked = true 
        end 

        consts.player.hurt.isHurt = true


        if self.vel.x < 0 then 
            self.animator:setName("Shocked-Left")
        end 

        if self.vel.x > 0 then 
            self.animator:setName("Shocked-Right")
        end 
     
    else

        if self.vel.x < 0 then 
            self.animator:setName("Normal-Left")
        end 

        if self.vel.x > 0 then 
            self.animator:setName("Normal-Right")
        end 
        if self.attacked then 

            consts.player:resetSpeed()
          
            self.attacked = false 
        end 
        
    end 

    if self.delete or self.health <= 0 then 
        consts.player:resetSpeed()
          
    end 


    self.hitbox.x = self.x 
    self.hitbox.y = self.y 
  
    self:collideWithPlayer(consts.player)
    self:onHit(dt,consts.player.equipment,camera)    

end 


function MeasuringCup:draw( )
    local scaleX = self.width/16
    local scaleY = self.height/16

    self.hurt:apply()
    self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
    self.hurt:unapply()
end 

return MeasuringCup 