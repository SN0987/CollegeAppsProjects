local Equipment = require("Game.Equipment")
local consts = require("consts")
local Weapon = setmetatable({},{__index=Equipment})
Weapon.__index = Weapon 


function Weapon:new(x,y,name)
    local w = setmetatable(Equipment:new(x,y,name),Weapon)
    

    --changable for each weapon
  

    --main combo stuff
    w.hitCounter = 0

    w.hitTime = 0.25

    w.attackBool = false 

    w.attackKey = false 

    w.animationName = "Idle-Right"

    w.sides = {
        left = false,
        right = false,
        upLeft = false,
        downLeft = false,
        downRight = false,
        upRight = false 
    }

    return w 

end 


function Weapon:decideCenter(rightCenter, leftCenter, upCenter, downCenter)
    
    local player = self.em:getEntity("Player")
    if player.dashing.dir == "right" then 
        self.center = rightCenter 
    

    elseif player.dashing.dir == "left" then 
        self.center = leftCenter 

    elseif love.keyboard.isDown(consts.keys["Aim-Up"]) then 
        self.center = upCenter 

    elseif love.keyboard.isDown(consts.keys["Aim-Down"]) then
        self.center = downCenter 

    end 

    

end 


function Weapon:update(dt,camera,player) 

end 


function Weapon:draw() 

end 



return Weapon