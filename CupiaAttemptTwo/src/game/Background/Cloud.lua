

local BackgroundObject = require("engine.BackgroundObject")
local Cloud = setmetatable({} , {__index=BackgroundObject})
local globals = require("globals") 
Cloud.__index = Cloud 


--max represents the amount of images
function Cloud:new(sx,sy,spritesheet,srcY, sWidth,sHeight, index, max) 
    local c = setmetatable(BackgroundObject:new(spritesheet,index,{x=0,y=srcY,width=sWidth,height=sHeight}), Cloud) 

    c.sWidth = sWidth 
    c.sHeight = sHeight
    c.max = max
    c.srcY = srcY 
    c.srcX = love.math.random(0, max) * sWidth 

    c.scale.x = sx 
    c.scale.y = sy 
    c.vel = love.math.random(35, 120) 

    c.x = love.math.random(0, globals.WIDTH)
    c.y = love.math.random(0, 20)
    c.width = c.sWidth*sx 
    return c 
end 

function Cloud:update(dt) 

    self.x = self.x + self.vel * dt 



    if self.x >= globals.WIDTH + self.width then 
        self.x = - self.width 
        self.srcX = love.math.random(0, self.max-1) * self.sWidth 
        self.quad = love.graphics.newQuad(self.srcX,self.srcY,self.sWidth,self.sHeight, self.spritesheet:getWidth(), self.spritesheet:getHeight()) 
        self.vel = love.math.random(35,120)
        self.y = love.math.random(0, 20)
    end 



end 

function Cloud:draw() 
    love.graphics.draw(self.spritesheet, self.quad, self.x,self.y, 0, self.scale.x,self.scale.y )
end 

return Cloud 