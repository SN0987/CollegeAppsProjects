local Weapon = require("Game.Weapon")
local consts = require("consts")
local Sword = setmetatable({},{__index = Weapon})
local Label = require("Engine.Label")
Sword.__index = Sword



function Sword:new(x,y,em,ui_manager)
    consts.indexes.sword = consts.indexes.sword+1
    local s = setmetatable(Weapon:new(x,y,"Sword"),Sword)
    s.width = 48 
    s.height = 48
    s.em = em 
    s.ui_manager = ui_manager
    s.img = consts.AssetManager:getImage("Sword","Weapons/sword_two.png")

    s.animator:add(s.img,4,16,16,"Idle-Right",0,0)
    s.animator:add(s.img,4,16,16,"Idle",0,0)
    s.animator:add(s.img,0,16,16,"Idle-Left",0,0)   

    s.animator:add(s.img,4,16,16,"Right",15,4)
    s.animator:add(s.img,0,16,16,"Left",15,4)

    s.animator:add(s.img,5,16,16,"Down-Right",15,4)
    s.animator:add(s.img,2,16,16,"Down-Left",15,4)
    s.animator:add(s.img,3,16,16,"Up-Right",15,4)
    s.animator:add(s.img,1,16,16,"Up-Left",15,4)
    
    s.animator:setName("Idle-Right")
    s.offset.x = -25
    s.offset.y = -30
    
    s.isMouse = false 
    
    s.hitbox.x = s.x 
    s.hitbox.y = s.y 
    s.hitbox.width = 16
    s.hitbox.height = 48 

    s.health = 250 

    s.ogHealth = 250 

    s.label = Label:new(5,consts.HEIGHT-20,"Sword-Health: " .. tostring(tonumber((s.health/s.ogHealth)*100)) .. "%", 20,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},500,"Sword-Label: " .. consts.indexes.sword)
    
    s.label.show = false 
    s.ui_manager:addElement(s.label)
    
    s.cooldown = false 
    s.cooldown_time = 0.25

    
    s.cooldown_counter = 0
    s.attack_states = {}

    s.attack_states["Up-Right"] = false 
    s.attack_states["Up-Left"] = false 
    s.attack_states["Down-Right"] =false 
    s.attack_states["Down-Left"] = false
    s.attack_states["Right"] = false
    s.attack_states["Left"] = false


    return s 


end 



function Sword:attackKeys(dt,player) 
    if not self.cooldown then 
        if player.dashing.dir == "right" then 
                    

            if love.keyboard.isDown(consts.keys["Aim-Up"] ) or love.keyboard.isDown("w") then 
                self.hitbox.x = self.x 
                self.hitbox.y = self.y 
                self.hitbox.width = 48
                self.hitbox.height = 48
                self.attack_states["Up-Right"] = true 
            elseif love.keyboard.isDown(consts.keys["Aim-Down"]) or love.keyboard.isDown("s") then 
                self.attack_states["Down-Right"] = true 
                self.hitbox.x = self.x 
                self.hitbox.y = self.y + self.height - 10
                self.hitbox.width = 48
                self.hitbox.height = 48
            else
                self.attack_states["Right"] = true 
                self.hitbox.x = self.x + self.width - 10
                self.hitbox.y = self.y 
                self.hitbox.width = 48
                self.hitbox.height = 48
            end 


     
        end 

        if player.dashing.dir == "left" then 
            if love.keyboard.isDown(consts.keys["Aim-Up"] ) or love.keyboard.isDown("w") then 
                self.hitbox.x = self.x 
                self.hitbox.y = self.y 
                self.hitbox.width = 48
                self.hitbox.height = 48
                self.attack_states["Up-Left"] = true 
            elseif love.keyboard.isDown(consts.keys["Aim-Down"]) or love.keyboard.isDown("s") then 
                self.attack_states["Down-Left"] = true 
                self.hitbox.x = self.x 
                self.hitbox.y = self.y + self.height - 10
                self.hitbox.width = 48
                self.hitbox.height = 48
            else
                self.attack_states["Left"] = true 
                self.hitbox.x = self.x 
                self.hitbox.y = self.y 
                self.hitbox.width = 48
                self.hitbox.height = 48
            end 

        end 


        if player.dashing.dir ~= "left" or player.dashing.dir ~= "right" then 
            self.attack_states["Right"] = true 
            self.hitbox.x = self.x + self.width - 10
            self.hitbox.y = self.y 
            self.hitbox.width = 48
            self.hitbox.height = 48
        end 
        self.cooldown = true 

        self.attackBool = true 
    end 
end 

function Sword:statesUpdate(dt,player) 
    if self.cooldown then 

        local currentState 

        for k,v in pairs(self.attack_states) do 
           
            if v then 
                currentState = k
                break 
            end 
        end 

        
        self.animator:setName(currentState)

        self.cooldown_counter = self.cooldown_counter + dt 

        if self.cooldown_counter >= self.cooldown_time then 
            self.cooldown =false 
            self.attack_states[currentState] = false
            self.cooldown_counter = 0 
        end 
        
    end 

    if not self.cooldown then 
        if player.dashing.dir == "Right" then 
        
            self.animator:setName("Idle-Right")
        elseif player.dashing.dir == "left" then 
            self.animator:setName("Idle-Left")
        else
            self.animator:setName("Idle")
        end 

        self.attackBool = false 
        
    end 
end 

function Sword:update(dt,camera)


    local isAttackKeyPressed = love.keyboard.isDown(consts.keys["Sword-Attack"])

    local label = self.ui_manager:getElements(self.label.name)[1]
    if self.pickedUp and consts.player.equipment == self then 
        label.show = true 
        label:setText(5,consts.HEIGHT-20,"Sword-Health: " .. tostring(tonumber((self.health/self.ogHealth)*100)) .. "%",20,{r=1,g=1,b=1},"assets/fonts/font_pixel.ttf")
        if not self.attackBool then 
            if consts.player.dashing.dir == "right" then 
                self.offset.x = -10
                self.offset.y = -30
            elseif consts.player.dashing.dir == "left" then 
                self.offset.x = -40
                self.offset.y = -30
            end 
        end 




        if isAttackKeyPressed and not self.attackKey then 

            self:attackKeys(dt,consts.player)
                
            
        end 
        self.attackKey = isAttackKeyPressed
        
        local isMouse = love.mouse.isDown(1)
        
        if isMouse and not self.isMouse then 
            self:attackKeys(dt,consts.player)
            
        end 

        self.isMouse = isMouse     
        self:statesUpdate(dt,consts.player)
        self:parentUpdate(dt)
      
    else 
        label.show = false 
    end 
  
    self.animator:update(dt)

    
    if self.health <= 0 then 
        self.ui_manager:removeAllElementsByName(self.label.name) 
    end 

    --self:mouseInfo(self.x,self.y, "Sword: Press: " .. consts.keys["Pick-Up"],camera)

  
    
end 


function Sword:draw(camera) 
   

    self.animator:draw(self.img,self.x,self.y,3,3)
       
end

 
return Sword