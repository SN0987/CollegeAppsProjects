
local Enemy = require("Game.Enemy")
local Boss = setmetatable({},{__index=Enemy})
local consts = require("consts")
Boss.__index = Boss 


function Boss:new(x,y,width,height,name,em) 

    local b = setmetatable(Enemy:new(x,y,width,height,name,em),Boss)

    b.reach = {
        x = 750, 
        y=750 
    }

    b.originalPos = {
        x = x, 
        y=y
    }
    
    b.shakeTable = {
        counter = 0,
        shake = false
    }

    b.boss = true 

    b.state_times.cooldown = 3 
    b.state_counters.cooldown = 0
    b.cooldown = false 
    b.respawn = false 

    return b 

end 

function Boss:updateBoss(dt,camera)

    
    if self.health > 0 then 
        consts.player.bossClear = true 
    end 
    
    if self.is_grounded  then 
        if self.shakeTable.shake == false then 
            self.shakeTable.shake = true 
            self.respawn = false 
        end 
    end 

    if self.shakeTable.shake and self:withInPlayerDistance() then 
        if self.shakeTable.counter ~= 1 then 
            camera:shake(0.3)
            self.shakeTable.counter = 1
            self.shakeTable.shake = false
        end 
    end 

    if self.y >= consts.HEIGHT then 
        self.x = self.originalPos.x 
        self.y = self.originalPos.y 
        self.respawn = true 
    end

 
    if self.originalPos.x - self.x >= self.reach.x or self.originalPos.x - self.x <= -self.reach.x then 
        self.x = self.originalPos.x 
        self.y = self.originalPos.y 
    end 


    if self.cooldown then 
        self.state_counters.cooldown = self.state_counters.cooldown + dt 

        if self.state_counters.cooldown >= self.state_times.cooldown then 
            self.cooldown = false 
            self.state_counters.cooldown = 0
        end 
    end 
end 


function Boss:update(dt,camera)

end 


function Boss:draw() 

end 


return Boss 