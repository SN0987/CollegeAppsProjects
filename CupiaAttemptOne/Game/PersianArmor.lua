local Armor = require("Game.Armor")
local PersianArmor = setmetatable({},{__index=Armor})
local consts = require("consts")
PersianArmor.__index = PersianArmor

function PersianArmor:new(x,y,em)

    local p = setmetatable(Armor:new(x,y,"Persian-Armor"),PersianArmor)
    p.em = em 
    p.width = 28
    p.height = 28
    p.img = consts.AssetManager:getImage("Persian-Armor","Player/persian_armor.png")
    p.animator:add(p.img,0,16,16,"Armor",8,3)
    p.animator:setName("Armor")
    p.availableArmor = 3 
    return p 

end 

function PersianArmor:update(dt,camera)
    
    if self.pickedUp then 

        if consts.player.dashing.dir == "right" then 
            self.center.x = consts.player.x + 4
        elseif consts.player.dashing.dir == "left" then 
            self.center.x = consts.player.x + 2
        end 
      
        self.center.y = consts.player.y - 5
    end 

    self:playerArmorOn(consts.player)
    self:playerArmorOff(consts.player)
    self:parentUpdate(dt)

    self.animator:update(dt) 
end 


function PersianArmor:draw() 
    local scaleX = self.width/16
    local scaleY = self.height/16 

    self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
end 

return PersianArmor 