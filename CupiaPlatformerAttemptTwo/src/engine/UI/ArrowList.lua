local Component = require("engine.UI.Component")
local globals    = require("globals")
local ArrowList = setmetatable({},{__index=Component})
local Image = require("engine.UI.Image")
local Button = require("engine.UI.Button")
ArrowList.__index = ArrowList


function ArrowList:new(x,y,camera, debug, capacity) 
    
    local a  = setmetatable(Component:new(x,y,"ArrowList",camera,debug), ArrowList)

    a.capacity = capacity 
    a.maxCapacity = capacity

    -- item must be drawable item:draw item:update
    a.items = {}    

    a.currentItemIndex = 1 

    a.padding = 0
    a.arrow_one = Button:new(x-a.padding,y,16,16,"",camera,debug)
    a.arrow_two = Button:new(x+a.padding,y,16,16,"",camera,debug)
    a.arrow_one:setColor(0.1,0.75,0.25)
    a.arrow_one:setImage("Arrow-Button",love.graphics.newQuad(0,0,16,16,16,16),globals.am,16,16)
    a.arrow_one.scale.x = -1
    a.arrow_two.scale.x = 1
    --a.arrow_one:setTextParams({r=1,g=1,b=1,a=1},18,">",globals.am:getFont("assets/fonts/font_basic.ttf",18),"assets/fonts/font_basic.ttf")

    a.arrow_two:setColor(0.1,0.75,0.25)
    a.arrow_two:setImage("Arrow-Button",love.graphics.newQuad(0,0,16,16,16,16),globals.am,16,16)

    a:setBounds(x,y,64,32)
    a:setColor(0,0,1,1)

    a.arrowBeingPressed = false 

    a.arrowClicks = {
        left = false, 
        right = false 
    }
    return a 

end 


function ArrowList:getItem() 
    if self.items[self.currentItemIndex] ~= nil then 
        return self.items[self.currentItemIndex]
    end 
end 


function ArrowList:addItem(item) 


    

    if #self.items < self.capacity and not self:isRepeatedNumber(item.number) then 
        table.insert(self.items,item)
    else


    end 
end 


--make sure no same numbers are contained
function ArrowList:isRepeatedNumber(number)
    local repeated = false  
    for k,v in pairs(self.items) do 
        if v.number == number then 
            print("repeating number")
            return true 
            
        end 
    end 

    return false 
end 


function ArrowList:loadItems(path,spritesheet)
    
   
    local file = dofile(path)



    if file then 
        print("int this")
        local index = 1 
        for k,v in ipairs(file) do

            --function Image:new(x,y,img, quad, scale,camera, debug,number)
            quad = love.graphics.newQuad(v[1],v[2],v[3],v[4],spritesheet:getWidth(),spritesheet:getHeight()) 

            local img = Image:new(0,0,spritesheet, quad, {x=v[5],y=v[6]},self.camea,v[7],v[8])
            self:addItem(img)
        end
    end 

end 


function ArrowList:setParams(color, padding, scaleX,scaleY) 

    self.arrow_two:setColor(color.r,color.g,color.b,color.a)
    self.arrow_one:setColor(color.r,color.g,color.b,color.a)
    self.padding = padding 
    self.arrow_one.scale.x = -scaleX 
    self.arrow_one.scale.y = scaleY
    self.arrow_two.scale.x = scaleX 
    self.arrow_two.scale.y = scaleY

    self.arrow_one.width = (16*scaleX) 
    self.arrow_two.width = 16*scaleX 
    self.arrow_one.height = 16*scaleY
    self.arrow_two.height  = 16*scaleY 
end 

function ArrowList:standaredImageSize(width,height)
     

end     

function ArrowList:update(dt) 



  


    if self.items[self.currentItemIndex] ~= nil then 

        local item = self.items[self.currentItemIndex]

        
        
        self.items[self.currentItemIndex]:setBounds(self.x,self.y,item.width,item.height)
        
        self.arrow_one:setBounds(self.x-(item.width+self.padding),self.y,self.arrow_one.width,self.arrow_one.height)
        self.arrow_two:setBounds(self.x+(item.width+self.padding),self.y,self.arrow_two.width,self.arrow_two.height)

        self.items[self.currentItemIndex]:update(dt)


        self.width = (self.arrow_one.width+self.padding) * 2 + self.items[self.currentItemIndex].width


        

        if self.arrow_one:isClicked() and not self.arrowClicks.left then 
            if self.currentItemIndex > 1 then 
               
                self.currentItemIndex = self.currentItemIndex -1 
            end 

            self.arrowBeingPressed = true 

        end 
        self.arrowClicks.left = self.arrow_one:isClicked()

        if self.arrow_two:isClicked() and not self.arrowClicks.right then 
            
            if self.currentItemIndex < #self.items then 
                
                self.currentItemIndex = self.currentItemIndex  + 1 
            end 

            self.arrowBeingPressed = true     
        end 

        self.arrowClicks.right = self.arrow_two:isClicked()


        if not self.arrowClicks.right and not self.arrowClicks.left then 
            self.arrowBeingPressed = false 
        end 

        
    else 

        self.arrow_one:setBounds(self.x-(self.arrow_one.width+self.padding),self.y,self.arrow_one.width,self.arrow_one.height)
        self.arrow_two:setBounds(self.x+(self.arrow_two.width+self.padding),self.y,self.arrow_two.width,self.arrow_two.height)
        
        self.width = (self.arrow_one.width + self.padding) * 2

    end 


    self.arrow_one:update(dt)
    self.arrow_two:update(dt)
    

end 

function ArrowList:returnSelection() 
    
    

    if self.items[self.currentItemIndex] ~= nil then 


        local item = self.items[self.currentItemIndex] 

        

        local img = Image:new(item.x,item.y,item.img, item.quad, item.ogScale, item.camera, item.debug, item.number)
        img.onTheList = false 
    
        return img
    end 
end 

function ArrowList:draw() 

    self.arrow_one:draw()

    self.arrow_two:draw() 

    if self.items[self.currentItemIndex] ~= nil then 
        self.items[self.currentItemIndex]:draw()
    end
    
    --self:drawBounds()
end 



return ArrowList