local Camera = {} 
local globals = require("globals")
Camera.__index = Camera 

function Camera:new(x,y,width,height)
    
    local c = setmetatable({},Camera) 

    c.x = x
    c.y = y 
    c.width = width 
    c.height = height 

    c.defaultWidth = width 
    c.defaultHeight = height 

    c.scale = {
        x = 1,
        y = 1
    }

    c.shake = false 

    c.zoom_= {
        x = 1, 
        y = 1
    }


    
    return c    
    

end 

function Camera:zoom(x,y) 

    self.zoom_.x = x 
    self.zoom_.y = y 


    
end 

function Camera:clampX(min, max) 

    if self.x <= min then 
        self.x = min 
    end 

    if self.x >= max then 
        self.x = max 
    end 
    
end 

function Camera:clampy(min, max) 

    if self.y <= min then 
        self.y = min 
    end 

    if self.y >= max then 
        self.y = max 
    end 
    
end 


function Camera:resize(w,h) 

    self.width = w 
    self.height = h 
    
    
    self.scale.x = (self.width/self.defaultWidth) 
    self.scale.y = (self.height/self.defaultHeight) 

end 

function Camera:move(dx,dy,dt) 
    self.x = self.x + dx  * dt 
    self.y = self.y + dy * dt 
end 

function Camera:follow(x,y) 
    self.x = x  - (self.width) / (2 * (self.scale.x*self.zoom_.x))
    self.y = y  - (self.height) / (2* (self.scale.y*self.zoom_.y))
end 

function Camera:getGlobalMousePos() 

    local mx,my = love.mouse.getPosition() 
    local pos = {
        x = mx ,y = my
    }



    pos.x = pos.x / (self.scale.x*self.zoom_.x)  + self.x 
    pos.y = pos.y /(self.scale.y*self.zoom_.y) + self.y 

    return pos.x, pos.y
end 


function Camera:apply() 

    love.graphics.push()
     love.graphics.scale(self.scale.x*self.zoom_.x,self.scale.y*self.zoom_.y) 
    love.graphics.translate(-math.floor(self.x), -math.floor(self.y)) 
    
   
    
    
end


function Camera:uiApply() 
    love.graphics.push()
    love.graphics.scale(self.scale.x,self.scale.y) 
    love.graphics.translate(-math.floor(self.x), -math.floor(self.y)) 
end 
function Camera:scaleApply()
    love.graphics.push() 
    love.graphics.scale(self.scale.x,self.scale.y) 

end 




function Camera:unapply() 
    love.graphics.pop()
end 


function Camera:update(dt) 


    self:resize(globals.screenWidth,globals.screenHeight)

end 



function Camera:draw() 


end     
    
    
return Camera  