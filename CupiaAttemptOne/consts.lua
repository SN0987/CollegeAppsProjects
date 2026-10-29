local AssetManager = require("Engine.AssetManager")
local ser = require("libs.ser")
local handle_data = require("libs.handle_data")
local consts = {}


function consts:rectangleOverlap(rect_one,rect_two) 
    return (rect_one.x < rect_two.x+rect_two.w and rect_one.x+rect_one.w > rect_two.x and rect_one.y < rect_two.h+rect_two.y and rect_one.y+rect_one.h > rect_two.y) 
end 



consts.indexes = {
    bow = 1,
    gun = 1 ,
    sword = 1,
    BloodCake = 1,
}

consts.game_world_data = {
    overworld_cleared = false,
    underworld_cleared = false,
    overworld_levels_cleared = 20,
    underworld_levels_cleared = 0

}




consts.settings = {
    screen_width = 640,
    screen_height = 384, 
    fullscreen = true,
    keybinds = {}
}



consts.settings.keybinds["Drop-Armor"] = "r"
consts.settings.keybinds["Pick-Up"] = "z" 
consts.settings.keybinds["Sword-Attack"] = "x"
consts.settings.keybinds["Move-Right"] = "d"
consts.settings.keybinds["Move-Left"] = "a" 
consts.settings.keybinds["Jump"] = "w"
consts.settings.keybinds["Shoot"] = "lshift"
consts.settings.keybinds["Dash"] = "e"
consts.settings.keybinds["Drop"] = "q"
consts.settings.keybinds["Aim-Up"] = "w"
consts.settings.keybinds["Aim-Down"] = "s"

    

consts.settings = handle_data("settings.lua",consts.settings)
  
consts.game_world_data = handle_data("game_world_data.lua",consts.game_world_data)

consts.game_world_data.overworld_cleared = true 
consts.game_world_data.overworld_levels_cleared = 1
consts.WIDTH = 640 
consts.HEIGHT = 384
consts.currentWidth = consts.settings.screen_width 
consts.currentHeight = consts.settings.screen_height

consts.WORLD_WIDTH = 640*5


consts.TILE_SIZE = 16
consts.AssetManager = AssetManager:new()


consts.keys = {

}


for k,v in pairs(consts.settings.keybinds) do 
    consts.keys[k] = v 
end 
consts.screen = nil 



--put it in consts to make sure that getEntity is not being called too much
consts.player = nil 
return consts  