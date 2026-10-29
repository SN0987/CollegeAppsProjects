local Level = require ("engine.Level")
local LevelManager = {}
LevelManager.__index = LevelManager 


function LevelManager:new(world_name,spritesheet,state) 
    local lm = setmetatable({}, LevelManager)


    --load levels by world_name + currentLevel 
    lm.world_name = world_name
    lm.levels = {} 
    lm.spritesheet = spritesheet 
    lm.currentLevel = 1
    lm.state = state -- states.gameItems.gameItems.currentState

 
    return lm 
end 

function LevelManager:add(level,index) 
    self.levels[index] = level 
end 

function LevelManager:reset(level,index) 
    self.levels[index] = level 
    self.state = "Not Playing"
end 


function LevelManager:addIndexes(num) 
    for i = 1, num do 
        self:add(Level:new(self.world_name, i, self, self.spritesheet), i) 
    end 
end 

function LevelManager:update(dt)

    if self.levels[self.currentLevel] ~= nil then 
        self.levels[self.currentLevel]:update(dt) 
       
    end 
end 

function LevelManager:leave() 
    self:reset(Level:new(self.world_name, self.currentLevel, self, self.levels[self.currentLevel].spritesheet)) 
    self.currentLevel = 0 
end 

function LevelManager:change(index) 
    self:leave() 
    self.currentLevel = index 

    if self.levels[self.currentLevel] == nil then 
        print("level does not exist") 
    end     
end     

function LevelManager:draw() 

    if self.levels[self.currentLevel] ~= nil then 
        self.levels[self.currentLevel]:draw() 
    end 
end 

    
return LevelManager