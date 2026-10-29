--Entity for entity system 


local Entity = {}
Entity.__index = Entity 


-- collider status: "static", "dynamic", "none", draw_args = {draw = false/true, color}
function Entity:new(x,y,width,height,id,collider_status,draw_args)
    local e = setmetatable({},Entity)

    e.x = x
    e.y = y 
    e.width = width 
    e.height = height 
    e.collider_status = collider_status -- static collider: not moving, dynamic: moving, or none
    e.force = {
        x = 0,
        y = 0
    }

    e.draw_args = draw_args 
    e.id = id 
    e.vel = {
        x = 0,
        y = 0
    }
    e.gravity = 390 --default gravity
    e.resetGravity = 390 -- reset
    e.is_grounded = false 

    e.jumping = {
        bool = false, 
        jump_time = 0.4, --changable 
        speed = 280,
        timer = 0
    }

    e.delete = false 
    e.accelGravity = (e.width*e.height)*0.001

    return e
end



function Entity:jump() 
    if self.jumping.bool == false and self.is_grounded then 
        
        self.jumping.bool = true 
        self.is_grounded = false 
    end 
end 

function Entity:applyForce(speed_vec) 
    self.vel.x = speed_vec.x 
    self.vel.y = speed_vec.y 
end 

function Entity:overLap(e)
    if e.id ~= self.id then 
    
        if self.x < e.x+e.width and self.x+self.width > e.x and self.y < e.y+e.height and self.y+self.height > e.y then 

            if e.id == "Trap" then 
                self.is_col = true
            end 
            
            if self.id == "Trap" then 
                self.is_col = true
            end 
            return true 
        end 
    end 

    return false 
end 

function Entity:xOverlap(e) 
    return self.x < e.x+e.width and self.x+self.width > e.x 
end 

function Entity:yOverlap(e) 
    return self.y < e.y+e.height and self.y+self.height > e.y
end 


function Entity:overlapWithCamera(e,camera) 

    local leftSide 
    local rightSide 
    local top
    local bottom 

    local oLeftSide 
    local oRightSide 
    local oTop
    local oBottom
    if self.id ~= "Player" then 
        leftSide = self.x-camera.x 
        rightSide = (self.x+self.width)-camera.x 
        top = (self.y)-camera.y  
        bottom = (self.y+self.height)-camera.y 
    elseif self.id == "Player" then 
        leftSide = self.x+camera.x 
        rightSide = (self.x+self.width)+camera.x 
        top = (self.y)+camera.y  
        bottom = (self.y+self.height)+camera.y 
    end 

    if e.id ~= "Player" then 
        oLeftSide = e.x-camera.x 
        oRightSide = (e.x+e.width)-camera.x 
        oTop = (e.y)-camera.y  
        oBottom = (e.y+e.height)-camera.y 
    elseif e.id == "Player" then 
        oLeftSide = e.x+camera.x 
        oRightSide = (e.x+e.width)+camera.x 
        oTop = (e.y)+camera.y  
        oBottom = (e.y+e.height)+camera.y 
    end 

    if self.id ~= e.id then 
        return leftSide < oRightSide and rightSide > oLeftSide and top < oBottom and bottom > oTop 

        --[[print("Left Side: " .. oLeftSide)
        print("Right Side: " .. oRightSide)
        print("Top Side: " .. oTop)
        print("Bottom Side: " .. oBottom)]]
    end 



end

function Entity:xOverlapWithCamera(e,camera) 
    local leftSide 
    local rightSide 
  

    local oLeftSide 
    local oRightSide 
    
    if self.id ~= "Player" then 
        leftSide = self.x-camera.x 
        rightSide = (self.x+self.width)-camera.x 
       
    elseif self.id == "Player" then 
        leftSide = self.x+camera.x 
        rightSide = (self.x+self.width)+camera.x 
   
    end 

    if e.id ~= "Player" then 
        oLeftSide = e.x-camera.x 
        oRightSide = (e.x+e.width)-camera.x 
      
    elseif e.id == "Player" then 
        oLeftSide = e.x+camera.x 
        oRightSide = (e.x+e.width)+camera.x 
       
    end 

    if self.id ~= e.id then 
        return leftSide < oRightSide and rightSide > oLeftSide 
    end 
end 

function Entity:yOverlapWithCamera(e,camera)
    
    local top
    local bottom 


    local oTop
    local oBottom
    if self.id ~= "Player" then 
      
        top = (self.y)-camera.y  
        bottom = (self.y+self.height)-camera.y 
    elseif self.id == "Player" then 

        top = (self.y)+camera.y  
        bottom = (self.y+self.height)+camera.y 
    end 

    if e.id ~= "Player" then 

        oTop = (e.y)-camera.y  
        oBottom = (e.y+e.height)-camera.y 
    elseif e.id == "Player" then 
 
        oTop = (e.y)+camera.y  
        oBottom = (e.y+e.height)+camera.y 
    end 

    if self.id ~= e.id then 
        return top < oBottom and bottom > oTop 
    end 

end 

function Entity:update(dt,camera)
    
    
    if self.collider_status == "dynamic" or self.collider_status == "none" then 
        self.x = self.x + self.vel.x * dt 
        self.y = self.y + self.vel.y * dt

        
       
    end 

end 

function Entity:draw(camera)
    
    if self.draw_args.draw then
        
        love.graphics.setColor(self.draw_args.color.r,self.draw_args.color.g,self.draw_args.color.b,1)
        love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    end
    
end 



return Entity 