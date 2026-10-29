local Component = require("engine.UI.Component")
local globals    = require("globals")

local Label = setmetatable({}, {__index=Component})

Label.__index = Label 

function Label:new(x,y,text,camera,debug)

    local l = setmetatable(Component:new(x,y,"Label",camera,debug), Label)

    l.text = text 
    
    l.size = 15
    l.font = love.graphics.newFont(l.size)

    l.scale = {
        x = 1,y = 1
    }

    l.useLine = false 


    l.path = "" 
    l:setBounds(l.x,l.y,l.font:getWidth(l.text),l.font:getHeight(l.text))

    
    return l 

end 

function Label:setFont(font,path) 

 
    self.font = font 

    self.path = path 
end 


function Label:setSize(size) 
    self.size = size 

    self.font = globals.am:getFont(self.path,size) 

    local prevWidth = self.font:getWidth(self.text) 
    local prevHeight = self.font:getHeight(self.text)

     
    self.scale.x = self.size/15
    self.scale.y = self.size/15

    
    local newWidth = self.font:getWidth(self.text) 
    local newHeight = self.font:getHeight(self.text)

    local dx = (newWidth - prevWidth )/2
    local dy = (newHeight - prevHeight)/2

    self.x = self.x - dx
    self.y = self.y - dy 

    

    self:setBounds(self.x,self.y,self.font:getWidth(self.text),self.font:getHeight())


end 




function Label:alignCenter(entity)


    self:alignCenterX(entity)
    self:alignCenterY(entity)

end     


function Label:alignCenterX(entity)
    
    local width = self.font:getWidth(self.text) 

    

    self.x = (entity.x) + (entity.width - width) / 2

    self:setBounds(self.x,self.y,self.font:getWidth(self.text),self.font:getHeight())
    
end     


function Label:setText(text)
    local prevWidth = self.font:getWidth(self.text) 
    local prevHeight = self.font:getHeight(self.text)


    self.text = text 

    local newWidth = self.font:getWidth(self.text) 
    local newHeight = self.font:getHeight(self.text)

    local dx = (newWidth - prevWidth )/2
    local dy = (newHeight - prevHeight)/2

    self.x = self.x - dx
    self.y = self.y - dy 

    


    --print("DX: " .. tostring(dx) .. " DY: " .. tostring(dy))
    self:setBounds(self.x,self.y,self.font:getWidth(self.text),self.font:getHeight())
end 

function Label:attachLine() 

    self.useLine = true 


    print(self.font:getWidth(self.text)/self.size)
    self.img = globals.am:get("Label-Line") 

    self.scale.x = (self.font:getWidth(self.text)/self.size) 
    self.scale.y = ((self.font:getHeight(self.text)/self.size) * 1.5) 

    print(self.font:getHeight(self.text)/self.size)

end 


function Label:alignCenterY(entity)
    


    local height = self.font:getHeight(self.text)

    self.y = (entity.y)  + (entity.height - (height)) / 2
    self:setBounds(self.x,self.y,self.font:getWidth(self.text),self.font:getHeight())

    
end     


function Label:update(dt) 

end 

function Label:draw() 


    if self.useLine then 
        self:drawImage()
    end 

    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color.r,self.color.g,self.color.b,self.color.a)

    
    if self.useLine then 
        love.graphics.print(self.text,self.x,self.y+ 5)
    else 

        love.graphics.print(self.text,self.x,self.y)
    end 
  
    love.graphics.setColor(1,1,1,1)

end 

return Label