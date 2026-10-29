
local consts = require("consts")
local Particle = {}
Particle.__index = Particle 


--clean up code later 


--[[
    type == "rain" || type == "snow" 
    args = {amount,color,use_image,img,shape}

    use_image 
    image 

    type == "sparks" 
    args = {
        color,
        use_image,
        shape
        speed = {
            minX
            maxX 
            minY
            maxY 
        }
        
        size = {
            minSize 
            maxSize 

        }

        times = {
            minLifeTime 
            maxLifeTime 
            minSpawnRate
            maxSpawnRate
        }

        position
    }


    type == "burst" 

    type_args = {
        center = {}
        speed_vec
        radius
        amount
        use_image
        color 
        shape 
        lifetime
        size = {minSize,maxSize},
        add 
    }

    burst_now = false
]]

function Particle:new(type,type_args)
    local p = setmetatable({},Particle)

    p.type = type 
    p.type_args = type_args 
    p.timers = {
        spawn = 0,
        life  = 0 
    }

    p.add = true 

    if p.type == "sparks" then 
        p.limits = {
            spawn = love.math.random(p.type_args.times.minSpawnRate,p.type_args.times.maxSpawnRate),
            lifetime = love.math.random(p.type_args.times.minLifeTime,p.type_args.times.maxLifeTime)

        }
    end 
    
    

    --each particle = {x,y,size,speed}
    p.particles = {

    }
    
    if p.type == "snow" or p.type == "rain" then
        for i = 0, p.type_args.amount do 
            local x = consts.WIDTH/2
            local y = consts.HEIGHT-40 
            local size = love.math.random(2,5)
            local speed = {x=love.math.random(-150,150),y=love.math.random(-200,-80)}
            local pe = {x=x,y=y,size=size,speed=speed}
          
            table.insert(p.particles,pe)
        end 
        
    end



    return p 

end 

function Particle:doLifetime(dt,part) 

    part.timer = part.timer+dt

    if part.timer >= part.lifetime then 
        if part.size <= 0 then 
            table.remove(self.particles,k)
                
        else 
            part.size = part.size - 1

        end 
    end     
end 
function Particle:update(dt) 


    if self.type == "burst" then 
        if self.type_args.burst_now then 
            local angle = 360/self.type_args.amount 
            local pi_angle = angle*(math.pi/180)
            for i = 0, self.type_args.amount do 
                local x = self.type_args.center.x+(math.cos(pi_angle*i)*self.type_args.radius)
                local y = self.type_args.center.y+(math.sin(pi_angle*i)*self.type_args.radius)
                local size = love.math.random(self.type_args.size.minSize,self.type_args.maxSize)
                local speed = {
                    x=math.cos(pi_angle*i)*self.type_args.speed_vec.x,
                    y=math.sin(pi_angle*i)*self.type_args.speed_vec.y 
                }

                local pe = {
                    x = x, 
                    y= y,
                    size = size, 
                    speed = speed,
                    timer = 0,
                    lifetime = self.type_args.lifetime 
                }


                table.insert(self.particles,pe)
            end 

            self.type_args.burst_now = false 
        end 
    end 
    if self.type == "sparks" then 

        if self.add then 
            self.timers.spawn = self.timers.spawn + dt
        if self.timers.spawn >= self.limits.spawn then 
            local x = self.type_args.position.x 
            local y = self.type_args.position.y 

            local size = love.math.random(self.type_args.size.minSize,self.type_args.size.maxSize)
            local speed_vec = {
                x = love.math.random(self.type_args.speed.minX,self.type_args.speed.maxX),
                y = love.math.random(self.type_args.speed.minY,self.type_args.speed.maxY)
            }

            local lifetime = self.limits.lifetime 
            local timer = 0

            local pe = {
                x = x,
                y = y,
                size = size,
                speed_vec = speed_vec,
                lifetime = lifetime,
                timer = timer 
            }

            table.insert(self.particles,pe)
            self.timers.spawn  = 0
            self.limits.spawn = love.math.random(self.type_args.times.minSpawnRate,self.type_args.times.maxSpawnRate)
            self.limits.lifetime = love.math.random(self.type_args.times.minLifeTime,self.type_args.times.maxLifeTime)
        end 
        end 

     
    end 
    for k,part in ipairs(self.particles) do 
        if self.type == "snow" or self.type == "rain" then 
            part.x = part.x + part.speed.x * dt 
            part.y = part.y + part.speed.y * dt 

            if part.y < -part.size then 
                part.x = love.math.random(0, consts.WIDTH)
                part.y = consts.HEIGHT + part.size
                part.speed.x = love.math.random(-150, 150)
                part.speed.y = love.math.random(-200, -80)
            end
            
        end 

        if self.type == "sparks" then 
            part.x  = part.x + part.speed_vec.x * dt 
            part.y = part.y + part.speed_vec.y * dt 

            part.timer = part.timer+dt

            if part.timer >= part.lifetime then 
                if part.size <= 0 then 
                    table.remove(self.particles,k)
                        
                else 
                    part.size = part.size - 1

                end 
            end     
        end 

        if self.type == "burst" then 
            part.x = part.x + part.speed.x * dt 
            part.y = part.y + part.speed.y * dt 
            part.timer = part.timer+dt

            if part.timer >= part.lifetime then 
                if part.size <= 0 then 
                    table.remove(self.particles,k)
                        
                else 
                    part.size = part.size - 1

                end 
            end     
        end 
    end 
end 


function Particle:drawImage(v) 
    if self.type_args.use_image == true then 
     
        local scaleX = v.size/16
        local scaleY = v.size/16

        --love.graphics.setColor(self.type_args.color.r,self.type_args.color.g,self.type_args.color.b,1.0)
        if self.type_args.img_quad == nil then 
            love.graphics.draw(self.type_args.img,v.x,v.y,0,scaleX,scaleY)
        else 
            love.graphics.draw(self.type_args.img,self.type_args.img_quad,v.x,v.y,0,scaleX,scaleY)
        end 
       

    
    end 
end 

function Particle:drawRect(v) 
    if self.type_args.use_image == false then 


        if self.type_args.shape == "rect" then 
            love.graphics.setColor(self.type_args.color.r,self.type_args.color.g,self.type_args.color.b,1.0)
            love.graphics.rectangle("fill",v.x,v.y,v.size,v.size)
            love.graphics.setColor(1.0,1.0,1.0,1.0)
        end 
                --replace with shader 
     
    end 
                    
end 

function Particle:drawCircle(v) 
    if self.type_args.use_image == false then 


        if self.type_args.shape == "circle" then
            love.graphics.setColor(self.type_args.color.r,self.type_args.color.g,self.type_args.color.b,1.0)
            love.graphics.circle("fill",v.x,v.y,v.size)
            love.graphics.setColor(1.0,1.0,1.0,1.0)
        end
                --replace with shader 
       
    end 
end 


function Particle:draw() 

    
    for k,v in ipairs(self.particles) do
        self:drawRect(v)
        self:drawCircle(v)
        self:drawImage(v)
    end
end 

return Particle 