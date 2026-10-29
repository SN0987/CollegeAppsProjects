
local AssetManager = {}
AssetManager.__index = AssetManager

function AssetManager:new() 
    local am  = setmetatable({}, AssetManager)

    love.graphics.setDefaultFilter("nearest","nearest")
    am.images = {}

    am.fonts = {}
    

    return am 
end 

function AssetManager:getFont(path,size) 
    if self.fonts[path] == nil then 
        local paths = {}    

        self.fonts[path] = paths
    end


    if self.fonts[path] then 
        if self.fonts[path][size] == nil then 
            self.fonts[path][size] = love.graphics.newFont(path, size) 
             
            return self.fonts[path][size] 
        end 
    end 


    if self.fonts[path][size] == nil then 
        print("not loaded properly") 
    else
        return self.fonts[path][size] 

    end 

    
  
end 



function AssetManager:add(name, path)
    
    if(self.images[name] == nil) then 
        self.images[name] = love.graphics.newImage(path)
    end     

end 

function AssetManager:get(name) 

    if(self.images[name] ~= nil) then 
        return self.images[name]
    end 
end 


return AssetManager