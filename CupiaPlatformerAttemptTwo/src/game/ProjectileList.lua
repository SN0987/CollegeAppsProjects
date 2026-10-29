local ProjectileList = {} 
ProjectileList.__index = ProjectileList
 
function ProjectileList:new() 
    local p = setmetatable({} , ProjectileList) 

    p.bullets = {}

    return p 
end 

function ProjectileList:add(p,shoot_status) 


    if shoot_status then 
        p:shoot()
    end 

    table.insert(self.bullets, p) 
end 

function ProjectileList:update(dt) 

    for k,v in ipairs(self.bullets) do 
        v:update(dt)   
    end 
end 

function ProjectileList:draw() 


    for k,v in ipairs(self.bullets) do 
        v:draw() 
    end 
end 

return ProjectileList