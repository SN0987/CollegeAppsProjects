local Armor = require("Game.Armor")
local RomanArmor = setmetatable({},{__index=Armor})
local consts = require("consts")
RomanArmor.__index = RomanArmor 


function RomanArmor:new(x,y,em) 
    local p = setmetatable(Armor:new(x,y,"Roman-Armor"),RomanArmor)
    p.em = em 
    p.width = 28
    p.height = 28
    p.img = consts.AssetManager:getImage("Roman-Armor","Player/roman_armor.png")
  
    p.availableArmor = 2

    return p
end 

function RomanArmor:update(dt,camera) 
   
    if self.pickedUp then 

        if consts.player.dashing.dir == "right" then 
            self.center.x = consts.player.x + 3
        elseif consts.player.dashing.dir == "left" then 
            self.center.x = consts.player.x + 1
        end 
      
        self.center.y = consts.player.y - 3
    end 

    self:playerArmorOn(consts.player)
    self:playerArmorOff(consts.player)
    self:parentUpdate(dt)

    self.animator:update(dt) 
end 

function RomanArmor:draw() 
    local scaleX = self.width/16
    local scaleY = self.height/16 

    love.graphics.draw(self.img,self.x,self.y,0,scaleX,scaleY)
end 


return RomanArmor