local Sprite = require("engine.Sprite")
local PlayerLiquid = setmetatable({}, {__index=Sprite})
PlayerLiquid.__index = PlayerLiquid

function PlayerLiquid:new(spritebatch,em)

    local pl = setmetatable(Sprite:new(0,0,7,2,"playerliquid",{x=0,y=2*16,width = 16, height = 16}, 2,2,spritebatch ), PlayerLiquid)
    
    pl.em = em 


    pl.player = pl.em:getPlayer()
    pl.isAnimate = true
    
    pl.scale.x = pl.player.scale.x 
    pl.scale.y = pl.player.scale.y 

    pl.x = pl.player.x + pl.player.width / 2 
    pl.y = pl.player.y + 5

    pl:addAnimation("idle",3, 3, 0, 2*16,16,16)
    pl:addAnimation("running",3,5,0,3*16,16,16)

    return pl 


end 

function PlayerLiquid:update(dt) 
      

    self:changeAnimation(self.player.currentAnimation)

    self.scale.x = self.player.scale.x 
    self.scale.y = self.player.scale.y 




    
    self.x = self.player.x 
    self.y = self.player.y 

    

   
    
    self.spritebatch:setColor(0,0.9,0.3,1)



    self:updateAnimating(dt)
    self.spritebatch:setColor(1,1,1,1)

    self.imgCoords.x = self.player.imgCoords.x
    self.imgCoords.y = self.player.imgCoords.y 




   
end 

function PlayerLiquid:draw() 

end 

return PlayerLiquid