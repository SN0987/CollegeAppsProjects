local Sprite = require("Game.Sprite")
local Trampoline = setmetatable({},{__index=Sprite})
local consts = require("consts")
Trampoline.__index = Trampoline 


function Trampoline:new(x,y,em) 
    local t = setmetatable(Sprite:new(x,y,50,25,"Trampoline","static"),Trampoline)


    t.em = em 
    t.hitbox.x = x 
    t.hitbox.y = y 
    t.hitbox.width = 50
    t.hitbox.height = 25
    t.img = consts.AssetManager:getImage("Trampoline","Overworld/trampoline.png")
    t.playerHit = false 
    
    return t 
end 


function Trampoline:update(dt,camera)


    if consts.player.jumping.bool == false and not consts.player.hurt.isHurt then 
        consts.player.jumping.speed = consts.player.originalJumpSpeed
    end 


    self.hitbox.x = self.x 
    self.hitbox.y = self.y 

    
end 

function Trampoline:draw() 
    local scaleX = 64/16 
    local scaleY = 64/16 

   
    love.graphics.draw(self.img,self.x-10,self.y-29,0,scaleX,scaleY)

    
    
end 


return Trampoline 