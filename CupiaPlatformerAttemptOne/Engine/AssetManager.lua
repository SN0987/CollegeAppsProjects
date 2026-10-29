local AssetManager = {}
AssetManager.__index = AssetManager
function AssetManager:new() 
    local a = setmetatable({},AssetManager)
    a.images = {}
    a.sound = {}
    a.fonts = {}
    a.shaders = {}
    return a
end 

function AssetManager:getFont(name,path) 
    if not self.fonts[name] then 
        self.fonts[name] = love.graphics.newFont("assets/fonts/".. path)
        print("Successfully Loaded Font: "  .. name)
        return self.fonts[name]
    else
        return self.fonts[name]
    end 
end 

function AssetManager:getImage(name,path)
    if not self.images[name] then 
        self.images[name] = love.graphics.newImage("assets/images/" .. path)
        print("Successfully Loaded Image: " .. name)
        return self.images[name]
    else
        return self.images[name]
    end 
end 

function AssetManager:getShader(name,path)
    if not self.shaders[name] then 
        self.shaders[name] = love.graphics.newShader("assets/shaders/" .. path)
        print("Successfully Loaded Shader: " .. name)
        return self.images[name]
    else
        return self.images[name]
    end 
end 


function AssetManager:getSound(name,path) 
    if not self.sounds[name] then 
        self.sounds[name] = love.sound.newSoundData("assets/sounds/" .. path)
        print("Successfully Loaded Sound: " .. name)
        return self.images[name]
    else
        return self.sounds[name]
    end 
end 

return AssetManager