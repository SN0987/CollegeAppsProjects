local consts = require("consts")
local Tile = require("Game.Tile")
local tilekeys = {}



local overworld_tile_sheet = consts.AssetManager:getImage("Overworld-Tilesheet","Overworld/tilesheet.png")
local underworld_tile_sheet = consts.AssetManager:getImage("Underworld-Tilesheet","Underworld/tilesheet.png")
--[[tilekeys.overworld = {

    --grass blocks
    {width = 16, height = 16, srcX = 10, name="Overworld-Grass-Dirt", img_args={srcX = 10, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=1,col_status="static",type="simple"}, -- normal grass block 
    {width = 16, height = 16, srcX = 1, name="Overworld-Grass-Top", img_args={srcX = 1, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=2,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Grass-Top-Left", img_args={srcX = 0, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=3,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Grass-Top-Right", img_args={srcX = 2, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=4,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 4, name="Overworld-Grass-Left", img_args={srcX = 9, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=5,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 5, name="Overworld-Grass-Right", img_args={srcX = 11, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=6,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 6, name="Overworld-Grass-Bottom", img_args={srcX = 7, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=7,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 7, name="Overworld-Grass-Bottom-Left", img_args={srcX = 6, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=8,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 8, name="Overworld-Grass-Bottom-Right", img_args={srcX = 8, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=9,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 1, name="Overworld-Grass-Top-Two", img_args={srcX = 4, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=10,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Grass-Top-Left-Two", img_args={srcX = 3, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=11,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Grass-Top-Right-Two", img_args={srcX = 5, srcY = 3, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=12,col_status="static",type="simple"},

    --stone blocks 
    {width = 16, height = 16, srcX = 10, name="Overworld-Stone-Dirt", img_args={srcX = 1, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=21,col_status="static",type="simple"}, -- normal grass block 
    {width = 16, height = 16, srcX = 1, name="Overworld-Stone-Top", img_args={srcX = 0, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=22,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Stone-Top-Left", img_args={srcX = 8, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=23,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Stone-Top-Right", img_args={srcX = 13, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=24,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 4, name="Overworld-Stone-Left", img_args={srcX = 3, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=25,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 5, name="Overworld-Stone-Right", img_args={srcX = 6, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=26,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 6, name="Overworld-Stone-Bottom", img_args={srcX = 7, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=27,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 7, name="Overworld-Stone-Bottom-Left", img_args={srcX = 14, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=28,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 8, name="Overworld-Stone-Bottom-Right", img_args={srcX = 15, srcY = 6, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=29,col_status="static",type="simple"},

    --dirt 
    {width = 16, height = 16, srcX = 10, name="Overworld-Dirt-Dirt", img_args={srcX = 0, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=41,col_status="none",type="simple"}, -- normal grass block 
    {width = 16, height = 16, srcX = 1, name="Overworld-Dirt-Top", img_args={srcX = 1, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=42,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Dirt-Top-Left", img_args={srcX = 5, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=43,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 2, name="Overworld-Dirt-Top-Right", img_args={srcX = 6, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=44,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 4, name="Overworld-Dirt-Left", img_args={srcX = 2, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=45,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 5, name="Overworld-Dirt-Right", img_args={srcX = 3, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=46,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 6, name="Overworld-Dirt-Bottom", img_args={srcX = 4, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=47,col_status="none",layer={width = 16, height = 16, srcX = 8, name="Stone-Layer", img_args={srcX = love.math.random(0,2), srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=53,col_status="static",type="simple"},type="simple"},
    {width = 16, height = 16, srcX = 7, name="Overworld-Dirt-Bottom-Left", img_args={srcX = 8, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=48,col_status="none",layer={width = 16, height = 16, srcX = 8, name="Stone-Layer", img_args={srcX = love.math.random(0,2), srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=53,col_status="static",type="simple"},type="simple"},
    {width = 16, height = 16, srcX = 8, name="Overworld-Dirt-Bottom-Right", img_args={srcX = 7, srcY = 4, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=49,col_status="none",layer={width = 16, height = 16, srcX = 8, name="Stone-Layer", img_args={srcX = love.math.random(0,2), srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=53,col_status="static",type="simple"},type="simple"},

    --bare stones
    {width = 16, height = 16, srcX = 6, name="Stone-One", img_args={srcX = 0, srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=51,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 7, name="Stone-Two", img_args={srcX = 1, srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=52,col_status="static",type="simple"},
    {width = 16, height = 16, srcX = 8, name="Stone-Three", img_args={srcX = 2, srcY = 7, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=53,col_status="static",type="simple"},

    --roses
    {width = 16, height = 16, srcX = 6, name="Red-Rose", img_args={srcX = 0, srcY = 5, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=54,col_status="none",type="simple"},
    {width = 16, height = 16, srcX = 7, name="Blue-Rose", img_args={srcX = 1, srcY = 5, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=55,col_status="none",type="simple"},

    --bushes
    {width = 64, height = 64, srcX = 6, name="Bush-One", img_args={srcX = 0, srcY = 1, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=56,col_status="none",type="simple"},
    {width = 64, height = 64, srcX = 7, name="Bush-Two", img_args={srcX = 1, srcY = 1, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=57,col_status="none",type="simple"},
    {width = 64, height = 64, srcX = 8, name="Bush-Three", img_args={srcX = 2, srcY =1 , srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=58,col_status="none",type="simple"},
    --grass
    {width = 16, height = 16, srcX = 8, name="Grass", img_args={srcX = 0, srcY =2 , srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=59,col_status="none", anim_args={maxFrames=5,fps=8,name="Moving"},type="simple"},
    {width = 16, height = 16, srcX = 0, name="Moving-Platform-Dirt", img_args={srcX = 1, srcY = 0, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=60,col_status="dynamic",type="moving",type_args={speed={x=100,y=0},time=5}},
    {width = 16, height = 16, srcX = 0, name="Moving-Platform-Dirt-Left", img_args={srcX = 2, srcY = 0, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=61,col_status="dynamic",type="moving",type_args={speed={x=100,y=0},time=5}},
    {width = 16, height = 16, srcX = 0, name="Moving-Platform-Dirt-Right", img_args={srcX = 3, srcY = 0, srcWidth = 16,srcHeight = 16, img=overworld_tile_sheet, width=16,height=16},value=62,col_status="dynamic",type="moving",type_args={speed={x=100,y=0},time=5}},

}]]

--function Tile:new(x,y,width,height,col_status,type,name,img_args,anim_args,value,type_args)

--overwolrd key 
tilekeys.overworld = {}
local index = 5
for i = 0, 3 do 

    local tile = Tile:new(0,0,16,16,"dynamic","moving","Moving-Platform: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+0,srcWidth=16,srcHeight=16},nil,i+1,{speed={x=100,y=0},time=5})
    table.insert(tilekeys.overworld,tile)
end 


for i = 0, 2 do 

    local tile = Tile:new(0,0,64,64,"none","Tile","Bushes: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+1,srcWidth=16,srcHeight=16},nil,4+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 



local grass = Tile:new(0,0,16,16,"none","Tile","Grass",{img=overworld_tile_sheet,srcX=0,srcY=index+2,srcWidth=16,srcHeight=16},{maxFrames=5,fps=8,name="Moving"},8,nil)

table.insert(tilekeys.overworld,grass)


for i = 0, 11 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Overworld-Grass-Dirt: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+3,srcWidth=16,srcHeight=16},nil,8+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 

for i = 0, 8 do 
    local tile = Tile:new(0,0,16,16,"none","Tile","Overworld-Light-Dirt: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+4,srcWidth=16,srcHeight=16},nil,20+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 

for i = 0, 1 do 
    local tile = Tile:new(0,0,16,16,"none","Tile","Rose: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+5,srcWidth=16,srcHeight=16},nil,29+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 


for i = 0, 15 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Stone-Block: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+6,srcWidth=16,srcHeight=16},nil,31+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 

for i = 0, 2 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Stones: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=index+7,srcWidth=16,srcHeight=16},nil,47+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 



local log = Tile:new(0,0,96,42,"dynamic","moving","Moving-Log",{img=overworld_tile_sheet,srcX=0,srcY=0,srcWidth=32,srcHeight=16},nil,51,{speed={x=220,y=0},time=4})

table.insert(tilekeys.overworld,log)

for i = 0, 8 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Cave: " .. i,{img=overworld_tile_sheet,srcX=i,srcY=1,srcWidth=16,srcHeight=16},nil,52+i+1,nil)
    table.insert(tilekeys.overworld,tile)
end 
local fence = Tile:new(0,0,16,16,"static","Tile","Fence",{img=overworld_tile_sheet,srcX=0,srcY=4,srcWidth=16,srcHeight=16},nil,62,nil)

table.insert(tilekeys.overworld,fence)




tilekeys.underworld = {}


for i = 0, 2 do 
    local tile = Tile:new(0,0,96,96,"none","Tile","Dark-Tree: " .. i,{img=underworld_tile_sheet,srcX=i,srcY=0,srcWidth=32,srcHeight=32},nil,i+1,nil)
    table.insert(tilekeys.underworld,tile)
end 

for i = 0, 8 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Red-Dirt: " .. i,{img=underworld_tile_sheet,srcX=i,srcY=6,srcWidth=16,srcHeight=16},nil,3+i+1,nil)
    table.insert(tilekeys.underworld,tile)
end 

for i = 0, 8 do 
    local tile = Tile:new(0,0,16,16,"static","Tile","Blue-Dirt: " .. i,{img=underworld_tile_sheet,srcX=i,srcY=3,srcWidth=16,srcHeight=16},nil,12+i+1,nil)
    table.insert(tilekeys.underworld,tile)
end 


for i = 0, 2 do 
    local tile = Tile:new(0,0,64,64,"none","Tile","Blue-Bush" .. i,{img=underworld_tile_sheet,srcX=i,srcY=4,srcWidth=16,srcHeight=16},nil,21+i+1,nil)
    table.insert(tilekeys.underworld,tile)
end 

return tilekeys 