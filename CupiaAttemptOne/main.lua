local Level = require("Engine.Level")
local LevelManager = require("Engine.LevelManager")
local Tile = require("Game.Tile")
local consts = require("consts")
local tilekeys = require("Game.tilekeys")
local UI_Manager = require("Engine.UI_Manager")
local Button = require("Engine.Button")
local InfoText = require("Engine.InfoText")
local Label = require("Engine.Label")
local tile_map_editor = require("Engine.tilemap_editor")

local MenuScreen = require("Game.MenuScreen")
local SettingsScreen = require("Game.SettingsScreen")
local GameScreen = require("Game.GameScreen")

local camera = require("Engine.Camera")




love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setCursor(love.mouse.newCursor("assets/images/Weapons/crosshair.png",0,0))


local Game = {

}

Game.scaleCamera = camera:new(0,0,consts.WIDTH,consts.HEIGHT)


Game.state = "Menu"
Game.MenuScreen = MenuScreen:new() 
Game.GameScreen = GameScreen:new(Game)
Game.SettingsScreen = SettingsScreen:new()





--local t = tile_map_editor:new("Cupia/assets/maps/Underworld/2.lua",consts.WORLD_WIDTH/consts.TILE_SIZE,consts.HEIGHT/consts.TILE_SIZE)


function love.load( )
   --t:add(tilekeys.overworld)
   --t:addEntityKey(require("Game.entity_key"))
end 

local spacePressed = false 
function love.update(dt) 



    if love.keyboard.isDown("escape") then 
        love.event.quit() 
    end 

    
    if Game.state == "Game" then 
        Game.GameScreen:update(dt,Game)
    end 
    
    if Game.state == "Menu" then 

        Game.MenuScreen:update(dt,Game)
    end 

    if Game.state == "Settings" then 
        Game.SettingsScreen:update(dt,Game)
    end 

    

    

    Game.scaleCamera:update(dt)
 
   
    --t:update(dt,Game.screen)
end 


function love.draw( )

    
    
   
    
    Game.scaleCamera:scale(Game.screen)
    Game.scaleCamera:apply()
    if Game.state == "Game" then 
        Game.GameScreen:draw()
    end 

    if Game.state == "Menu" then 
        Game.MenuScreen:draw()
    end
    if Game.state == "Settings" then 
        Game.SettingsScreen:draw()
    end 
   
    Game.scaleCamera:unapply()
    Game.scaleCamera:unscale(Game.screen)

    --t:draw()

 
end 