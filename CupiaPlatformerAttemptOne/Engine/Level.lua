
local Map = require("Engine.Map")
local EntityManager = require("Engine.EntityManager")
local consts = require("consts")
local Camera = require("Engine.Camera")
local Background = require("Game.Background")
local Particle = require("Engine.Particle")

local tilekeys = require("Game.tilekeys")
local EquipmentManager = require("Game.EquipmentManager")
local UIManager = require("Engine.UI_Manager")
local Label = require("Engine.Label")
local Level = {}
Level.__index = Level 




function Level:new(name,map_file_name,type_world,level_manager,counter,main_game_args)
    local l = setmetatable({},Level)
    l.name = name 
    l.map_file_name = map_file_name 
    l.counter = counter 
    l.main_game_args = main_game_args
    l.starting = {
        time = 1, 
        counter = 0,
        burst = Particle:new("burst", 
        {burst_now = true , center={x=consts.WIDTH/2-5,y=consts.HEIGHT/2-5},use_image=false,color={r=0.8,g=0.8,b=0.8},amount=120,radius=25,lifetime=2,size={minSize=10,maxSize=10},shape="circle",speed_vec={x=250,y=250}})
    }

    local label = Label:new(0,0,name,50,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},consts.WIDTH,"Start: " .. name)
    label.font_position.x = consts.WIDTH/2-label.font:getWidth(l.name)/2
    label.font_position.y = consts.HEIGHT/2-label.font:getHeight(l.name)/2

    local labelTwo = Label:new(20,20,"Level: " ..l.counter .. "/30" ,20,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},consts.WIDTH,"Level-Counter: " .. l.counter)
    local labelThree = Label:new(20,45,"FPS: " .. love.timer.getFPS() ,20,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},consts.WIDTH,"FPS")
    l.ui_manager = UIManager:new()
    l.ui_manager:addElement(label)
    l.ui_manager:addElement(labelTwo)
    l.ui_manager:addElement(labelThree)
    l.state = "Play"
    l.type_world = type_world 
    l.pause_table = {
        pause = false, 
        time = 0,
        howLong = 0,
    } 

    l.level_manager = level_manager
  
   
    l.entityManager = EntityManager:new()

    l.tile_key = nil
    
    if l.type_world == "Overworld" then 
         
        l.tile_key = tilekeys.overworld
    end 

    if l.type_world == "Underworld" then 
        l.tile_key = tilekeys.underworld
    end 
   
    
   
    l.map = Map:new(map_file_name,(consts.WIDTH/consts.TILE_SIZE)*5,consts.HEIGHT/consts.TILE_SIZE)
    l.map:addTileSet(l.tile_key,l.entityManager)
   
   
    l.map:addEntity(l.entityManager,l,l.ui_manager,l.counter)
    l.bg = Background:new()


    l.crosshair_img = consts.AssetManager:getImage("Crosshair","Weapons/crosshair.png")


    if l.type_world == "Overworld" then 
        l.bg:addLayer("Layer1",{
        x = 0, y = 0, scaleX = consts.WIDTH/40, scaleY = consts.HEIGHT/24, renderOrder = 0 ,img = consts.AssetManager:getImage("Overworld-Sky","Overworld/overworld.png")

        })

        
        l.bg:addLayer("Layer2",{
            x = love.math.random(0,consts.HEIGHT), y = love.math.random(-160,0), scaleX = 10, scaleY = 10, renderOrder = 1 ,img = consts.AssetManager:getImage("Overworld-Clouds","Overworld/clouds_two.png"), be_quad=true, quad=love.graphics.newQuad(0,0,16,16,48,16),scroll = true, scrollSpeed = love.math.random(20,100)

        })

        l.bg:addLayer("Layer3",{
            x = love.math.random(0,consts.WIDTH), y = love.math.random(-160,0), scaleX = 10, scaleY = 10, renderOrder = 2 ,img = consts.AssetManager:getImage("Overworld-Clouds","Overworld/clouds_two.png"), be_quad=true, quad=love.graphics.newQuad(16,0,16,16,48,16),scroll = true, scrollSpeed = love.math.random(20,100)

        })

        
        l.bg:addLayer("Layer4",{
            x = love.math.random(0,consts.WIDTH), y = love.math.random(-50,0), scaleX = 10, scaleY = 10, renderOrder = 3 ,img = consts.AssetManager:getImage("Overworld-Clouds-Two","Overworld/clouds.png"), be_quad=true, quad=love.graphics.newQuad(0,0,16,16,48,16),scroll = true, scrollSpeed = love.math.random(20,100)

        })
        
        l.bg:addLayer("Layer5",{
            x = love.math.random(0,consts.WIDTH), y = love.math.random(-50,0), scaleX = 10, scaleY = 10, renderOrder = 4 ,img = consts.AssetManager:getImage("Overworld-Clouds-Two","Overworld/clouds.png"), be_quad=true, quad=love.graphics.newQuad(16,0,16,16,48,16),scroll = true, scrollSpeed = love.math.random(20,100)

        })

    end 
 
    local underworld_img = consts.AssetManager:getImage("Underworld-Tilesheet","Underworld/tilesheet.png")
    l.snows = {}
    if l.type_world == "Overworld" then
        local s = Particle:new("snow"
        
        , {amount = 30, use_image = true, img = underworld_img, img_quad = love.graphics.newQuad(0*16,5*16,16,16,underworld_img:getWidth(),underworld_img:getHeight())}
        )   
        local s_two = Particle:new("snow"
        
        , {amount = 25, use_image = true, img = underworld_img, img_quad = love.graphics.newQuad(3*16,5*16,16,16,underworld_img:getWidth(),underworld_img:getHeight())}
        )  
        table.insert(l.snows, s)
        table.insert(l.snows,s_two)
        
    end
    
  
    if l.type_world == "Underworld" then 
   
    

        for i = 0, 3 do 
            local s = Particle:new("snow"
        
        , {amount = 15, use_image = true, img = underworld_img, img_quad = love.graphics.newQuad(i*16,5*16,16,16,underworld_img:getWidth(),underworld_img:getHeight())}
        )          
            table.insert(l.snows, s)
        end 
       

   

        l.bg:addLayer("Layer1",{
        x = 0, y = 0, scaleX = consts.WIDTH/40, scaleY = consts.HEIGHT/24, renderOrder = 0 ,img = consts.AssetManager:getImage("Underworld-Sky","Underworld/underworld_Bg.png")

        })
    end 


    l.camera = Camera:new(0,0,consts.WIDTH,consts.HEIGHT)

  
    return l
end 


function Level:pause(time) 
    
    if self.pause_table.pause == false then 
        self.pause_table.pause = true 
        self.pause_table.howLong = time 
        self.pause_table.time = 0
    end     

    
end 

function Level:setGameArgs(game_args) 
    self.main_game_args = game_args 
end 


function Level:replaced() 
    self.level_manager.state = "selection"
    self.level_manager:replace(self.counter,Level:new(self.name,self.map_file_name,self.type_world,self.level_manager,self.counter,self.main_game_args))
end 

function Level:update(dt) 

    consts.player = self.entityManager:getEntity("Player")
    
    local flag = self.entityManager:getEntity("Flag")
     
    flag:setLevel(self)

 
    flag:update(dt)

    self.starting.counter = self.starting.counter + dt

    self.camera:update(dt)
    --Element:setText(x,y, string_text, size, color, font_path)
    local fpsLabel = self.ui_manager:getElements("FPS")[1]
    fpsLabel:setText(fpsLabel.font_position.x,fpsLabel.font_position.y,"FPS: " .. love.timer.getFPS(),20,{r=1,g=1,b=1},"assets/fonts/font_pixel.ttf")
   
    if self.starting.counter >= self.starting.time then 

        if love.keyboard.isDown("1") then 
            self.camera:move(dt,{x=-150,y=0})
        elseif love.keyboard.isDown("2") then 
            self.camera:move(dt,{x=150,y=0})
        end 
        local label = self.ui_manager:getSingleElement("Start: " .. self.name)
        label.show = false 
        self.starting.burst.burst_now = false 
        if self.pause_table.pause ~= true then 
              
            for k,v in ipairs(self.snows) do 
                v:update(dt)
            end 
  
            self.bg:update(dt)
            self.entityManager:update(dt,self.camera,self.ui_manager)
            self.map:update(dt,self.camera)
            self.ui_manager:update(dt,self.main_game_args.scaleCamera)
            local em = self.entityManager:getEntity("EquipmentManager")
            local player = self.entityManager:getEntity("Player")
            if em ~= nil then 
                em.entityManager = self.entityManager
                
            end 


            if player.delete then 
                self:replaced()
            end 
            

            --[[local Sword = self.entityManager:getEntity("Sword")
            Sword.pickedUp = true
            Sword.center.x = player.x + 12
            Sword.center.y = player.y - 30]]
            
        end 

        if self.pause_table.pause then 
            self.pause_table.time = self.pause_table.time + dt 

            if self.pause_table.time >= self.pause_table.howLong then 
                self.pause_table.pause = false 
                self.pause_table.time = 0
            end 
        end 
    end 
   
    self.starting.burst:update(dt)
    

    self.camera:clampX(0,(consts.WORLD_WIDTH-consts.WIDTH))
    self.camera:clampY(0,consts.HEIGHT)
   
end 

function Level:draw() 
    
    
  
    self.bg:draw(self.camera)
   
    self.camera:apply()
    self.starting.burst:draw()
    self.entityManager:draw(self.camera)
    self.map:draw(self.camera)
    self.camera:unapply()
    self.ui_manager:draw()

  
   
    for k,v in ipairs(self.snows) do 
        v:draw()
    end 
    
    

end 








return Level 