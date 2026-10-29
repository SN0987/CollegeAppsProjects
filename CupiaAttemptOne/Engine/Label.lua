
local Element = require("Engine.Element")
local Label = setmetatable({},{__index=Element})
local consts = require("consts")
Label.__index = Label 
function Label:new(x,y,text,size,font_path,color,max_bound,name) 
    local l = setmetatable(Element:new(name),Label)

    l:setText(x,y,text,size,color,font_path)
    l:setDims(x,y,l.font:getWidth(text),l.font:getHeight(text))
    l.max_bound = max_bound 
    l.img = nil 
    l.quad = nil
    return l  
end 

function Label:addImage(img,quad,x,y,width,height) 
    self.img = img
    self.quad = quad
    self:setDims(x,y,width,height)

end 

--for text not for the overall elemtn

function Label:centerX() 
    local width = self.font:getWidth(self.text)

    self.font_position.x = consts.WIDTH/2-width/2 

end 


function Label:centerY() 
    local height = self.font:getHeight(self.text)

    self.font_position.y = consts.HEIGHT/2-height/2 
end 

function Label:update(dt)
    
    --self:fontBounds(self.max_bound,self.textSize-15,self.position.x,self.position.y,self.font_path)
end 

function Label:draw()

    if self.show then 
        local scaleX 
        local scaleY 
        if self.img ~= nil then 

            if self.quad == nil then 
                scaleX = self.bounds.width/self.img:getWidth()
                scaleY = self.bounds.height/self.img:getHeight()
                love.graphics.draw(self.img,self.position.x,self.position.y,0,scaleX,scaleY)
            elseif self.quad ~= nil then 
                local x,y,w,h = self.quad:getViewport()
                scaleY = self.bounds.height/h
                scaleX = self.bounds.width/w
                love.graphics.draw(self.img,self.quad,self.position.x,self.position.y,0,scaleX,scaleY)
            end 

        end 
            
        self:drawText()
    end 
   


end 


return Label 