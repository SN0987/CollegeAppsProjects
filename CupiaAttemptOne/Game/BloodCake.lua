local Enemy = require("Game.Enemy")
local BloodCake = setmetatable({},{__index=Enemy})
local Element = require("Engine.Element")
local Label = require("Engine.Label")
BloodCake.__index = BloodCake
local consts = require("consts")

function BloodCake:new(x,y,em,ui_manager) 
    local b = setmetatable(Enemy:new(x,y,32,32,"BloodCake",em),BloodCake)

    consts.indexes.BloodCake = consts.indexes.BloodCake + 1 
    b.speedX = -150 
    b.state = "Move-Left"
    b.reach.x = 150
    b.reach.y = 150 

    b.speedX = -50
    b.ui_manager = ui_manager
    b.state_times.attack = 3
    b.state_counters.attack = 0

    b.state_times.flash = 0.3
    b.state_counters.flash = 0 

    b.hitbox.x = b.x 
    b.hitbox.y = b.y 
    b.hitbox.width = b.width  +25
    b.hitbox.height = b.height + 25
    b.img = consts.AssetManager:getImage("BloodCake","Enemies/bleeding_cupcake.png")
    b.animator:add(b.img,0,16,16,"Bleeding",6,4)
    b.animator:add(b.img,0,16,16,"Not-Bleeding",0,0)
    
    b.animator:setName("Bleeding")
    b.img_dst_rect.x = b.x 
    b.img_dst_rect.y = b.y

    b.flash = false 

    b.flashRect = {
        width = 350,
        height = 350,
        x = 0,
        y = 0
    }

    b.flashRect.x = consts.WIDTH/2-b.flashRect.width/2
    b.flashRect.y = consts.HEIGHT/2-b.flashRect.height/2

    --function Label:new(x,y,text,size,font_path,color,max_bound,name) 
    --function Label:addImage(img,quad,x,y,width,height) 
    --label
    b.label = Label:new(b.flashRect.x,b.flashRect.y,"",1,nil,{r=1,g=1,b=1},nil,"BloodCake: " .. consts.indexes.BloodCake)
    b.label:addImage(b.img,love.graphics.newQuad(0,0,16,16,b.img:getWidth(),b.img:getHeight()),b.flashRect.x,b.flashRect.y,b.flashRect.width,b.flashRect.height)
    b.label.show = false 
    b.ui_manager:addElement(b.label)

    b.onceFlashed = false 

    b.health = 5
    return b
end 


function BloodCake:update(dt,camera) 

    self.speedX = self:MoveHorizontally(dt,self.speedX) 


    self.vel.x = self.speedX 

    local player = self.em:getEntity("Player") 


    local label = self.ui_manager:getElements(self.label.name)[1]
    if self:withInPlayerDistance() then 
        if self.flash == false and not self.onceFlashed then 

            self.onceFlashed = true 
            self.flash = true  
        end 

    end     

    if self.flash then 

        label.show = true 
        self.state_counters.attack = self.state_counters.attack + dt 

        if self.state_counters.attack >= self.state_times.attack then 
            self.flash = false 
        end 

        self.state_counters.flash = self.state_counters.flash + dt 
        if self.state_counters.flash >= self.state_times.flash then 
            self.state_counters.flash = 0 
        end 
    else 
        label.show = false 
    end 


    if self.delete or self.health <= 0 then 
        label.show = false 
        self.ui_manager:removeAllElementsByName(self.label.name)
    end 

   
    self:onHit(dt,player.equipment,camera)
    self:collideWithPlayer(player) 
    

    self.hitbox.x = self.x 
    self.hitbox.y = self.y 

    self.animator:update(dt)
    
end 

function BloodCake:draw()

    local scaleX = self.width/16
    local scaleY = self.height/16
    self.hurt:apply()   

    self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
    self.hurt:unapply()

end 


return BloodCake 