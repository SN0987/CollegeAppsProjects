local Entity = require("Engine.Entity")
local AssetManager = require("Engine.AssetManager")
local Sprite = setmetatable({},{__index=Entity})
local Animator = require("Engine.Animator")
local InfoText = require("Engine.InfoText")
Sprite.__index = Sprite 


--default sprite class for AI/Player

function Sprite:new(x,y,width,height,id,col_status)
    local s = setmetatable(Entity:new(x,y,width,height,id,col_status,{draw=true,color={r=255,g=0,b=0}}),Sprite)

    --acceleration 
    s.accel = {
        x=0,
        y=0
    }

    s.ui_manager = nil 

    s.health = 100 --default health 
    s.isAlive = true -- default alive status 
    s.state = "idle"
    s.animator = Animator:new()
    s.hitbox = {
        x = 0,
        y = 0,
        width = 0,
        height = 0
    }

    s.img_dst_rect = {
        x = x,
        y=y,
        width=16,
        height=16,
    }

    s.infoText = nil 

    
    return s  
end 


function Sprite:mouseInfo(x,y,text,camera)
     
    local mx, my = camera:globalMousePos()

    if self.infoText == nil then 
        --InfoText:new(x,y,text,size,font_path,box,box_color,font_color,img,animate,name) 

        self.infoText = InfoText:new(x,y,text,15,"underline",{r=1,g=1,b=1},{r=1,g=1,b=1},nil,false,"InfoText: " .. self.id)
    end 
   
    if mx >= self.x and mx <= self.x + self.width and
    my >= self.y and my <= self.y + self.height then
       
        self.infoText.show = true
    else 
        self.infoText.show = false 
    end 


    -- Draw only if visible
    
end 



function Sprite:hitBoxOverlap(o)
    return self.hitbox.x < o.hitbox.x+o.hitbox.width and self.hitbox.x+self.hitbox.width > o.hitbox.x and self.hitbox.y < o.hitbox.y+o.hitbox.height and self.hitbox.y + self.hitbox.height > o.hitbox.y 
end 
function Sprite:updateParticles(dt,leftDust,rightDust, upDust, downDust,camera) 
    if leftDust ~= nil then 
        leftDust.type_args.position.y = (self.y+self.height -10) 
        leftDust.type_args.position.x = (self.x+self.width) 
        leftDust:update(dt)
    end 
   
    if rightDust ~= nil then 
        rightDust.type_args.position.y = (self.y+self.height -10) 
        rightDust.type_args.position.x = self.x
        
        rightDust:update(dt)
    end 
   


    if upDust ~= nil then
        upDust.type_args.position.y = self.y+self.height 
        upDust.type_args.position.x = self.x+(self.width/2) 
        upDust:update(dt)
    end 
  

    if downDust ~= nil then 
        downDust.type_args.position.y = self.y - 5
        downDust.type_args.position.x = self.x+(self.width/2) 
          
        downDust:update(dt)
    end 







end 

function Sprite:drawParticles(leftDust,rightDust, upDust, downDust) 

    if leftDust ~= nil then 
        leftDust:draw()
    end 

    if rightDust ~= nil then 
        rightDust:draw()
    end 

    if upDust ~= nil then 
        upDust:draw()
    end 

    if downDust ~= nil then 
        downDust:draw()
    end 
   



  

end 

--changes animation according to direction
function Sprite:directionalAnimation(currentDir,leftName,rightName)
    
    if currentDir == "right" then 
        self.animator:setName(rightName)
    elseif currentDir == "left" then 
        self.animator:setName(leftName)
    end 

end 

function Sprite:clampX(min,max ) 
    if self.x <= min then
        
        self.x = min 
    elseif self.x >= max then 
        self.x = max
    end
end 

function Sprite:clampY(min,max) 
    if self.y <= min then
        
        self.y = min 
    elseif self.x >= max then 
        self.y = max
    end
end 

function Sprite:update(dt,camera) 

end 


function Sprite:draw(camera) 

end 




return Sprite  