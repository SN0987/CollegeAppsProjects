
local Equipment = require("Game.Equipment")
local consts    = require("consts")
local Armor = setmetatable({},{__index=Equipment})
Armor.__index = Armor
function Armor:new(x,y,em,name) 
    local a = setmetatable(Equipment:new(x,y,name),Equipment)

    a.em = em 
    a.availableArmor = 0
    return a 
end 


function Armor:playerArmorOn(player) 


    if player:overLap(self) and love.keyboard.isDown(consts.keys["Pick-Up"]) then 
        
        if player.isArmor == false then 
            player.isArmor = true 
            self.pickedUp = true 
            player:gainArmor(self.availableArmor)
        end 

    end 


    if player.isArmor and self.pickedUp then 
        player.equippedArmor = self
    end 

end

function Armor:playerArmorOff(player) 
    
    if player.armor <= 1 and self.pickedUp and player.isArmor then 
        self.delete = true 
        player.isArmor = false 

    end     

    if love.keyboard.isDown(consts.keys["Drop-Armor"]) then 
        if player.isArmor and self.pickedUp then 
            self.pickedUp = false 
            player.isArmor = false 
            player:removeArmor(self.availableArmor)
        end 
    end 
end 

function Armor:update(dt,camera)

end 

function Armor:draw() 

end 

return Armor 