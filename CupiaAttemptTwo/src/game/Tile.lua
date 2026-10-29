local Sprite = require("engine.Sprite")
local globals = require("globals")
local Tile = setmetatable({} , {__index=Sprite})
Tile.__index = Tile


function Tile:new(x,y,width,height,src_rect,id, spritebatch,col_status)
    local t = setmetatable(Sprite:new(x,y,width,height,id,src_rect,width/globals.TILE_SIZE,height/globals.TILE_SIZE,spritebatch ),Tile)

    t.col_status = col_status

    return t 
end     

function Tile:update(dt)
    
end 

function Tile:draw() 


end 


return Tile

