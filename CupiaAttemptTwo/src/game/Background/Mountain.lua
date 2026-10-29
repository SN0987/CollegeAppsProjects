local BackgroundObject = require("engine.BackgroundObject")
local Mountain = setmetatable({}, {__index=BackgroundObject})
Mountain.__index = Mountain

function Mountain:new(img,srcRect,index,x,y,scale)
    local m = setmetatable(BackgroundObject:new(img,index,srcRect),Mountain) 



    m.scale.x = scale.x 
    m.scale.y = scale.y 
    m.x = x
    m.y = y

    m.enableDrag = true 

    return m
end 

function Mountain:update(dt) 
   
end 

function Mountain:draw()  


    love.graphics.draw(self.spritesheet,self.quad, self.x,self.y, 0 ,self.scale.x,self.scale.y )

end 


return Mountain 