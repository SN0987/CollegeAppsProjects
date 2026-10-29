local Sprite = require("Game.Sprite")

local Projectiles = setmetatable({},{__index=Sprite})
local Particle = require("Engine.Particle")
Projectiles.__index = Projectiles

function Projectiles:new(x,y,width,height,burst_color,name,img_args) 
    local p = setmetatable(Sprite:new(x,y,width,height,name,"dynamic"),Projectiles)
    p.accelGravity = 0
    p.gravity = 0
    p.resetGravity = 0
    p.img_args = img_args 

    p.em = nil 
    p.setting = {

    }
    p.bullets = {

    }

    p.maxDistance = {
        x = nil ,
        y = nil 
    }

    p.burst = Particle:new("burst", 
    {burst_now = false, center={x=p.x,y=p.y},use_image=false,color=burst_color,amount=60,radius=3,lifetime=0.1,size={minSize=3,maxSize=12},shape="circle",speed_vec={x=250,y=250}})
    

    return p 
end 


--return true 
function Projectiles:detectCollison(entityName) 

    local e = self.em:getEntity(entityName)
    for k,v in ipairs(self.bullets) do 

        if v.x <= e.x+e.width and v.x+v.width >= e.x and v.y <= e.y+e.height and v.y+v.height >= e.y then 
            v.delete = true 
            return true 
        end 
    end 
end


function Projectiles:detectCollisionWithRect(rect) 
    local e = rect 
    for k,v in ipairs(self.bullets) do
        if v.hitbox.x <= e.x+e.width and v.hitbox.x+v.hitbox.width >= e.x and v.y <= e.y+e.height and v.hitbox.y+v.hitbox.height >= e.y then 
            v.delete = true 
            return true 
        end 
        
    end
end 

function Projectiles:detectCollisionWithList(entityName) 

    
    for k,v in ipairs(self.bullets) do 

    end 


end 


function Projectiles:settings(x,y,speed,hitbox,add) 
    self.setting.x = x
    self.setting.y = y 
    self.setting.speed = speed 
    self.setting.add = add 
    self.setting.hitbox = hitbox 
    
    
end 

function Projectiles:settingsWithAmount(x,y,speed,amount,hitbox) 
   

    for i = 1,amount do 
        local bullet = {
            img = self.img,
            x = x,
            y = y,
            startX = x,
            startY = y,
            width = self.width,
            height = self.height,
            id = "bullet",
            delete = false, 
            speed=speed,
            hitbox = hitbox
        }

        table.insert(self.bullets,bullet)        
        
    end 
end 


function Projectiles:adjustBulletSpeed(vel) 
    for k,v in ipairs(self.bullets) do 
        if v.speed ~= nil then 
            v.speed = vel 
        end 
    end 
end 
function Projectiles:update(dt,camera) 

    if self.setting.add then 

       
        local bullet = {
            img = self.img,
            x = self.setting.x,
            y = self.setting.y, 
            startX = self.setting.x,
            startY = self.setting.y,
            width = self.width,
            height = self.height,
            id = "bullet",
            delete = false, 
            hitbox = self.setting.hitbox
            
        }

        table.insert(self.bullets,bullet)        
        
  


        self.setting.add = false 
        

    end 

    for k,v in ipairs(self.bullets) do 

        if v.speed == nil then 
            v.x = v.x + self.setting.speed.x * dt 
            v.y = v.y + self.setting.speed.y * dt 
        else
            v.x = v.x + v.speed.x  * dt 
            v.y = v.y + v.speed.y * dt 
        end 
       

        if self.maxDistance.x ~= nil and self.maxDistance.y ~= nil then 
                
            if v.x >= (v.startX+self.maxDistance.x) or v.x <= (v.startX-self.maxDistance.x ) or v.y >= (v.startY+self.maxDistance.y) or v.y <= (v.startY-self.maxDistance.y) then 
                v.delete = true   
          
            end 
        end 

        v.hitbox.x = v.x-v.hitbox.offsetX 
        v.hitbox.y = v.y-v.hitbox.offsetY
    end 

    for k,v in ipairs(self.bullets) do 



        if v.delete then 
            table.remove(self.bullets,k )
            self.burst.type_args.center.x = v.x
            self.burst.type_args.center.y = v.y
            self.burst.type_args.burst_now = true
        end 
    end 

    self.burst:update(dt)
end 

function Projectiles:draw() 
    for k,v in ipairs(self.bullets) do
        local scaleX 
        local scaleY 

        --love.graphics.setColor(1,1,1,1)
        --love.graphics.rectangle("fill",v.hitbox.x,v.hitbox.y,v.hitbox.width,v.hitbox.height)
        if self.img_args.img == nil then  
            love.graphics.setColor(self.img_args.color.r,self.img_args.color.g,self.img_args.color.b,1)

            love.graphics.rectangle("fill",v.x,v.y,v.width,v.height)
            love.graphics.setColor(1,1,1,1) 
        elseif self.img_args.img ~= nil  and self.img_args.animate == false then 
          
            if self.img_args.quad ~= nil then 
                local x,y,w,h  = self.img_args.quad:getViewport() 

                scaleX = self.width/w
                scaleY = self.height/h
                love.graphics.draw(self.img_args.img,self.img_args.quad,v.x,v.y,0,scaleX,scaleY)
            elseif self.img_args.quad == nil then 

                scaleX = self.width/self.img_args.img:getWidth()
                scaleY = self.height/self.img_args.img:getHeight()
                love.graphics.draw(self.img_args.img,v.x,v.y,0,scaleX,scaleY)
            end 
           
          
        elseif self.img_args.animate then 
            scaleX = self.width/self.img_args.srcWidth 
            scaleY = self.height/self.img_args.srcHeight 
            self.animator:draw(self.img_args.img,v.x,v.y,scaleX,scaleY)
        end 
    end 
    
    self.burst:draw()
  

 
end 

function Projectiles:drawWithAngle(angle) 
    for k,v in ipairs(self.bullets) do
        local scaleX 
        local scaleY 

        --love.graphics.setColor(1.0,1.0,1.0,1.0)
        --love.graphics.rectangle("fill",v.hitbox.x,v.hitbox.y,v.hitbox.width,v.hitbox.height)
        if self.img_args.img == nil then  
            love.graphics.setColor(self.img_args.color.r,self.img_args.color.g,self.img_args.color.b,1)

            love.graphics.rectangle("fill",v.x,v.y,v.width,v.height)
            love.graphics.setColor(1,1,1,1) 
        elseif self.img_args.img ~= nil  and self.img_args.animate == false then 
          
            if self.img_args.quad ~= nil then 
                local x,y,w,h  = self.img_args.quad:getViewport() 

                scaleX = self.width/w
                scaleY = self.height/h
                love.graphics.draw(self.img_args.img,self.img_args.quad,v.x,v.y,angle,scaleX,scaleY)
            elseif self.img_args.quad == nil then 

                scaleX = self.width/self.img_args.img:getWidth()
                scaleY = self.height/self.img_args.img:getHeight()
                love.graphics.draw(self.img_args.img,v.x,v.y,angle,scaleX,scaleY)
            end 
           
          
        elseif self.img_args.animate then 
            scaleX = self.width/self.img_args.srcWidth 
            scaleY = self.height/self.img_args.srcHeight 
            self.animator:drawWithAngle(self.img_args.img,v.x,v.y,scaleX,scaleY,angle,{width=0,height=0})
        end 
    end 
    
    self.burst:draw()
  

 
end 




return Projectiles 