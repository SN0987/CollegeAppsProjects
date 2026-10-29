
local Sprite = require("Game.Sprite")

local Flag = setmetatable({},{__index=Sprite})
local consts = require("consts")
local Label = require("Engine.Label")
local Particle = require("Engine.Particle")
Flag.__index = Flag 


function Flag:new(x,y,counter,ui_manager) 
    local f = setmetatable(Sprite:new(x,y,128,64,"Flag","none"),Flag)



    f.counter = counter 
    f.ui_manager = ui_manager

  

    f.level = nil 

    

    f.hitbox.x = f.x
    f.hitbox.y = f.y 
    f.hitbox.width = 32
    f.hitbox.height = f.height
    

    f.img = consts.AssetManager:getImage("Flag","Overworld/flag.png")

    f.animator:add(f.img,0,16,32,"Cleared",8,4)
    f.animator:add(f.img,1,16,32,"Uncleared",8,4)

    f.cleared = false 
    f.animator:setName("Uncleared")
    if consts.game_world_data.overworld_levels_cleared < f.counter then 
        f.cleared = false 
        f.animator:setName("Uncleared")
    
    else
        f.cleared = true 
        f.animator:setName("Cleared")
    end 
    f.clearedLabel = Label:new(0,0,"Cleared!",60,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},nil,"Cleared-Label")
    f.clearedLabel:centerX()
    f.clearedLabel:centerY()
    f.clearedLabel.show = false 

    f.ui_manager:addElement(f.clearedLabel)
    f.clearTime = 3 
    f.clearCounter = 0
    f.burst = Particle:new("burst", 
        {burst_now = false , center={x=consts.WIDTH/2-7,y=consts.HEIGHT/2-7},use_image=false,color={r=0.8,g=0.8,b=0.8},amount=60,radius=35,lifetime=3,size={minSize=15,maxSize=15},shape="circle",speed_vec={x=150,y=150}})
    
    f.playClear = false 

    return f
end 

function Flag:setLevel(level)
 
    self.level = level 
  
end 


function Flag:levelCleared() 

    if not self.playClear then 
        local clearedLabel = self.ui_manager:getSingleElement("Cleared-Label")
        clearedLabel.show = true
        self.playClear = true 
        self.burst.type_args.burst_now = true 
        self.level:pause(self.clearTime)
    end 
   
    

end 
function Flag:update(dt,camera) 


    if not self.cleared then 
        self.animator:setName("Uncleared")
        if consts.player:hitBoxOverlap(self) and not consts.player.bossClear then 
            self.cleared = true 
            consts.game_world_data.overworld_levels_cleared = consts.game_world_data.overworld_levels_cleared+1
            


            self:levelCleared()
        end 
    end 

    if self.cleared then 

        self.animator:setName("Cleared")
        if consts.player:hitBoxOverlap(self) and not consts.player.bossClear then 
           self:levelCleared()
        end 

        
    end 

    if self.playClear then 
        self.clearCounter = self.clearCounter + dt 

        if self.clearCounter >= self.clearTime then 

            self.level:replaced()
        end 
    end 

    
    self.animator:update(dt)
    self.burst:update(dt)
end 

function Flag:draw() 

    
    self.animator:draw(self.img,self.x,self.y,4,4)
    self.burst:draw()

end 


return Flag 