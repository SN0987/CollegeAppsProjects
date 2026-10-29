local Sprite = require("engine.Sprite")
local GameMath = require("engine.GameMath")
local Consumable = setmetatable({} , {__index=Sprite})
local globals = require("globals" )
local Label = require("engine.UI.Label")

Consumable.__index = Consumable


--function Sprite:new(x,y,width,height,id, src_rect,sx,sy, spritebatch) 

function Consumable:new(x,y,width,height,id,src_rect,sx,sy,spritebatch)
    
    local c = setmetatable(Sprite:new(x,y,width,height,id,src_rect,sx,sy,spritebatch), Consumable) 

    c.pickedUp = false 


    c.itemName = "Consumable" 

    --c:setKinematics(0,100,0,100,0,0,0,0)

    c.vel.y = 25

    c.addedUI = false 
    c.labelIndex = 0 
    c.power = "None"
    c.eventPlayed = false 
    return c 

end 



function Consumable:addUI() 


    if not self.addedUI then 

        self.label = Label:new(self.x + self.width + 5,self.y+self.height/2,"Item Name: " .. self.itemName .. "\nPower: " .. self.power .. "\nPickup Key: " .. globals.gameKeys["pickup"] ,globals.currentLevel.camera,false)
        self.label:setFont(globals.am:getFont("assets/fonts/font_pixel.ttf",14),"assets/fonts/font_pixel.ttf")
        self.label.font:setFilter("nearest","nearest")
        self.label.y = (self.y+self.height/2 - (self.label.font:getHeight(self.label.text)/2))

        self.label:attachLine()
        self.label.visible = false 

        self.labelIndex = globals.currentLevel.uiManager:add(self.label)
        self.addedUI = true 
    end 
   
end 

function Consumable:pickUp(rect) 



    if GameMath.rectangleCollision(rect,self) then 
        self.pickedUp = true 
    end 
end


function Consumable:onPickup(event) 

    if self.pickedUp  and not self.eventPlayed then 
        self.eventPlayed = true
        event() 
    
    end 

end 

function Consumable:playerMouseHover(dt) 


    local mx,my = globals.currentLevel.camera:getGlobalMousePos() 

    if GameMath.pointRectCollision(self, mx,my) then 

        self.label.visible = true 
    else
        self.label.visible = false 
    end 
end 

function Consumable:updateParent(dt,event) 
    

    self:addUI()
    if not self.pickedUp then 
        self.y = GameMath.hover2(self.y,3,self.vel.y,dt) 

        self:playerMouseHover(dt)
    end 



    self:onPickup(event) 


    self:updateAnimating(dt)
    self:updateQuad(self.defaultSrcRect.x,self.defaultSrcRect.y,self.defaultSrcRect.width,self.defaultSrcRect.height)
    self:updateImgCoords()

end 

function Consumable:update(dt) 
    self:updateParent(dt,function() print("You Just Picked Me Up") end )
end 



function Consumable:draw() 

    --love.graphics.setColor(0.3,0.8, 0.7, 1.0) 
    --love.graphics.rectangle("fill",self.x,self.y,self.width,self.height) 
end 

return Consumable 