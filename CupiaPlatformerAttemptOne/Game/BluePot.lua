local Enemy = require("Game.Enemy")
local consts = require("consts")
local BluePot = setmetatable({},Enemy)
BluePot.__index = BluePot


function BluePot:new(x,y,em)
    local b = setmetatable(Enemy:new(x,y,24,24,"BluePot",em),BluePot)

    b.state = "Move-Left"
   
    b.reach.x = 350 
    b.reach.y = 350 
    b.speedX = -50
    b.attackSquare = {
        x = b.x,
        y = b.y,
        width = 250,
        height = 250,
        id = "attackSquare"
    }

    b.state_times.attack = 1
    b.state_counters.attack = 0


    b.angle = 0 
    b.speed = 300
    b.cos = 0 
    b.sin = 0
    b.hitbox.x = b.x 
    b.hitbox.y = b.y 
    b.hitbox.width = b.width  +30
    b.hitbox.height = b.height + 30
    b.img = consts.AssetManager:getImage("BluePot","Enemies/BluePot.png")
    b.animator:add(b.img,3,16,16,"Move-Right",10,5)
    b.animator:add(b.img,2,16,16,"Move-Left",10,5)
    b.animator:add(b.img,1,16,16,"Attack-Left",10,5)
    b.animator:add(b.img,0,16,16,"Attack-Right",10,5)
    b.animator:setName("Move-Right")
    b.img_dst_rect.x = b.x 
    b.img_dst_rect.y = b.y

    b.health = 25
    return b
end 


function BluePot:update(dt,camera)
   
    self.speedX = self:MoveHorizontally(dt,self.speedX) 
    if self.state == "Move-Left" or self.state == "Move-Right" then 
     
      
        if consts.player:overLap(self.attackSquare) and self:withInPlayerDistance() then 
         
            self.angle = math.atan2(consts.player.y-self.y,consts.player.x-self.x)
            self.cos = math.cos(self.angle)
            self.sin = math.sin(self.angle)
            self.vel.x = 0
            self.vel.y = 0

            if self.cos > 0 then 
                self.state = "Attack-Right"
            elseif self.cos < 0 then 

                self.state = "Attack-Left"
            end 
            
        end 

        
        self.vel.x = self.speedX 
    end 

    if self.state == "Attack-Left" or self.state == "Attack-Right" and self:withInPlayerDistance() then 

  
        self.vel.x = self.cos*self.speed
        self.vel.y = self.sin*self.speed
    
        
       
        self.state_counters.attack = self.state_counters.attack + dt
        if self.state_counters.attack >= self.state_times.attack then 
            self:setMovingState()
            self.state_counters.attack = 0
        end 
    end     


    self.animator:setName(self.state)
    

    self:collideWithPlayer(consts.player)
    self:onHit(dt,consts.player.equipment,camera)
   

    self.attackSquare.x = self.x+(self.width/2) - (self.attackSquare.width/2)
    self.attackSquare.y = self.y+(self.height/2) - (self.attackSquare.height/2)
    self.hitbox.x = self.x 
    self.hitbox.y = self.y 
    self.img_dst_rect.x = self.x - 3
    self.img_dst_rect.y = self.y - 6
    self.animator:update(dt)

end


function BluePot:draw(camera) 


    
    
    self.hurt:apply()
   
    self.animator:draw(self.img,self.img_dst_rect.x,self.img_dst_rect.y,2,2)

    self.hurt:unapply()
    
end 

return BluePot 