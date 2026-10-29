local Element = require("Engine.Element")
local Button = setmetatable({},{__index=Element})
Button.__index = Button 


--[[
    img_args = {
    
        if img = nil then use  
        add an image quad if necessary
        color 
    }
]]
function Button:new(x,y,width,height,text,size,img,color,font_color,name)
    local b = setmetatable(Element:new(name),Button)

    b:setDims(x,y,width,height)
    
    b.img = img 
    b.color = color
    b.original_r = color.r 
    b.original_b = color.b 
    b.original_g = color.g 
    b.changed_color = {
        r=color.r*0.9,
        g = color.g *0.9,
        b = color.b *0.9,
    }

    --b:setColor(color.r,color.g,color.b)
    b:setText(b.position.x+(b.bounds.width/2)-(size)/2,b.position.y+(b.bounds.height/2)-size/2,text,size,font_color,"assets/fonts/font_pixel.ttf")
    b.font_position.x = b.position.x+(b.bounds.width/2)-b.font:getWidth(text)/2
    b.font_position.y = b.position.y+(b.bounds.height/2)-b.font:getHeight(text)/2
    b.highlighted = false 

    b.isMouseDown = false 

    
    return b 
end 


function Button:update(dt,camera) 
    if self.show then 
        if self:collideWithMouse(camera) then 

            self.color.r = self.changed_color.r 
            self.color.g = self.changed_color.g 
            self.color.b = self.changed_color.b 
        else
            self.color.r = self.original_r
            self.color.g = self.original_g 
            self.color.b = self.original_b 
        end 




        self:fontBounds(self.position.x+self.bounds.width,5,{x= self.position.x+(self.bounds.width/2)-self.font:getWidth(self.text)/2,y= self.position.y+(self.bounds.height/2)-self.font:getHeight(self.text)/2},self.font_path)
    end 
    

end 


function Button:clicked(camera) 

    
    return love.mouse.isDown(1) and self:collideWithMouse(camera)

end 




function Button:draw() 

    if self.show then 
        love.graphics.setColor(self.color.r,self.color.g,self.color.b,1.0)
    
        if self.img ~= nil then 
            local scaleX 
            local scaleY 
            if self.img_quad ~= nil then 
                local x,y,w,h = self.img_quad:getViewport()
                scaleX = self.bounds.width/w
                scaleY = self.bounds.height/h
                love.graphics.draw(self.img,self.img_quad,self.position.x,self.position.y,0,scaleX,scaleY)
            else 
                scaleX = self.bounds.width/self.img:getWidth()
                scaleY = self.bounds.height/self.img:getHeight()

                love.graphics.draw(self.img,self.position.x,self.position.y,0,scaleX,scaleY)
            end 

        else
            love.graphics.rectangle("fill",self.position.x,self.position.y,self.bounds.width,self.bounds.height)
        end 

        love.graphics.setColor(1.0,1.0,1.0 , 1.0 )
        self:drawText()
    end 
   

end 

return Button