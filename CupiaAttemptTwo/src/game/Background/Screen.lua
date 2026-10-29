local BackgroundObject = require("engine.BackgroundObject") 
local globals= require("globals")
local Screen = setmetatable({},{__index = BackgroundObject}) 
Screen.__index = Screen 

function Screen:new(image,srcRect) 
    local s  = setmetatable(BackgroundObject:new(image,1,srcRect ),Screen)

    s.scale.x = globals.WIDTH/srcRect.width 
    s.scale.y = globals.HEIGHT/srcRect.height 

    return s 
end 

function Screen:update(dt) 

end 

function Screen:draw() 
    
    
    love.graphics.draw(self.spritesheet,self.quad, 0,0, 0, self.scale.x,self.scale.y)
end 



return Screen 