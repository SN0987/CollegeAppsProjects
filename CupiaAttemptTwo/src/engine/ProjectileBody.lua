local ProjectileBody = {} 

local GameMath = require("engine.GameMath")


ProjectileBody.__index = ProjectileBody

function ProjectileBody:new(width,height) 
    local pb = setmetatable({} , ProjectileBody) 


    pb.vel = {
        x = 0, 
        y = 0, 
    }   

    pb.width = width 
    pb.height = height 

    pb.x = 0
    pb.y = 0
    pb.angleVel = {
        x = 0, 
        y = 0,
    }


    
    pb.rect_two = nil 
    pb.isAngled = false

    pb.existing = true 

    pb.isShot = false 

    pb.accel = {
        xBool = false ,
        yBool = false ,
        y = 0,
        x = 0,
    }

    --max velocity
    pb.max = {
        x = 0, 
        y = 0
    }

    pb.kinematic = {
        grav = 0,
        xIntial = 0, 
        yIntial = 0, 
        velXI = 0, 
        velYI = 0, 
        time = 0
    }

    pb.curved = false 

    pb.rect_one =  {

        x = pb.x, 
        y = pb.y ,
        width = pb.width, 
        height = pb.height, 
    }
     
    return pb 
end    



function ProjectileBody:makeCurved(grav, x_intial, y_intial, vel_x_i,vel_y_i,angle) 
    self.kinematic.grav = grav 
    self.kinematic.xIntial = x_intial 
    self.kinematic.yIntial = y_intial 
    self.kinematic.velXI= math.cos(angle)*vel_x_i
    self.kinematic.velYI = math.sin(angle)*vel_y_i 
    self.x = x_intial
    self.y = y_intial

    self.curved = true  
end 




function ProjectileBody:makeAngle(rect_one,rect_two ) 
    self.rect_one = self
    self.rect_two = rect_two 

    self.isAngled = true 
    



end 


function ProjectileBody:collideWithRect(rect) 

    if GameMath.rectangleCollision(self, rect) then 
        return true 
    end 


end 

function ProjectileBody:setVel(x,y) 
    self.vel.x = x
    self.vel.y = y 
end 

function ProjectileBody:setAcceleration(x,y,maxX,maxY) 
    
    self.accel.x = x 
    self.accel.y = y


    self.max.x = maxX 
    self.max.y = maxY
    if self.accel.x > 0 then 
        self.accel.xBool = true 

    end 

    if self.accel.y > 0 then 
        self.accel.yBool = true 
    end 


end 


function ProjectileBody:shoot() 
    if not self.isShot then 
        self.isShot = true 
    
    end 

end 

function ProjectileBody:updateParent(dt) 

    if self.existing and self.isShot then 


        
        if self.isAngled then 


            if self.accel.xBool then 
                GameMath.accelerate(self.angleVel,self.accel.x,self.max.x)
            end     

            self.x = self.x + self.angleVel.x * dt 

            if self.accel.yBool then 
                GameMath.accelerate(self.angleVel,self.accel.y,self.max.y)
            end     

            self.y = self.y + self.angleVel.y * dt  

            
            local angle = math.atan2(self.rect_two.y - self.rect_one.y, self.rect_two.x - self.rect_one.x) 

            self.angleVel.x = math.cos(angle) * self.vel.x 
            self.angleVel.y = math.sin(angle) * self.vel.y 


            self.isShot = false 
                
          

        end 

        if self.curved then 


        
            self.kinematic.time = self.kinematic.time + dt 
            self.x = (self.kinematic.velXI*self.kinematic.time) + (self.kinematic.xIntial)
            self.y = (self.kinematic.grav*1/2)*(math.pow(self.kinematic.time,2))+(self.kinematic.velYI*self.kinematic.time) + self.kinematic.yIntial
            
            
       

        end 
    end 
   
end 
function ProjectileBody:update(dt) 

 
end 

function ProjectileBody:draw() 

end 

return ProjectileBody