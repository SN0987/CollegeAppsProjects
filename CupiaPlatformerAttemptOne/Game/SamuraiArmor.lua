local Armor = require("Game.Armor")
local SamuraiArmor = setmetatable({},{__index=Armor})
local consts = require("consts")
SamuraiArmor.__index = SamuraiArmor 


function SamuraiArmor:new(x,y,em) 
    local p = setmetatable(Armor:new(x,y,"Samurai-Armor"),SamuraiArmor)
    p.em = em 
    p.width = 28
    p.height = 28
    p.img = consts.AssetManager:getImage("Samurai-Armor","Player/samurai_helmet.png")
  
    p.availableArmor = 4

    return p 
end 

function SamuraiArmor:update(dt,camera) 
    
    if self.pickedUp then 

        if consts.player.dashing.dir == "right" then 
            self.center.x = consts.player.x + 2
        elseif consts.player.dashing.dir == "left" then 
            self.center.x = consts.player.x 
        end 
      
        self.center.y = consts.player.y - 3
    end 

    self:playerArmorOn(consts.player)
    self:playerArmorOff(consts.player)
    self:parentUpdate(dt)

    self.animator:update(dt) 
end 

function SamuraiArmor:draw() 
    local scaleX = self.width/16
    local scaleY = self.height/16 

    love.graphics.draw(self.img,self.x,self.y,0,scaleX,scaleY)
end 


return SamuraiArmor 