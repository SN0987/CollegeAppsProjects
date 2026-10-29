local Sprite = require("Game.Sprite")
local consts = require("consts")

local Equipment = setmetatable({},{__index=Sprite})
Equipment.__index = Equipment


function Equipment:new(x,y,name)
    local e = setmetatable(Sprite:new(x,y,16,16,name,"none"),Equipment)

    e.pickedUp = false 
    e.center = {
        x = 0,
        y = 0
    }
    e.dropped  = false 
    e.droppedSpeed = 150

    e.angle = nil 
    e.rotationCenter = {
        width = e.width/2,
        height = e.height/2
    }

    e.tweaks = {
        timer = 0,
        time = 0.5,
        speed = -30
    }

    e.offset = {
        x=0,
        y=0
    }
    
    return e 

end 

function Equipment:collideWithPlayer(dt,player,camera)


    if love.keyboard.isDown(consts.keys["Pick-Up"]) then 
        if player.equipped == false and player.equipment == nil then 
            if self:overLap(player) then
                self.pickedUp = true 
                player.equipped = true    
                player.equipment = self 
            end
        end 
    end 


    if player.equipped and self.pickedUp then
        self.center.x = (player.x+(player.width/2)) + self.offset.x 
        self.center.y = (player.y+(player.height/2)) + self.offset.y 
        
    end
end 



function Equipment:dropWithPlayer(dt,player,camera)

    if love.keyboard.isDown(consts.keys["Drop"]) then 
        if player.equipped and player.equipment == self then 
            self.dropped = true 
            self.pickedUp = false 
            player.equipped = false 
            player.equipment = nil 
            self.x = self.x- self.offset.x 
            self.y = self.y
        end 
    end 
  

end 

--parent of other things that need to be equipped
function Equipment:parentUpdate(dt) 
    if self.pickedUp then 
        self.x = self.center.x 
        self.y = self.center.y 
    end     

    if self.pickedUp == false then 
        self.y = self.y + self.tweaks.speed * dt
        self.tweaks.timer = self.tweaks.timer + dt
        if self.tweaks.timer >= self.tweaks.time then 
            self.tweaks.timer = 0
            self.tweaks.speed = self.tweaks.speed * -1 
        end
    end 


end 


function Equipment:update(dt,player) 
   


end 

function Equipment:followMouse()
    local mx = love.mouse.getX()
    local my = love.mouse.getY() 
    self.angle = math.atan2(my-self.y,mx-self.x)
    

end 

function Equipment:draw()

end 

return Equipment 