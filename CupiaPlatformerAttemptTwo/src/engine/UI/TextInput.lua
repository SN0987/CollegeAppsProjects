local Component = require("engine.UI.Component")
local Label = require("engine.UI.Label")
local Button = require("engine.UI.Button") 
local globals = require("globals")
local TextInput = setmetatable({},{__index=Component})
local GameMath = require("engine.GameMath")


TextInput.__index = TextInput


-- enter button 
function TextInput:new(x,y, camera,debug)  

    local ti = setmetatable(Component:new(x,y,"TextInput",camera,debug) , TextInput)

    
    ti.takeInput = false 
    ti.text = ""
    ti.button = Button:new(x+250+30,y,75,25, "Enter", camera, debug) 

    ti.padding = 20
    

    

    ti.label = Label:new(x,y,ti.text,camera,debug)

    ti.button:setColor(0.8,0.1,0.1,1)

    ti.button.label:setFont(globals.am:getFont("assets/fonts/font_basic.ttf",18),"assets/fonts/font_basic.ttf")
    
    ti:setBounds(x,y,250,25) 

    ti.label:alignCenter(ti) 

    ti.maxWords = 40 
    ti.label:setColor(0,0,0,1)  

    ti.mouseDown = false 
    
    
    return ti 
end 




function TextInput:setParams(maxWords, padding) 
    self.maxWords = maxWords
    self.padding = padding 
end 


--put skin on the butt
function TextInput:buttonParams(img_name,quad, assetManager,dWidth,dHeight, color, text, text_size, text_font,text_color)
    self.button:setColor(color.r,color.g,color.b,color.a)
    self.button:setTextParams(text_color,text_size,text,text_font)


    --Component:setImage(img_name,quad, assetmanager,dWidth,dHeight)
    self.button:setImage(img_name,quad, assetManager,dWidth,dHeight) 

    --align y center
    
    self.button.y = self.y + (self.height-self.button.height) / 2 
end 

function TextInput:setInputParams(color, text_size, text_font,font_path)  
    
    self.label:setColor(color.r,color.g,color.b,color.a) 
    self.label:setFont(text_font,font_path)
    self.label:setSize(text_size) 

end 

function TextInput:isInput() 

    local currentText = self.text 
    if self.button:isClicked() then
        if self.takeInput then 

            self.takeInput = false 
            self.label:setText("") 
            return true 
        end         

    else
        return false 
        
    end 
end 




function TextInput:update(dt) 
    if not self.dragMode then 


        --not effected by camera
        local mx,my = love.mouse.getPosition()
        if love.mouse.isDown(1) and GameMath.pointRectCollision(self, mx,my ) and not self.takeInput then 

          
            self.takeInput = true 
            
            globals.text_from_event = ""
            --self.text = ""
            
          

        end   
        
        if love.mouse.isDown(3) then 
            if self.takeInput then 
                self.takeInput = false 
            end 
        end 

        self.mouseDown = love.mouse.isDown(1) 


        if self.takeInput and #self.text < self.maxWords then 

            if self.label.x <= self.x then 
                self.width = self.width + 10 

                self.button:setPosition(self.x+self.width+self.padding, self.button.y)
                self.label:alignCenter(self)
            end 

            self.text = globals.text_from_event

            self.label:setText(self.text)

    
        end 
    end 

    if self.dragMode then 
        self.button:setPosition(self.x+self.width+self.padding, self.y) 
        self.label:alignCenter(self)
    end 
end 

function TextInput:draw() 


    


    self:drawBounds()
    self.button:draw() 
    self.label:draw() 


   

end 

return TextInput 