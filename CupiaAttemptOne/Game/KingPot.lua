local Boss = require("Game.Boss")
local consts =require("consts")
local Projectiles = require("Game.Projectiles")
local KingPot = setmetatable({},{__index=Boss})
KingPot.__index = KingPot 


function KingPot:new(x,y,em) 
    local k = setmetatable(Boss:new(x,y,128,128,"KingPot",em),KingPot)
    k.health = 500

    k.hitbox.width = 84
    k.hitbox.height = 84 
    k.hitbox.x = k.x 
    k.hitbox.y = k.y 
    k.state = "Move-Left"
    
    k.originalPos.y = -k.height
    k.speedX = -50

    k.attackSquare = {
        x = k.x,
        y = k.y,
        width = 450,
        height = 450,
        id = "attackSquare"
    }

    k.state_times.attack = 1
    k.state_counters.attack = 0


    k.angle = 0 
    k.angleTwo = 0
    k.speed = 150
    k.cos = 0 

    k.cosTwo = 0
    k.sin = 0

    k.jumping.speed = 380 

    k.returnPos = {
        x = k.x, 
        y = k.y
    }

    k.img = consts.AssetManager:getImage("KingPot","Enemies/kingpot.png")


    
    k.animator:add(k.img,4,32,32,"KingPot-Moving-Right",12,4)
    k.animator:add(k.img,3,32,32,"KingPot-Moving-Left",12,4)
    k.animator:add(k.img,2,32,32,"KingPot-Attack-Left",15,4)
    k.animator:add(k.img,1,32,32,"KingPot-Attack-Right",15,4)
    k.respawnQuad = love.graphics.newQuad(32,5*32,32,32,k.img:getWidth(),k.img:getHeight())

    k.animator:setName("KingPot-Moving-Left")

    k.projectiles = Projectiles:new(k.x,k.y,32,32,{r=0.02,g=0.65,b=0.01},"KingPot-Projectiles",{img=consts.AssetManager:getImage("KingPot-Projectile","projectiles/kingpot_projectile.png"),animate=false,quad=nil})
    k.projectiles.em = k.em
    k.projectiles.maxDistance.x = 250
    k.projectiles.maxDistance.y = 250

    k.add = false 
    k.collidedWithPlayer = k.projectiles:detectCollison("Player")
    

    return k    
end 


function KingPot:update(dt,camera)





    
    if self:withInPlayerDistance() then 
        
        if self.state == "Attack"  then 
            self.cooldown = true 

            if self.vel.x < 0 then 
                self.animator:setName("KingPot-Attack-Left")
            elseif self.vel.x > 0 then 
                self.animator:setName("KingPot-Attack-Right")
            end 
            

            if not self.add then 

                

                for i = 1, 6 do 
                    local x = self.x+self.width
                    local speed = {
                        x=love.math.random(-350,350),
                        y=love.math.random(150,350)
                    }
                    self.projectiles:settingsWithAmount(x,self.y-32,speed
                 
                ,1,{
                x=x,y=self.y-32, width=24,height=24,offsetX = 0,offsetY = 0
            })
                end 
            
            
                self.add = true 
            end 
            

            
        
            self.vel.x = self.cos*self.speed
            self:jump()
            
            if not self.is_grounded then 
                self.shakeTable.counter = 0
            end 
        
            self.state_counters.attack = self.state_counters.attack + dt
            if self.state_counters.attack >= self.state_times.attack then 

                
                self:setMovingState()
            
                self.state_counters.attack = 0
            end 
        end     

    end 
    


    if self.projectiles:detectCollisionWithRect(consts.player.hitbox) and not self.collidedWithPlayer then 
        if consts.player.isArmor and consts.player.equippedArmor ~= nil then 
            consts.player.equippedArmor.availableArmor = consts.player.equippedArmor.availableArmor - 1
        end 
        consts.player:removeArmor(1)
    end 
    self.collidedWithPlayer = self.projectiles:detectCollisionWithRect(consts.player.hitbox)
 



    
    if self.state == "Move-Left" or self.state == "Move-Right" then 
        
  

        self.speedX = self:MoveHorizontally(dt,self.speedX) 
        if consts.player:overLap(self.attackSquare) and not self.cooldown then 

            
            self.state = "Attack"
            self.add = false 
           
            self.returnPos.x = self.x 
            self.returnPos.y = self.y 
            self.angle = math.atan2(consts.player.y-self.y,consts.player.x-self.x)
            self.cos = math.cos(self.angle)
            self.vel.x = 0
            --self.vel.y = 0

            
        end 
        
        self.vel.x = self.speedX 
        if self.vel.x < 0 then 
            self.animator:setName("KingPot-Moving-Left")

        end
        if self.vel.x > 0 then 
            self.animator:setName("KingPot-Moving-Right")
        end 
    end 




    self:updateBoss(dt,camera)

 

    self:collideWithPlayer(consts.player)
    self:onHit(dt,consts.player.equipment,camera)
    
    self.attackSquare.x = self.x + (self.width/2) - self.attackSquare.width/2
    self.attackSquare.y = self.y + (self.height/2) - self.attackSquare.height/2

    self.hitbox.x = self.x  + 20
    self.hitbox.y = self.y + 34

 

    self.projectiles:update(dt,camera)
    self.animator:update(dt)
end 

function KingPot:draw() 
    local scaleX = self.width/32
    local scaleY = self.height/32
 
    

    self.projectiles:draw()

    self.hurt:apply()
    if not self.respawn then 
        self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
    else 
        love.graphics.draw(self.img,self.respawnQuad, self.x,self.y,0,scaleX,scaleY)
    end 
    self.hurt:unapply()

end 

return KingPot 