
local Enemy = require("Game.Enemy")
local consts= require("consts")
local JumperPlate = setmetatable({},{__index=Enemy})
JumperPlate.__index = JumperPlate

function JumperPlate:new(x,y,em)
    local j = setmetatable(Enemy:new(x,y,48,48,em),JumperPlate)


    j.em = em 
    j.speedX = -200

    j.speedMagnitude = 100 

    j.angle = 0 

    j.hitbox.x = j.x 
    j.hitbox.y = j.y 
    j.hitbox.width = 48 
    j.hitbox.height = 48 

    j.state = "Move-Left"


    j.jumping.speed = 160
    j.jumping.jump_time = 0.6

    j.health = 65
    return j 

end 


function JumperPlate:update(dt,camera) 
    if self.state == "Move-Left" or self.state == "Move-Right" then 
        self.speedX = self:MoveHorizontally(dt,self.speedX)
        self.vel.x = self.speedX 
    end 

    if self:withInPlayerDistance() and not self.state == "Attack" then 

        self.state = "Attack" 


        self.jumping.speed = 200

      

        self.angle = math.atans(consts.player.y-self.y,consts.player.x-self.x)

        self.speedX = math.cos(self.angle)*self.speedMagnitude
    end 

    if self.state == "Attack" then 
        
        self.vel.x = self.speedX 

        if self.is_grounded then 
            self.vel.x = 100
            self.state = "Move-Right"
        end 
    end 
    
    self:jump()

    
    self.hitbox.x = self.x 
    self.hitbox.y = self.y 

    self:collideWithPlayer(consts.player)
    self:onHit(dt,consts.player.equipment,camera)   
end 


function JumperPlate:draw( )
    love.graphics.setColor(0,1,0,1)

    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1,1)
end 


return JumperPlate  