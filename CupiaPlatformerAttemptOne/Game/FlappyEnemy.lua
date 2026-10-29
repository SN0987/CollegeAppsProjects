local Enemy = require("Game.Enemy")
local FlappyEnemy = setmetatable({},{__index=Enemy})
local consts = require("consts")
FlappyEnemy.__index = FlappyEnemy



function FlappyEnemy:new(x,y,em)
    local f = setmetatable(Enemy:new(x,y,64,64,"FlappingEnemy",em),FlappyEnemy)

    f.gravity = 0
    f.accelGravity = 0

    f.times = {
        gravityTime = 0.5,
        jumpTime = 0.5,
    }

    f.counters = {
        gravityTime = 0 ,
        jumpTime = 0
    }

    f.flap = false 

    f.flapSpeed = -150
    f.gravitySpeed = 150
    f.speedX = -150 
    f.health = 40 

    f.hitbox.width = 54 + 20
    f.hitbox.height = 26 + 20
    f.img = consts.AssetManager:getImage("Flying-Sauce-Pan","Enemies/sauce_pan.png")

    f.animator:add(f.img,0,16,16,"Moving-Left",8,4)
    f.animator:add(f.img,1,16,16,"Moving-Right",8,4)
    f.animator:setName("Moving-Left")
    return f 

end 


function FlappyEnemy:update(dt,camera)

    self.speedX = self:MoveHorizontally(dt,self.speedX)
    

    
    self.vel.x = self.speedX 
    if self.vel.x < 0 then 

        self.animator:setName("Moving-Left")
    else 
        self.animator:setName("Moving-Right")
    end 

    if self.flap then 
        self.counters.jumpTime = self.counters.jumpTime + dt 

        self.vel.y =  self.flapSpeed 
        if self.counters.jumpTime >= self.times.jumpTime then 
            self.flap = false 
            self.counters.jumpTime = 0 
        end 
    end 

    if not self.flap then 
        self.gravity = self.gravitySpeed 
       -- self.accelGravity = 60
        --self.gravity = self.gravity + self.accelGravity
        self.vel.y = self.gravity
        self.counters.gravityTime = self.counters.gravityTime + dt 
        if self.counters.gravityTime >= self.times.gravityTime then 
            self.counters.gravityTime = 0
            self.flap = true 
            self.gravity = self.gravitySpeed
        end 
    end 


    self:collideWithPlayer(consts.player)
    self:onHit(dt,consts.player.equipment,camera)
    self.hitbox.x = self.x  + 5
    self.hitbox.y = self.y + 15

    self.animator:update(dt)
end 

function FlappyEnemy:draw() 
    local scaleX = self.width/16
    local scaleY = self.height/16 
    self.hurt:apply()
    self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
    self.hurt:unapply()

    --love.graphics.setColor(1.0,1.0,1.0,1.0)

    --love.graphics.rectangle("fill",self.hitbox.x,self.hitbox.y,self.hitbox.width,self.hitbox.height)
end 




return FlappyEnemy 