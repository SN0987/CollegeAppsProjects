local Element = require("Engine.Element")

local InfoText = setmetatable({},{__index=Element})
InfoText.__index = InfoText


function InfoText:new(x,y,text,size,box,box_color,font_color,img,animate,name) 
    local i = setmetatable(Element:new(name),InfoText)


    i.box = box 
    i.img = img 
    i.original_text = text 
    i:setColor(box_color.r,box_color.g,box_color.b)

    print(box)
    i:setText(x,y,text,size,font_color,"assets/fonts/font_basic.ttf") 

    i:setDims(x,y,i.font:getWidth(text)+15,i.font:getHeight(text)+15)


    i.font_position.x = i.position.x+(i.bounds.width/2)-i.font:getWidth(text)/2
    i.font_position.y = i.position.y+(i.bounds.height/2)-i.font:getHeight(text)/2

    i.animate = animate

    if i.animate then 
        self.text = ""
    end 

    i.counter = 1 
    i.speed = 0.05 
    i.timer = 0
    return i 
end 

function InfoText:update(dt) 

    if self.show then 
        if self.animate  then 
            self.timer = self.timer + dt 

            if self.timer >= self.speed then 
                self.timer = 0
                if self.counter < #self.original_text then 
                    self.counter = self.counter + 1 

                else
                    self.counter = #self.original_text
                    self.animate = false 
                end 
            end 

            self.text = string.sub(self.original_text,1,self.counter)
            self:setText(self.position.x+(self.bounds.width/2)-self.font:getWidth(self.text)/2,self.position.y+(self.bounds.height/2)-self.font:getHeight(self.text)/2,self.text,self.textSize,self.font_color,nil) 
        end 
    end 
   
end 


function InfoText:draw() 

    if self.show then 
        love.graphics.setColor(self.color.r,self.color.g,self.color.b,1.0) 

        if self.box == "box" then 
            if self.img == nil then 
                love.graphics.rectangle("fill",self.position.x,self.position.y,self.bounds.width,self.bounds.height)

            end 
        elseif self.box == "outline" then 
            love.graphics.rectangle("line",self.position.x,self.position.y,self.bounds.width,self.bounds.height)
        elseif self.box == "underline" then 
            love.graphics.line(self.position.x,self.position.y,self.position.x+self.bounds.width,self.position.y)
        end 

        love.graphics.setColor(1,1,1,1)

        self:drawText()
    end 

 
end 




return InfoText 