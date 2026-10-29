--contains the hurt shader
 
local Hurt = {}
Hurt.__index = Hurt

function Hurt:new(flash_time,shader_file) 
    local instance = setmetatable({},Hurt)

    instance.flash_time = flash_time 
  
    instance.shader = love.graphics:newShader(shader_file)
    instance.shader:send("flashTime",instance.flash_time) 
    instance.shader:send("time",instance.flash_time+1)
    instance.time = 0
    instance.isHurt = false 
    return instance 
end 

function Hurt:apply() 
    love.graphics.setShader(self.shader)
end 


function Hurt:unapply() 
    love.graphics.setShader() 
end 

function Hurt:update(dt) 
    if self.isHurt then 
        self.time = self.time+dt 
        self.shader:send("time",self.time) 

        if self.time >= self.flash_time then 
            self.isHurt = false 
        end 
    end 

    if self.isHurt == false then 

        self.time = 0 
        self.shader:send("time",self.flash_time+1)
    end 
end     



return Hurt 