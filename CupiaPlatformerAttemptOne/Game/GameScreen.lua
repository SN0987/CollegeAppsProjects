local GameScreen = {}

local LevelManager = require("Engine.LevelManager")
local UI_Manager = require("Engine.UI_Manager")
local Options = require("Engine.Options")
local Label = require("Engine.Label")
local Button = require("Engine.Button")
local consts = require("consts")
GameScreen.__index = GameScreen

--[[

Game Data Formate 

game.lua 

game_data = {
    overworld_cleared = false 
    overworld_levels_cleared = 0
    underworld_cleared = false 
    underworld_levels_cleared = 0
    
}

]]

function GameScreen:new(Game) 

    local gs = setmetatable({},GameScreen)


    -- selection, overworld, underworld 
    gs.currentState = "selection"


    -- Button:new(x,y,width,height,text,size,img,color,font_color,name)
    --Options:new(name,font_path,sizes,x,margin,color) 
    --Label:new(x,y,text,size,font_path,color,max_bound,name) 

    local s_title = Label:new(15,0,"Choose World",75,"assets/fonts/font_basic.ttf",{r=1,g=1,b=1},nil,"S-Title")
    local s_options = Options:new("S-Options","assets/fonts/font_basic.ttf",{minSize=35,maxSize=55},0,nil,{r=1,g=1,b=1})
    local s_chose_label = Label:new(0,consts.HEIGHT-30,"Press Enter To Choose...",25,"assets/fonts/font_basic.ttf",{r=1,g=1,b=1},nil,"S-Label")
    s_chose_label:centerX()
    s_options:addOption("Overworld","Overworld",consts.HEIGHT/2-50)
    s_options:addOption("Underworld","Underworld",consts.HEIGHT/2+50)
    s_title:centerX()

    
    gs.UI_Manager = UI_Manager:new()
    gs.UI_Manager:addElement(s_options)
    gs.UI_Manager:addElement(s_title)
    gs.UI_Manager:addElement(s_chose_label)

    --function Options:addOption(name, text,y) 
    

    --overworld 


    gs.overworld_manager = LevelManager:new(Game,"Overworld")
    --underworl 

    gs.underworld_manager = LevelManager:new(Game,"Underworld") 



    return gs 
end 

--
--function Element:setText(x,y, string_text, size, color, font_path)
function GameScreen:update(dt,Game) 

    local s_options = self.UI_Manager:getElements("S-Options")[1]

    local s_title = self.UI_Manager:getElements("S-Title")[1]
    local s_label = self.UI_Manager:getElements("S-Label")[1]

    s_options:setToCenter()


    
    if self.currentState == "selection" then 
        
        s_label:centerX()
        if s_options:returnOption() == "Overworld" then 
            

            s_label:setText(s_label.font_position.x,s_label.font_position.y,"Press Enter To Choose...",25,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")


            if love.keyboard.isDown("return") then 
                self.currentState = "overworld"
            end 
        elseif s_options:returnOption() == "Underworld" then 

            if consts.game_world_data.overworld_cleared == false then 
                s_label:setText(s_label.font_position.x,s_label.font_position.y,"Can't Select This Right Now... Clear Overworld",25,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
            else
                s_label:setText(s_label.font_position.x,s_label.font_position.y,"Press Enter To Choose...",25,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")

                if love.keyboard.isDown("return") then 
                    self.currentState = "underworld"
                end 
            end 

        end 

        s_title.show = true 
        s_label.show = true 
        s_options.show = true 

        self.UI_Manager:update(dt,Game.scaleCamera)

    
        
    end 

    if self.currentState == "overworld" then 
      
        self.overworld_manager:update(dt,Game)

    end 

    if self.currentState == "underworld" then 
        self.underworld_manager:update(dt,Game)
    end 

   
end 

function GameScreen:draw() 
    if self.currentState == "selection" then 
        self.UI_Manager:draw()
    end 

    if self.currentState == "overworld" then 
        self.overworld_manager:draw()
    end 

    if self.currentState == "underworld" then 
        self.underworld_manager:draw()
    end 

  
end 


return GameScreen 