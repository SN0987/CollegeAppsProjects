local globals = {}

--technically global and globals 
local AssetManager = require("engine.AssetManager")


globals.WIDTH = 1008
globals.HEIGHT = 608

globals.TILE_SIZE = 16

--only scrollx  
globals.WORLD_WIDTH = 1008 * 5 

globals.text_from_event = ""

--width contorlled by resize event
globals.screenWidth = globals.WIDTH
globals.screenHeight = globals.HEIGHT

globals.am = AssetManager:new()



--set it each level

globals.currentLevel = nil 

globals.am:add("Overworld-Background", "assets/images/overworld_background.png")
globals.am:add("default","assets/spritesheet_one.png")
globals.am:add("Arrow-Button", "assets/ui/button_arrow.png")
globals.am:add("Label-Line", "assets/ui/label_line.png")
globals.am:add("Overworld-Spritesheet", "assets/images/overworld_spritesheet.png") 


globals.gameKeys = {
}



-- the 1st index will not be impacted by key bind changes
globals.gameKeys["left"] = {'left', 'a'}  
globals.gameKeys["right"] = {'right', 'd'}
globals.gameKeys["jump"] = {'up', 'w'}
globals.gameKeys["shoot"] = "x" 
globals.gameKeys["pickup"] = "c" 


globals.keyboardStates = {}
globals.keyboardStates["space"] = false 


return globals 