local Element = require("Engine.Element")
local Options = setmetatable({},{__index=Element})
local Label = require("Engine.Label")
local consts = require("consts")
Options.__index = Options 


function Options:new(name,font_path,sizes,x,margin,color) 
    local o = setmetatable(Element:new(name),Options)

    o.options = {}

    o.font_path = font_path

    o.minSize = sizes.minSize 
    o.maxSize = sizes.maxSize 

    o.x = x 
    o.color = color 
   

    o.margin = margin 


    o.currentOption = nil 

    o.names = {}
    o.counter = 1

    o.centered = false 

    o.down = false 
    o.up = false 

    o.selectSquare = {
        x = 0, 
        y = 0, 
        width = 16,
        height = 16
    }
    return o
end 

function Options:setCurrentOption(name)
    self.currentOption = name 
    
    for k,v in pairs(self.names) do 
        if v == name then 
            self.counter = k
        end 
    end 
end 


function Options:getCurrentOptionLabel() 
    return self.options[self.currentOption]
end 


function Options:addOption(name, text,y) 

    

 
    local label = Label:new(self.x,y,text,self.minSize, self.font_path, self.color, 800, name)

    self.options[name] = label 
    table.insert(self.names,name)

    --Label:new(x,y,text,size,font_path,color,max_bound,name) 
end 


function Options:setToCenter(screen)
    for k,v in pairs(self.options) do 
        v:centerX()
    end 
end 


function Options:returnOption() 

    return self.names[self.counter ]
end 

function Options:update(dt)

    if self.show then 
         --l:setText(x,y,text,size,color,font_path)
        self.currentOption = self.names[self.counter]
        local label = self.options[self.currentOption]
        self.options[self.currentOption]:setText(label.font_position.x,label.font_position.y,label.text,self.maxSize,self.color,self.font_path)
        self.selectSquare.x = label.font_position.x - 20 
        self.selectSquare.y = label.font_position.y+label.font:getHeight(label.text)/2-self.selectSquare.height/2 

        for k,v in pairs(self.options) do 
            v:update(dt)

            if k ~= self.currentOption then 
                v:setText(v.font_position.x,v.font_position.y,v.text,self.minSize,self.color,self.font_path)
            end 
        end 


        if love.keyboard.isDown("s") and not self.down or love.keyboard.isDown("down") and not self.down then 
            if self.counter < #self.names then 
                self.counter = self.counter + 1
            -- self.options[self.currentOption]:setText(label.font_position.x-(self.maxSize-self.minSize),label.font_position.y-(self.maxSize-self.minSize),label.text,self.maxSize,self.color, self.font_path)
            end 
        end 

        self.down = love.keyboard.isDown("s") or love.keyboard.isDown("down")

        if love.keyboard.isDown("w") and not self.up or love.keyboard.isDown("up") and not self.up then 
            if self.counter > 1 then 
                self.counter = self.counter - 1
                --self.options[self.currentOption]:setText(label.font_position.x-(self.maxSize-self.minSize),label.font_position.y-(self.maxSize-self.minSize),label.text,self.maxSize,self.color, self.font_path)
            end 
        end 

        self.up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
    end 
   

    
end 


function Options:draw() 

    if self.show then 
        love.graphics.setColor(self.color.r,self.color.g,self.color.b,1)

        love.graphics.rectangle("fill",self.selectSquare.x,self.selectSquare.y,self.selectSquare.width,self.selectSquare.height)
        for k,v in pairs(self.options) do 
            v:draw()
        end 
    end 
    
end 
return Options