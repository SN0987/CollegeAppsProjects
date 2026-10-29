local MenuScreen = {}
local UI_Manager = require("Engine.UI_Manager")
local Button = require("Engine.Button")
local consts = require("consts")
MenuScreen.__index = MenuScreen

--no need for menu data 

--settings data 
--world data 


function MenuScreen:new() 
    local ms = setmetatable({},MenuScreen)  

    ms.UI_Manager = UI_Manager:new() 
    --function Button:new(x,y,width,height,text,size,img,color,font_color,name)

    ms.button_img = consts.AssetManager:getImage("Button", "ui/cupia_button.png")
    local button =  Button:new(consts.WIDTH/2-(166/2),consts.HEIGHT/2-(56/2)-50, 166,56, "Play", 30, ms.button_img, {r=1,g=1,b=1},{r=1,g=1,b=1},"Button")
    local buttonTwo =  Button:new(consts.WIDTH/2-(166/2),consts.HEIGHT/2-(56/2)+25, 166,56, "Settings", 30, ms.button_img, {r=1,g=1,b=1},{r=1,g=1,b=1},"Button")
    local buttonThree =  Button:new(consts.WIDTH/2-(166/2),consts.HEIGHT/2-(56/2)+100, 166,56, "Quit", 30, ms.button_img, {r=1,g=1,b=1},{r=1,g=1,b=1},"Button")
    ms.UI_Manager:addElement(button)
    ms.UI_Manager:addElement(buttonTwo)
    ms.UI_Manager:addElement(buttonThree)

    return ms 
end 


function MenuScreen:update(dt, Game) 
    self.UI_Manager:update(dt,Game.scaleCamera)

    local playButton = self.UI_Manager:getElements("Button")[1]
    local settingsButton = self.UI_Manager:getElements("Button")[2]
    local quitButton = self.UI_Manager:getElements("Button")[3]

    if quitButton:clicked(Game.scaleCamera) then 
        love.event.quit()
    end 


    if playButton:clicked(Game.scaleCamera) then 
        Game.state = "Game"
    
    end 

    if settingsButton:clicked(Game.scaleCamera) then 
        Game.state = "Settings"
    end 
end 


function MenuScreen:draw() 
    self.UI_Manager:draw()
 
end 

return MenuScreen 