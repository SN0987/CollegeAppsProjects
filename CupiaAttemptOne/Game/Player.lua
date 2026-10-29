local Sprite = require("Game.Sprite")
local consts = require("consts")
local Player = setmetatable({},{__index=Sprite})
local Particle = require("Engine.Particle")
local Hurt = require("Engine.Hurt")
local Label = require("Engine.Label")
Player.__index = Player


function Player:new(x,y,ui_manager)
    local player = setmetatable(Sprite:new(x,y,32,32,"Player","dynamic"),Player)
    
    player.speedX = 50
    player.resetSpeedX = 50
    player.accel.x = 250
    player.maxSpeed = 250
    
    player.dashing = {
        timer = 0,
        coolDown = 2,
        dash = false,
        dir = "right"
    }
    
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),0,16,16,"Original-Idle",2,2)
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),1,16,16,"Original-Idle-Left",2,2)
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),3,16,16,"Original-Right",8,4)
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),2,16,16,"Original-Left",8,4)
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),5,16,16,"Original-JR",6,6) --jump right 
    player.animator:add(consts.AssetManager:getImage("Player-Original","Player/og.png"),4,16,16,"Original-JL",6,6) -- jump left
    player.animator:setName("Original-Idle")

    player.img_dst_rect.width = 32
    player.img_dst_rect.height = 32 
    player.width = 32
    player.height = 32
    player.jumping.jump_time = 0.4
    player.jumping.speed = 160

    player.scrollSpeed = player.speedX-50
    player.camera = nil
    player.hitbox.width = 20
    player.hitbox.height = 20
    player.leftDust = Particle:new("sparks", 
    {color={r=0.9,g=0.9,b=0.9},use_image=false, size={minSize=2,maxSize=8},shape="circle",position={player.x+player.width,player.y+player.height},speed={minX=250,maxX=650,minY=0,maxY=0},times={minLifeTime=0.01,maxLifeTime=0.013,minSpawnRate=0.001,maxSpawnRate=0.003}})

    player.rightDust = Particle:new("sparks", 
    {color={r=0.9,g=0.9,b=0.9},use_image=false, size={minSize=2,maxSize=8},shape="circle",position={player.x,player.y+player.height},speed={minX=-150,maxX=50,minY=0,maxY=0},times={minLifeTime=0.01,maxLifeTime=0.013,minSpawnRate=0.001,maxSpawnRate=0.003}})

    player.downDust = Particle:new("sparks", 
    {color={r=0.9,g=0.9,b=0.9},use_image=false, size={minSize=2,maxSize=7},shape="circle",position={player.x+player.width,player.y},speed={minX=0,maxX=0,minY=-150,maxY=50},times={minLifeTime=0.01,maxLifeTime=0.013,minSpawnRate=0.001,maxSpawnRate=0.003}})


    player.upDust = Particle:new("sparks", 
    {color={r=0.9,g=0.9,b=0.9},use_image=false, size={minSize=2,maxSize=8},shape="circle",position={player.x+player.width,player.y},speed={minX=0,maxX=0,minY=50,maxY=150},times={minLifeTime=0.01,maxLifeTime=0.013,minSpawnRate=0.001,maxSpawnRate=0.003}})

    player.dashBurst = Particle:new("burst", 
    {burst_now = false, center={x=self.x,y=self.y},use_image=false,color={r=0.8,g=0.8,b=0.8},amount=60,radius=5,lifetime=0.1,size={minSize=10,maxSize=20},shape="circle",speed_vec={x=150,y=150}}
)
    player.leftDust.add = false 
    player.rightDust.add = false 
    player.upDust.add = false 
    player.downDust.add = false 
    player.ui_manager = ui_manager

    player.equipment = nil
    player.equipped = false 
    player.maxArmor = 6 
    player.originalJumpSpeed = 160 

    local totalWidth = player.maxArmor * (25+4)-4
    local startX = consts.WIDTH/2-totalWidth/2 
    for i = 1, player.maxArmor do 

        local lx = startX+((i-1)*25+4)
        local ly = consts.HEIGHT-34
        local l = Label:new(0, 0, "", 25, nil, {r = 1, g = 1, b = 1}, 550, "Player-Heart")
        l:addImage(consts.AssetManager:getImage("heart", "ui/heart.png"), nil, lx, ly, 25, 25)
        player.ui_manager:addElement(l)
    end 

    player.armor = 0
   
    player.hurt = Hurt:new(0.3,"assets/shaders/hurt.glsl")
   
    player:gainArmor(1)

    player.isArmor = false 
    player.equippedArmor = nil 

    player.bossClear = false 
    return player 
end 

function Player:resetSpeed() 

    
 
    self.jumping.speed = 160 
    self.speedX = 50 
    self.resetSpeedX = 50 
    self.maxSpeed = 250 
    self.accel.x = 250 
  
  
   
    
  
end 

function Player:pickUpStuff(dt,stuff)
   
   
end 

function Player:beHurt() 
    if self.isArmor and self.equippedArmor ~= nil then 
        self.equippedArmor.availableArmor = self.equippedArmor.availableArmor - 1
    end 

    self.hurt.isHurt = true 
    self:removeArmor(1)
end 
function Player:gainArmor(amount)
    --[[self.ui_manager:removeAllElementsByName("Player-Heart")
    local newTotalArmor = self.armor + amount
    local heartWidth = 25
    local spacing = 4 -- space between hearts
    local totalWidth = newTotalArmor * (heartWidth + spacing) - spacing

    local startX = (consts.WIDTH / 2) - (totalWidth / 2)
    local y = consts.HEIGHT - 34

    for i = 1, newTotalArmor do 
        local x = startX + (i - 1) * (heartWidth + spacing)

        local l = Label:new(0, 0, "", 25, nil, {r = 1, g = 1, b = 1}, 550, "Player-Heart")
        l:addImage(consts.AssetManager:getImage("heart", "ui/heart.png"), nil, x, y, heartWidth, heartWidth)
        self.ui_manager:addElement(l)
    end

    self.armor = newTotalArmor]]

    self.armor = self.armor + amount

    local hearts = self.ui_manager:getElements("Player-Heart")


    local totalWidth = self.armor*(25+4)-4
    local startX = consts.WIDTH/2-totalWidth/2 

    for k,v in ipairs(hearts) do 
        if k <= self.armor then 

            v.position.x = startX+(k-1)*(25+4)

            v.show = true
        else
            v.show = false 
        end 
    end 

  
end 


function Player:removeArmor(amount) 
    
    self:gainArmor(-amount)
  
    
end 
function Player:movementX(dt) 

    if self.speedX >= self.maxSpeed then 
        self.speedX = self.maxSpeed
    end 

    if self.equipped == false then 
        self.equipment = nil 
    end 
    if love.keyboard.isDown(consts.keys["Move-Left"]) or love.keyboard.isDown("left") then 
        --self.speedX = self.speedX + self.accel.x 
        self.speedX = self.speedX+self.accel.x * dt
        self.camera.x = self.camera.x - self.scrollSpeed * dt
        self.vel.x = -self.speedX 
        self.dashing.dir = "left"
        self.leftDust.add = true 
        self.rightDust.add = false

        if not self.jumping.bool then 
            self.animator:setName("Original-Left")
        end 
    
      
    elseif love.keyboard.isDown(consts.keys["Move-Right"]) or love.keyboard.isDown("right") then 
        self.speedX = self.speedX+self.accel.x * dt
        self.vel.x = self.speedX 
        self.camera.x = self.camera.x + self.scrollSpeed * dt
        self.dashing.dir = "right"
        if not self.jumping.bool then 
            self.animator:setName("Original-Right")
        end 

        self.rightDust.add = true 
        self.leftDust.add = false 
        
        --self.speedX = self.speedX + self.accel.x 
        
    else
        self.vel.x = 0
        self.speedX = self.resetSpeedX 
        if not self.jumping.bool then
            self:directionalAnimation(self.dashing.dir,"Original-Idle-Left","Original-Idle")
            
        end 

        self.leftDust.add = false
        self.rightDust.add = false 
   
        
    
    end

    if love.keyboard.isDown(consts.keys["Dash"]) then 
        if self.dashing.dash == false then
            
            self.dashing.dash = true 
            
            if self.dashing.dir == "right" then
                self.dashBurst.type_args.center.x = (self.x+self.width)
                self.dashBurst.type_args.center.y = self.y+(self.height/2)
                self.dashBurst.type_args.burst_now = true

                self.vel.x = 8000 
            elseif self.dashing.dir == "left" then 
                self.dashBurst.type_args.center.x = (self.x-16) 
                self.dashBurst.type_args.center.y = self.y+(self.height/2)
                self.dashBurst.type_args.burst_now = true
                self.vel.x = -8000 
            end
        end
    end 


    if self.dashing.dash then
        
        self.dashing.timer = self.dashing.timer + dt 

        if self.dashing.timer >= self.dashing.coolDown then 

            self.dashing.dash = false 
            self.dashing.timer = 0
        end 
    end
end 

function Player:movementY(dt) 
    if  love.keyboard.isDown(consts.keys["Jump"]) or love.keyboard.isDown("up") or love.keyboard.isDown("space") then

     
        self:jump()   
  
    end

    if self.jumping.bool then 
        self:directionalAnimation(self.dashing.dir,"Original-JL","Original-JR")
    end 
end 




function Player:update(dt,camera) 
    self.camera = camera 
    self.camera:follow(self.x,self.y)
    self:movementX(dt)
    self:movementY(dt)

    self.img_dst_rect.x = self.x 
    self.img_dst_rect.y = self.y +5
    self.hitbox.x = self.x + 6
    self.hitbox.y = self.y + 10
 
    self.animator:update(dt)
    self:updateParticles(dt,self.leftDust,self.rightDust,self.upDust,self.downDust,camera)
 
    self.dashBurst:update(dt)
    
    if self.y >= consts.HEIGHT then 
        self.delete = true 

    end 

    if self.armor <= 0 then 
        self.delete = true 
    end 

    self.hurt:update(dt)

    self:mouseInfo(self.x,self.y,"Cupia - The Player",camera)
end 



function Player:draw(camera) 

    --self:mouseInfo(self.x,self.y,"Cupia - The Player")
    local scaleX = self.img_dst_rect.width/16
    local scaleY = self.img_dst_rect.height/16

    --[[love.graphics.setColor(0,0,1.0,1.0)
    love.graphics.rectangle("fill",self.hitbox.x+camera.x,self.hitbox.y+camera.y,self.hitbox.w,self.hitbox.h)]]

    
    if self.infoText ~= nil then 
        self.infoText:draw()
    end 
    
    self.hurt:apply()
    self.animator:draw(consts.AssetManager:getImage("Player-Original",nil),self.img_dst_rect.x,self.img_dst_rect.y,scaleX,scaleY)
    self.hurt:unapply()
    self:drawParticles(self.leftDust,self.rightDust,self.upDust,self.downDust)
    self.dashBurst:draw()
 
end 

return Player 