local Component = require("engine.UI.Component")
local globals    = require("globals")

local Button = setmetatable({}, {__index=Component})
local Label = require("engine.UI.Label")
local GameMath = require("engine.GameMath")
Button.__index = Button 

function Button:new(x,y,width,height,text,camera,debug) 
    
    local b = setmetatable(Component:new(x,y,"button",camera,debug),Button) 
    
    
    b:setBounds(x,y,width,height)

    b.label = Label:new(0,0,text,camera, debug)


    b.label:setFont(globals.am:getFont("assets/fonts/font_pixel.ttf", 20))

    b.label:alignCenter(b) 





    return b

end 



function Button:setTextParams(color,size, text,font, path)
    
    self.label:setFont(font, path) 
    self.label:setText(text)
    self.label:setColor(color.r,color.g,color.b,color.a)
   
    self.label:setSize(size)

    
end 

function Button:isClicked() 

    if love.mouse.isDown(1) then 
        local mx,my = self.camera:getGlobalMousePos()
        if GameMath.pointRectCollision(self,mx,my) then 

            
            return true
        end 
    end 
  

    return false

end 

function Button:setPosition(x,y) 
    self.x = x 
    self.y = y
    
    self.label:alignCenter(self) 
end 
function Button:update(dt) 


    self.label:alignCenter(self)
    --self.label.x = (self.x+self.width/2) - self.label.font:getWidth(self.label.text)

    
end 

function Button:draw() 






    self:drawImage()

    if self.img == nil then 
        self:drawBounds() 
    end 
   
    self.label:draw() 

end 

return Button