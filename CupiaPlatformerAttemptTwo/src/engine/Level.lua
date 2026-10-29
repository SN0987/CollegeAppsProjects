local Level = {} 
local EntityManager = require("engine.EntityManager")
local UIManager = require("engine.UI.UIManager")
local Camera = require("engine.Camera")
local globals = require("globals")
local TileMap= require("engine.TileMap")
local Background = require("engine.Background")
local Screen = require("game.Background.Screen")
local Mountain = require("game.Background.Mountain")
local Cloud = require("game.Background.Cloud")
Level.__index = Level 


--this works for cupia 

function Level:addOverworldBackground() 

    if self.worldTitle == "Overworld" then 

        --unction Mountain:new(img,srcRect,index,x,y,scale)

        self.background:addComponent(Screen:new(globals.am:get("Overworld-Background"), {x=0,y=38,width=63,height=38}))

        local leftMountainOffset = -12*8.5
        local darkMountainWidth = 63*8.5
        local darkMountainHeight = globals.HEIGHT-38*8.5
        self.background:addComponent(Mountain:new(globals.am:get("Overworld-Background"),{x=63*2,y=38,width=63,height=38},2,leftMountainOffset,darkMountainHeight,{x=8.5,y=8.5}))
        self.background:addComponent(Mountain:new(globals.am:get("Overworld-Background"),{x=63*2,y=38,width=63,height=38},3,leftMountainOffset+(darkMountainWidth+leftMountainOffset*2),darkMountainHeight,{x=8.5,y=8.5}))

        local shift = leftMountainOffset+(darkMountainWidth+leftMountainOffset*2)
        self.background:addComponent(Mountain:new(globals.am:get("Overworld-Background"),{x=63*2,y=38,width=63,height=38},4,shift+darkMountainWidth+leftMountainOffset*2,darkMountainHeight,{x=8.5,y=8.5}))
        local totalDarkSpan = shift+darkMountainWidth+leftMountainOffset*2
        local leftMountainOffsetTwo = -12*10
        local lightMountainWidth = 63*10
        local lightMountainHeight = globals.HEIGHT-38*10
        self.background:addComponent(Mountain:new(globals.am:get("Overworld-Background"),{x=63,y=38,width=63,height=38},5,totalDarkSpan/2-leftMountainOffsetTwo,lightMountainHeight,{x=10,y=10}))
        self.background:addComponent(Mountain:new(globals.am:get("Overworld-Background"),{x=63,y=38,width=63,height=38},6,totalDarkSpan/2-(lightMountainWidth/2),lightMountainHeight,{x=10,y=10}))

        --Cloud:new(sx,sy,spritesheet,srcY, sWidth,sHeight, index, max) 
        self.background:addComponent(Cloud:new(6,6,globals.am:get("Overworld-Background"),0,64,24,7,3))
        self.background:addComponent(Cloud:new(6,6,globals.am:get("Overworld-Background"),0,64,24,8,3))
        self.background:addComponent(Cloud:new(6,6,globals.am:get("Overworld-Background"),0,64,24,9,3))
    end 
end 

function Level:new(name,index,manager,spritesheet)
    

    --in maps file add info.lua, completed = false, spritesheet_path = "" 
    local l = setmetatable({}, Level)   

    l.index = index 
    l.lManager =  manager 
    l.worldTitle = name
    l.name = name .. tostring(l.index) 

    l.em = EntityManager:new(spritesheet) 
    l.map_dir = "src/assets/maps" .. "/" .. name .. "/" .. l.name  -- assets/maps/worldName/worldName1
    l.map = TileMap:new(l.map_dir,l.em) 
    
    
    l.background = Background:new() 

    l:addOverworldBackground()
    
    l.camera = Camera:new(0,0,globals.screenWidth,globals.screenHeight)  
    l.camera:zoom(2,2)
    l.uiManager = UIManager:new(l.camera)




    l.map:loadAllLayers() 


    
    return l 

end 

function Level:update(dt) 


    if globals.currentLevel ~= self then 
        globals.currentLevel = self 
    end 
    self.uiManager:update(dt) 
    self.background:update(dt)
    self.em:update(dt) 

    

    self.camera:update(dt)
    self.camera:follow(self.em.player.x+self.em.player.width / 2,self.em.player.y+self.em.player.height/2)
end 

function Level:draw() 


    self.camera:scaleApply() 
  
    self.background:draw()
    self.camera:unapply() 

    self.camera:apply()
    

    self.em:draw() 
    self.uiManager:draw()
    self.camera:unapply() 

    
   
end 

return Level 