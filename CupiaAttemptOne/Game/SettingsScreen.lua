local SettingsScreen = {}
SettingsScreen.__index = SettingsScreen 

local UI_Manager = require("Engine.UI_Manager")
local Options = require("Engine.Options")
local Label = require("Engine.Label")
local consts = require("consts")
local ser = require("libs.ser")
local Button = require("Engine.Button")

--check if key is pressed to bind 
local key_input = {
    key = "",
    selecting = false,
    already_selected = false 
}
--data paths: Cupia/Menu , Cupia/Settings, Cupia/Overworld, Cupia/




--[[

    settings = {
    
        screen_width,
        screen_height,
        keybinds
    }
]]

--love.filesystem.remove("Cupia/Settings/settings.lua")



--3 sections 

-- How To Play 

--Keybinds 

-- Controller Bind 
-- Screen Resolution 

function SettingsScreen:new() 
    local ss = setmetatable({},SettingsScreen)


    ss.UI_Manager = UI_Manager:new()


    --function Options:new(name,font_path,sizes,x,margin,color) 
   
    ss.counter = 1  

    local options = Options:new("Resolution-Options","assets/fonts/font_basic.ttf",{minSize=35,maxSize=55},205,35,{r=1,g=1,b=1})

    --function Options:addOption(name, text,y) 
    options:addOption("option-one","640x384",100)
    options:addOption("option-two","960x576",200)
    options:addOption("option-three","Fullscreen",300)

    --Button:new(x,y,width,height,text,size,img,color,font_color,name)

    local left_key_img = consts.AssetManager:getImage("Left-Arrow","ui/left_arrow_key.png")
    local right_key_img = consts.AssetManager:getImage("Right-Arrow","ui/right_arrow_key.png")

    local leftKey = Button:new(4,0,48,48,"",1,left_key_img,{r=1,g=1,b=1},{r=1,g=1,b=1},"Left-Arrow")

    leftKey:toCenterY()
    local rightKey = Button:new(consts.WIDTH-52,0,48,48,"",1,right_key_img,{r=1,g=1,b=1},{r=1,g=1,b=1},"Right-Arrow")
    rightKey:toCenterY()


    if consts.settings.screen_width == 640 then 
        options:setCurrentOption("option-one")
    end 

    if consts.settings.screen_width == 960 then 
        options:setCurrentOption("option-two")
    end 

    if consts.settings.screen_width == love.graphics.getWidth() then 
        options:setCurrentOption("option-three")
    end 


    
    --Label:new(x,y,text,size,font_path,color,max_bound,name) 

    -- Resolution stuff
    local please_restart_label = Label:new(consts.WIDTH/2,consts.HEIGHT-25, "Restart the Game to Show Changes... Click Enter To Save",15,"assets/fonts/font_basic.ttf",{r=1,g=1,b=1},1000,"Restart-Label")
    local resolution_title = Label:new(consts.WIDTH/2,20,"Screen-Resolution", 65, "assets/fonts/font_basic.ttf",{r=1,g=1,b=1},800,"R-Title")
    please_restart_label.show = false 
    resolution_title:centerX()
    ss.UI_Manager:addElement(options)
    ss.UI_Manager:addElement(please_restart_label)

    ss.UI_Manager:addElement(leftKey)
    ss.UI_Manager:addElement(rightKey)
    ss.UI_Manager:addElement(resolution_title)

    -- 1 is Screen Resolution 3 is How To Play 2 Keybinds 

    -- Keybinds 

    local keybinds_title = Label:new(consts.WIDTH/2,15,"Keybinds", 45, "assets/fonts/font_basic.ttf",{r=1,g=1,b=1},800,"K-Title")

    keybinds_title:centerX() 

    local keybinds_options = Options:new("Keybinds-Options","assets/fonts/font_basic.ttf",{minSize=20,maxSize=25},205,35,{r=1,g=1,b=1})

    local enter_bind  = Label:new(10,consts.HEIGHT-20,"Press Enter To Change..", 15, "assets/fonts/font_basic.ttf",{r=1,g=1,b=1},800,"Enter-Bind")

    local i = 1 
    for k,v in pairs(consts.settings.keybinds) do 
        i = i + 1
        keybinds_options:addOption(k,k..":"..v,18+(i*28))
    end 

    keybinds_title.show = false 
    keybinds_options.show = false 
    ss.UI_Manager:addElement(keybinds_title)
    ss.UI_Manager:addElement(keybinds_options)
    ss.UI_Manager:addElement(enter_bind)
    ss.notEntered = false 

    ss.leftArrowClicked = false 
    ss.rightArrowClicked = false 

    ss.selectingKey = false 
    ss.key = ""
    return ss 
    
end 


function love.keypressed(key,unicode) 
    if key_input.selecting then 
        key_input.key = key  
    end 
end 
function SettingsScreen:update(dt,Game)


    local options = self.UI_Manager:getElements("Resolution-Options")[1]

    local please_restart_label = self.UI_Manager:getElements("Restart-Label")[1]

    local left_arrow = self.UI_Manager:getElements("Left-Arrow")[1]
    local right_arrow = self.UI_Manager:getElements("Right-Arrow")[1]
    local r_title = self.UI_Manager:getElements("R-Title")[1]

    local keybinds_options = self.UI_Manager:getElements("Keybinds-Options")[1]
    local k_title = self.UI_Manager:getElements("K-Title")[1]

    local enter_bind = self.UI_Manager:getElements("Enter-Bind")[1]
    options:setToCenter(Game.screen)
    keybinds_options:setToCenter(Game.screen)



    
    if self.counter == 1 then 

        options.show = true 

        if options:returnOption() == "option-one" then 
            consts.settings.screen_width = 640
            consts.settings.screen_height = 384 
        end

        if options:returnOption() == "option-two" then 
            consts.settings.screen_width = 960
            consts.settings.screen_height = 576
        end

        if options:returnOption() == "option-three" then 
            consts.settings.fullscreen = true 

        end

        if love.keyboard.isDown("return") and not self.notEntered then 
            love.filesystem.write("settings.lua",ser(consts.settings))

        end 


        self.notEntered = love.keyboard.isDown("return")

        please_restart_label.show = true 
        r_title.show = true 
        keybinds_options.show = false
        k_title.show = false  
        enter_bind.show = false 
        please_restart_label:centerX()

    elseif self.counter == 2 then 

        if love.keyboard.isDown("return") then 
            --Element:setText(x,y, string_text, size, color, font_path)
            

            if key_input.selecting == false then 
                enter_bind:setText(10,consts.HEIGHT-20,"Click Any Key..",15,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
                key_input.selecting = true 
                key_input.already_selected = false 
            end 
          
        end 

        if key_input.selecting then 
            if key_input.key ~= "" then 
                

                for k,v in pairs(consts.keys) do 
                    if key_input.key == v then 
                        key_input.already_selected = true 
                        key_input.selecting = false 
                        key_input.key = ""
                        break
                    end 
                end 
                
        
                if not key_input.already_selected  then 

                    local option_label = keybinds_options:getCurrentOptionLabel()

                    local broken_string = {}
                            

                    for i in string.gmatch(option_label.text,'([^'..':'..']+)') do 
                        table.insert(broken_string,i)
                    end 

                    local k_name = broken_string[1]

                    broken_string[2] = key_input.key

                    option_label.text = broken_string[1]..":"..broken_string[2]
                    key_input.key = ""

                    key_input.selecting = false
                    consts.keys[k_name] = broken_string[2]
                    consts.settings.keybinds[k_name] = broken_string[2]
                    
                    love.filesystem.write("settings.lua",ser(consts.settings))
                else
                    print("already selected")
                end 
                
            end 

        elseif not key_input.selecting and not key_input.alreday_selected  then 
            enter_bind:setText(10,consts.HEIGHT-20,"Press Enter To Change..",15,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
        end 

        if key_input.already_selected then 
            enter_bind:setText(10,consts.HEIGHT-20,"Ooops Key Already Taken.. Try Again .. Click Enter ..",15,{r=1,g=1,b=1},"assets/fonts/font_basic.ttf")
        end 

        options.show = false 
        please_restart_label.show = false 
        r_title.show = false 

        keybinds_options.show = true 
        k_title.show = true 
        enter_bind.show = true 
    elseif self.counter == 3 then 
        options.show = false 
        please_restart_label.show = false 
        r_title.show = false 
        keybinds_options.show = false
        k_title.show = false
        enter_bind.show = false 
    end 


    if right_arrow:clicked(Game.scaleCamera)  and not self.rightArrowClicked then 
        if self.counter < 3 then 
            self.counter = self.counter + 1
        end 
    end 

    self.rightArrowClicked = right_arrow:clicked(Game.scaleCamera)

    if left_arrow:clicked(Game.scaleCamera) and not self.leftArrowClicked then 
        if self.counter > 1 then 
            self.counter = self.counter - 1
        end 
    end 

    self.leftArrowClicked = left_arrow:clicked(Game.scaleCamera)
    

    if love.keyboard.isDown("backspace") then 
        Game.state = "Menu"
    end 

    
    self.UI_Manager:update(dt,Game.scaleCamera)
end 

function SettingsScreen:draw() 
    self.UI_Manager:draw()
end 

return SettingsScreen 