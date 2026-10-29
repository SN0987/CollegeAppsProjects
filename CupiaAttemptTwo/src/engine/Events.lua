local Events = {}



function Events:load() 
    
    self.keys = {
        
    }

    
    self.timePassed = 0


end     

function Events:onePress(key) 
    local bool 
    
    if love.keyboard.isDown(key) and not self.keys[key] then 
        bool = true   

    else
        bool = false 
    end 

    self.keys[key] = love.keyboard.isDown(key)


    return bool 
end 

function Events:update(dt) 
    self.timePassed = self.timePassed + dt 
end     



return Events 