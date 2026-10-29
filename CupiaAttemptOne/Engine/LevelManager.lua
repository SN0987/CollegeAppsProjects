local LevelManager = {}

local Level = require("Engine.Level")
local UI_Manager = require("Engine.UI_Manager")
local Options = require("Engine.Options")
local Label = require("Engine.Label")
local Button = require("Engine.Button")
local consts = require("consts")
LevelManager.__index = LevelManager 



function LevelManager:new(main_game_args,path_of_levels) 
    local L = setmetatable({},LevelManager)


    L.levels = {}

    L.currentLevel = 0

    --selection and play
    L.state = "selection"
    L.path_of_levels = path_of_levels 

    L.maxLevels = 5 
    L.counter = 1 
    -- Button:new(x,y,width,height,text,size,img,color,font_color,name)
    --Options:new(name,font_path,sizes,x,margin,color) 
    --Label:new(x,y,text,size,font_path,color,max_bound,name) 

    ----Level:new(name,map_file_name,type_world,level_manager,counter)
    for i = 1, 5 do 
       
        L.levels[i] = Level:new(path_of_levels .. ":" .. i, "assets/maps/" .. path_of_levels .. "/" .. i .. ".lua",path_of_levels,L,i,main_game_args)
    end 

    
    local leftArrow = Button:new(10,0,48,48,"",1,consts.AssetManager:getImage("Left-Arrow","ui/left_arrow_key.png"),{r=1,g=1,b=1},{r=1,g=1,b=1},"Left-Arrow")
    local rightArrow = Button:new(consts.WIDTH-58,0,48,48,"",1,consts.AssetManager:getImage("Right-Arrow","ui/right_arrow_key.png"),{r=1,g=1,b=1},{r=1,g=1,b=1},"Right-Arrow")
    leftArrow:toCenterY()
    rightArrow:toCenterY()

    local levelTitle = Label:new(0,15,"Level",45,"assets/fonts/font_basic.ttf",{r=1,g=1,b=1},nil,"L-Title")
    levelTitle:centerX()
    levelTitle:centerY()

    local mainTitle = Label:new(0,15,"Select Level", 55, "assets/fonts/font_basic.ttf",{r=1,g=1,b=1},nil, "M-Title")
    mainTitle:centerX()
    L.button_img = consts.AssetManager:getImage("Button", "ui/cupia_button.png")

    lockedLabel = Label:new(0,levelTitle.font_position.y+60,"Unlocked", 25, "assets/fonts/font_basic.ttf",{r=1,g=1,b=1},nil,"Locked-Label")

    lockedLabel:centerX()
    
    

    local play_button = Button:new(0,consts.HEIGHT-66,166,56,"Play",35,L.button_img,{r=1,g=1,b=1},{r=1,g=1,b=1},"Play-Button")
    play_button:toCenterX()

    L.UI_Manager = UI_Manager:new()

    L.UI_Manager:addElement(leftArrow)
    L.UI_Manager:addElement(rightArrow)
    L.UI_Manager:addElement(levelTitle)
    L.UI_Manager:addElement(play_button)
    L.UI_Manager:addElement(mainTitle)
    L.UI_Manager:addElement(lockedLabel)
    
    L.leftArrowClicked = false 
    L.rightArrowClicked = false 
    
    return L

end 

function LevelManager:replace(counter,level)
    
    
    self.levels[counter] = nil 
    self.levels[counter] = level 

end 

function LevelManager:setLevel(counter,level)
    
    if self.levels[self.currentLevel] == nil then 
        self.levels[counter] = level 
        self.currentLevel = counter 
    else 
        if self.currentLevel ~= counter then 
            self.currentLevel = counter 
        end 
    end 

end 

function LevelManager:update(dt,game_args)


    if self.state == "selection" then   
        --Element:setText(x,y, string_text, size, color, font_path)
        local l_title = self.UI_Manager:getElements("L-Title")[1]
        local left_arrow = self.UI_Manager:getElements("Left-Arrow")[1]
        local right_arrow = self.UI_Manager:getElements("Right-Arrow")[1]
        local locked_label = self.UI_Manager:getElements("Locked-Label")[1]
        local play_button = self.UI_Manager:getElements("Play-Button")[1]
        l_title:setText(l_title.font_position.x,l_title.font_position.y,self.levels[self.counter].name,45,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
        l_title:centerX()
        l_title:centerY()
        self.UI_Manager:update(dt,game_args.scaleCamera)


        if self.path_of_levels == "Overworld" then 
            if consts.game_world_data.overworld_levels_cleared+1 >= self.counter then 
                locked_label:setText(locked_label.font_position.x,locked_label.font_position.y,"Unlocked",25,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
                locked_label:centerX()
            elseif consts.game_world_data.overworld_levels_cleared+1 < self.counter then
                locked_label:setText(locked_label.font_position.x,locked_label.font_position.y,"Locked",25,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
                locked_label:centerX()
            end 
        end 
      

        if left_arrow:clicked(game_args.scaleCamera)  and not self.leftArrowClicked then 

            if self.counter > 1 then
                self.counter = self.counter - 1
            end 

        end 

        self.leftArrowClicked = left_arrow:clicked(game_args.scaleCamera)
        if right_arrow:clicked(game_args.scaleCamera) and not self.rightArrowClicked then 
            if self.counter < self.maxLevels then 
                self.counter = self.counter + 1
            end 
        end 

        self.rightArrowClicked = right_arrow:clicked(game_args.scaleCamera)

        if play_button:clicked(game_args.scaleCamera) then 
            if locked_label.text == "Unlocked" then 
                self.state = "Play"
            end 
        end 
    end 

    if self.state == "Play" then 
        self.levels[self.counter]:update(dt)
        self.levels[self.counter]:setGameArgs(game_args)
       
    end 
    --[[if self.currentLevel ~= 0 then 
        self.levels[self.currentLevel]:update(dt)
        self.levels[self.currentLevel]:setGameArgs(game_args)
        self.levels[self.currentLevel].state = self.state 
    end ]] 




end 


function LevelManager:draw() 
    
    if self.state == "selection" then 
        self.UI_Manager:draw()
    end 
    
    if self.state == "Play" then 
        self.levels[self.counter]:draw()
    end 
end 

return LevelManager 