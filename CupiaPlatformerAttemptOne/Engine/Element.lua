local Element = {}
local consts = require("consts")
Element.__index = Element 



--fix the fontbounds function
function Element:new(name) 
    local e = setmetatable({},Element)

    e.show = true 
    e.name = name
    e.position = {
        x = nil, 
        y = nil 
    }

    e.bounds = {
        width = nil,
        height = nil, 
    }

    e.text = "Text"
    e.textSize = nil 
    e.font = nil 

    e.font_color =  {
        r = nil,
        g=nil,
        b=nil 
    }
    e.color = {
        r = nil, 
        g = nil,
        b = nil 
    }

    e.font_position = {
        x = nil ,
        y = nil
    }
    e.font_path = nil 
    return e 
end 

function Element:setDims(x,y,width,height) 

    self.position.x = x 
    self.position.y = y  
    self.bounds.width = width 
    self.bounds.height = height 

end 

function Element:setColor(r,g,b)
    self.color.r = r 
    self.color.b = b 
    self.color.g = g 
end 



function Element:setText(x,y, string_text, size, color, font_path)
    self.text = string_text 
    self.textSize = size  

    self.font_path = font_path

    
    if font_path == nil then 
        self.font = love.graphics.newFont(self.textSize) 
    else
        self.font = love.graphics.newFont(self.font_path,self.textSize)
    end 

    self.font_position.x = x 
    self.font_position.y = y 
    self.font_color.r = color.r 
    self.font_color.g = color.g 
    self.font_color.b = color.b 
end 

--add changes later to optimize only loading one font 

function Element:drawText() 

    love.graphics.setColor(self.font_color.r,self.font_color.g,self.font_color.b,1.0 )
    love.graphics.setFont(self.font )
    love.graphics.print(self.text,self.font_position.x,self.font_position.y)
    love.graphics.setColor(1,1,1,1)
end 



function Element:fontBounds(max_bound, minimumFontSize,position, path) 
    if self.font_position.x+self.font:getWidth(self.text) >= max_bound then 
        if self.textSize > minimumFontSize then 
            self.textSize = self.textSize - 1 
        else 
            self.textSize = minimumFontSize 
        end 
        if path ~= nil then 
            self.font = love.graphics.newFont(path,self.textSize)
        else
            self.font = love.graphics.newFont(self.textSize)
        end 
        
        self.font_position.x = position.x 
        self.font_position.y = position.y
    end 
end 

function Element:toCenterX(align_font) 

    self.position.x = consts.WIDTH/2-self.bounds.width/2 

    if align_font ~= nil or align_font ~= false then 

        self.font_position.x = self.position.x+(self.bounds.width/2)-self.font:getWidth(self.text)/2
  
    end 

end 

function Element:toCenterY(align_font) 
    self.position.y = consts.HEIGHT/2-self.bounds.height/2 

    if align_font ~= nil or align_font ~= false then 
        self.font_position.y = self.position.y+(self.bounds.height/2)-self.font:getHeight(self.text)/2
    end 
end 



function Element:collideWithMouse(camera)
    local mx,my
    if camera ~= nil then 
        mx,my = camera:globalMousePos()
    else
        mx,my = love.mouse.getPosition()
    end 
    

    local x = self.position.x 
    local y = self.position.y 
    local width = self.bounds.width 
    local height = self.bounds.height  
    if mx >= x and mx <= x+width and my >= y and my <= y+height then 
       
        return true 
    end     

end 

function Element:update(dt )

end 


function Element:draw( )

    if self.show then 
        love.graphics.setColor(self.color.r,self.color.g,self.color.b)
        love.graphics.rectangle("fill",self.position.x,self.position.y,self.bounds.width,self.bounds.height)

        love.graphics.setColor(1,1,1,1)
    end
   


end 

return Element 