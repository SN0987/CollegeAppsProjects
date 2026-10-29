local ProjectileBody = require("engine.ProjectileBody")
local TeaBullet = setmetatable({} , {__index=ProjectileBody}) 
TeaBullet.__index = TeaBullet



function TeaBullet:new(x,y,width,height) 
    local t = setmetatable(ProjectileBody:new(width,height), TeaBullet) 


    --default stats

    t:makeCurved(160, x,y,450,50,45) 

    return t 
end     

function TeaBullet:update(dt) 
    self:updateParent(dt)

 
end     

function TeaBullet:draw() 
    love.graphics.setColor(1,0,0,1) 

    love.graphics.rectangle("fill", self.x,self.y,self.width,self.height)
end 



return TeaBullet