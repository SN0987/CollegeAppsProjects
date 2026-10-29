local States = {}

local LevelManager = require("engine.LevelManager") 
local globals      = require("globals")
local Level = require("engine.Level")

-- menu, game, settings 

States.mainState = "Menu" 
States.menuItems = {}
States.gameItems = {}
States.settingsItems = {} 




function States:start() 

    self.gameItems.currentState = "Overworld" 
    self.gameItems.overworld_levels = LevelManager:new("Overworld", globals.am:get("Overworld-Spritesheet") , self.gameItems.currentState) 

    self.gameItems.overworld_levels:add(Level:new("Overworld",1, self.gameItems.overworld_levels, globals.am:get("Overworld-Spritesheet")),1)

end 

function States:update(dt) 

    

    if love.keyboard.isDown("space") and not globals.keyboardStates["space"] then 

        if self.mainState == "Menu" then self.mainState = "Game" end 
    end     

    globals.keyboardStates["space"] = love.keyboard.isDown("space") 
    if self.mainState == "Menu" then 
        
    end     

    if self.mainState == "Game" then

       
        if self.gameItems.currentState == "Overworld" then 
            States.gameItems.overworld_levels:update(dt) 
        end 
      
    end     
end 

function States:draw() 

    if self.mainState == "Menu" then 

    end 
    
    if self.mainState == "Game" then 

        if self.gameItems.currentState == "Overworld" then 

 
            States.gameItems.overworld_levels:draw() 
        end 
        
    end     

end 

return States 