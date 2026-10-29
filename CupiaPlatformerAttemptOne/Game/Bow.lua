local Weapon = require("Game.Weapon")
local Projectiles = require("Game.Projectiles")
local Label = require("Engine.Label")
local consts = require("consts")
local Bow = setmetatable({},{__index=Weapon})
Bow.__index = Bow 

function Bow:new(x,y,em,ui_manager)
    consts.indexes.bow = consts.indexes.bow + 1
  
    local b = setmetatable(Weapon:new(x,y,"Bow"),Bow)

    b.em = em 
    b.ui_manager = ui_manager

    b.width = 32
    b.height = 32 

    b.trajs = {}
    b.isMouseDown = false 

    b.start_pos = {
        x = b.x,
        y = b.y 
    }

    b.max_dist = {
        width = 250,
        height = 250
    }

    b.deltaDist = {
        width = 0,
        height = 0,
    }


 

    b.moreMouse = false 

    b.img = consts.AssetManager:getImage("Bow", "Weapons/bow.png")
    b.projectiles = Projectiles:new(b.x,b.y,32,32,{r=0.25,g=0.11,b=0.025},"Bow-Projectiles",{img=b.img,animate=false,quad=love.graphics.newQuad(32,0,16,16,b.img:getWidth(),b.img:getHeight())})
    b.projectiles.maxDistance.x = 500 
    b.projectiles.maxDistance.y = 500
    b.projectile_speed = {
        x = 0,
        y = 0,
    }

    b.speed_const = 250
    b.reset_const = 250 
    b.speeds =  {
        counter = 0,
        time = 0.2, 
        current_speed = {
            x=0,
            y=0
        },
        added = false ,
        max = {},
        index = 1,
        max_index = 5,
        angle = 0
        
    }

    b.accelConst = 350


    -- Loading , Shooting 
    b.state = "Not-Shoot"
    

    

    b.idle_quad = love.graphics.newQuad(0,0,16,16,b.img:getWidth(),b.img:getHeight())
    b.shoot_quad = love.graphics.newQuad(16,0,16,16,b.img:getWidth(),b.img:getHeight())
    b.quad = b.idle_quad
    b.ammo = 12 
    b.label = Label:new(30,30,tostring(b.ammo), 30,nil,{r=1,g=1,b=1},500,"Bow-Label: " .. consts.indexes.bow)
  
    b.label:addImage(b.img,love.graphics.newQuad(32,0,16,16,b.img:getWidth(),b.img:getHeight()),20,consts.settings.screen_height-30,20,20)
    b.label:setText(45,consts.HEIGHT-28,tostring(b.ammo),15,{r=1,g=1,b=1},nil)
    b.label.show = false 

    b.ui_manager:addElement(b.label)
    

    b.drawStuff = {
        angle = 0
    }
    return b    

end 

function Bow:setTrajectory()
    
    local steps = 35   -- Number of points in the trajectory
    local timeStep = 0.02   -- Time between each point (in seconds)

    local vx = self.deltaDist.width * 2  -- initial horizontal velocity
    local vy = self.deltaDist.height * 2   -- initial vertical velocity (scaled)
    local gravity = 980                    -- gravity constant (pixels/sec^2)

    self.trajs = {}

    


    for i = 1, steps do
        local t = i * timeStep
        local x = vx * t
        local y = vy * t + 0.5 * gravity * t^2
        table.insert(self.trajs, {x = x, y = y})
    end

end 



function Bow:calculateTrajectory() 
    self.start_pos.x = self.x 
    self.start_pos.y = self.y 


    if #self.trajs >= 0 then 
        for i = 1, #self.trajs do 
            self.trajs[i] = nil 
        end 
        self:setTrajectory()
    else
        self:setTrajectory()
    end 
   

end 
function Bow:update(dt,camera) 


    
    local label = self.ui_manager:getSingleElement(self.label.name)
   
    if self.pickedUp and consts.player.equipment == self then 

        label.show = true 
    
        self.moreMouse = love.mouse.isDown(1)
        local mx,my = camera:globalMousePos()

        if love.mouse.isDown(1) and not self.speeds.added  then 

            self.isMouseDown = true 
            self.quad = self.shoot_quad
            
            
            local distX = mx-self.x

            if mx > self.x then 

                if distX < self.max_dist.width then 
                    self.deltaDist.width = distX
                end 

              
            end 

            if mx < self.x then 
                if distX > -self.max_dist.width then 
                    self.deltaDist.width = distX
                end 

                
            end 


            local distY = my-self.y

            if my > self.y then 

                if distY < self.max_dist.width then 
                    self.deltaDist.height = distY
                end 


              
            end 

            if my < self.y then 
                if distY > -self.max_dist.height then 
                    self.deltaDist.height = distY
                end 

             
            end 

            

            self:calculateTrajectory()


        end 

        if self.isMouseDown and not love.mouse.isDown(1) and self.ammo > 0 then 
            
            
            self.ammo = self.ammo - 1 
            label:setText(45,consts.HEIGHT-28,tostring(self.ammo),15,{r=1,g=1,b=1},nil)
         
            self.speeds.added = true 

            local intialPosY = self.start_pos.y+self.trajs[1].y 
            local intialPosX = self.start_pos.x+self.trajs[1].x 
            local intialPosTwoX = self.start_pos.x+self.trajs[5].x
            local intialPosTwoY = self.start_pos.y+self.trajs[5].y

            self.speeds.angle = math.atan2(intialPosTwoY-intialPosY,intialPosTwoX-intialPosX)

        
            self.speeds.current_speed = {
                x=math.cos(self.speeds.angle)*self.speed_const, 
                y=math.sin(self.speeds.angle)*self.speed_const
            }

         
            self.projectile_speed = self.speeds.current_speed
            

            self.projectiles:settingsWithAmount(self.x,self.y,self.projectile_speed,1,{
                x=self.x,y=self.y, width=20,height=16,offsetX = 0,offsetY = 8
            })
            self.isMouseDown = false 
        end 


    else 
        label.show = false 
    end 

    if self.ammo <= 0 then 
        self.delete = true 
        self.ui_manager:removeAllElementsByName(self.label.name) 
    end 

    if self.speeds.added then 
        self.speeds.counter = self.speeds.counter + dt 
        
        self.quad = self.idle_quad
        if self.speeds.counter >= self.speeds.time then 
       
            self.speeds.counter = 0
            
            if self.speeds.index < self.speeds.max_index then 
                local prevIndex = self.speeds.index 

                self.speeds.index = self.speeds.index + 1
                
                local newX = self.start_pos.x + self.trajs[self.speeds.index*(#self.trajs/self.speeds.max_index)].x 
                local newY =  self.start_pos.y + self.trajs[self.speeds.index*(#self.trajs/self.speeds.max_index)].y
                local oldX  = self.start_pos.x + self.trajs[prevIndex*(#self.trajs/self.speeds.max_index)].x 
                local oldY =  self.start_pos.y + self.trajs[prevIndex*(#self.trajs/self.speeds.max_index)].y
                self.speeds.angle = math.atan2(newY-oldY,newX-oldX)

                self.speeds.current_speed = 
                {
                    x = math.cos(self.speeds.angle)*self.speed_const,
                    y = math.sin(self.speeds.angle)*self.speed_const
                }
            else
                self.speeds.index = 1 
                self.speeds.added = false
                self.speed_const = self.reset_const
            end 


            
        end 

        self.speed_const = self.speed_const + self.accelConst * dt 
        self.projectile_speed = self.speeds.current_speed

                
        self.center.x = consts.player.x+consts.player.width/2-(self.width/2) + 5
        self.center.y = consts.player.y+consts.player.height/2-(self.height/2) + 5

    end 

    




    self.projectiles:adjustBulletSpeed(self.projectile_speed)
    self.projectiles:update(dt,camera)
    
    local mx,my = camera:globalMousePos()

    self.drawStuff.angle = math.atan2(my-self.y,mx-self.x)

    
    self:parentUpdate(dt,camera)
end 


function Bow:draw() 


    if self.isMouseDown then 
        --[[love.graphics.setColor(1.0,0,0,1)
        love.graphics.line(self.start_pos.x,self.start_pos.y,self.start_pos.x+self.deltaDist.width,self.start_pos.y+self.deltaDist.height)]]
        love.graphics.setColor(1,1,1,1)
        for i = 1, #self.trajs - 1 do 
            local p = self.trajs[i]
            local pt = self.trajs[i+1]
            love.graphics.line(self.start_pos.x+p.x,self.start_pos.y+p.y,self.start_pos.x+pt.x,self.start_pos.y+pt.y)
        end 

    end 

    
    self.projectiles:drawWithAngle(self.speeds.angle)
    

    local scaleX = self.width/16 
    local scaleY = self.height/16 

    
    --local mouseAngle = math.atan2(my-self.y,mx-self.x)
    local center = {
        width = 16/2,
        height = 16/2
    }
 
    --love.graphics.setColor(1, 0, 0)
    --love.graphics.line(self.x,self.y, mx, my)
    if self.pickedUp then 

    
        love.graphics.draw(self.img, self.quad,self.x,self.y,self.drawStuff.angle,scaleX,scaleY,center.width,center.height)
        
       
        
    else
        love.graphics.draw(self.img, self.quad, self.x,self.y,0,scaleX,scaleY)
    end 
    
end 


return Bow 