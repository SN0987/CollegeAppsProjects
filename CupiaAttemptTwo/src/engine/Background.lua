local Background = {}
Background.__index = Background 




--seperate spritesheet for backgrounds 
--background component = {x,y,width,height, update, draw, index  }
function Background:new() 
    local bg = setmetatable({}, Background) 
    

    bg.index = 0 

    bg.components = {}

    return bg 


end 

function Background:addComponent(component) 
    
    table.insert(self.components, component) 
    

end 

function Background:update(dt) 

    for k,v in pairs(self.components) do 
        v:parentUpdate(dt) 
        v:update(dt) 
    end 
end 



function Background:draw() 
    for k,v in pairs(self.components) do 
        v:parentDraw()
        v:draw()
    end 
end     

return Background