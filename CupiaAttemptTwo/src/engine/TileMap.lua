local TileMap = {}
local WriteFile = require("engine.WriteFile")
local globals = require("globals")
local Player = require("game.Player") 
local Tile = require("game.Tile") 
local PlayerLiquid = require("game.PlayerLiquid")
local AnimatableTile = require("game.AnimatableTile")
local Consumable     = require("game.Consumable")




TileMap.__index = TileMap 


--this file must be edited if being reused with its 
function TileMap:new(dir, entitymanager) 
    local t = setmetatable({}, TileMap) 

    t.dir = dir 

    t.entitymanager = entitymanager
 


    t.playerAdded = false 

    return t 
end 


function TileMap:loadLayer(num)
    
    local layer = WriteFile.readTable2D(self.dir .. "/layer" .. tostring(num) .. ".lua")
    
    
    local row = #layer 
    local col = #layer[1]
    local playerX = 0 
    local playerY  = 0

    for i = 1, row do 
        for j = 1, col do  

            local y = (i-1)*globals.TILE_SIZE

            local x = (j-1)*globals.TILE_SIZE

         

            local tileNum = layer[i][j]
            if tileNum  == 1 then 

                playerX = x 
                playerY = y 

               
            end 

            if tileNum == 2 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=0,y=80,width=16,height=16},"Light-Dirt-Grass",self.entitymanager.spritebatch,"static"))
            end    
            
            if tileNum == 3 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=16,y=80,width=16,height=16},"Light-Dirt-Bottom-Left",self.entitymanager.spritebatch,"static"))
            end  
               
            if tileNum == 4 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=32,y=80,width=16,height=16},"Light-Dirt-Bottom",self.entitymanager.spritebatch,"static"))
            end  

            if tileNum == 5 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=48,y=80,width=16,height=16},"Light-Dirt-Bottom-Right",self.entitymanager.spritebatch,"static"))
            end  

            if tileNum == 6 then 
                --AnimatableTile:new(x,y, width,height, spritebatch, col_status, srcRect,id)  
                self.entitymanager:add(AnimatableTile:new(x,y,16,16,self.entitymanager.spritebatch, "none",{x=0,y = 96, width = 16, height = 16, maxFrames=5, fps=8},"grass"))
            end 

            if tileNum == 7 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=0,y=112,width=16,height=16},"Red-Rose",self.entitymanager.spritebatch,"none"))

            end  

            
            if tileNum == 8 then 
                self.entitymanager:add(Tile:new(x,y,16,16,{x=16,y=112,width=16,height=16},"Blue-Rose",self.entitymanager.spritebatch,"none"))
                
            end  

            if tileNum == 12 then
                --function Sprite:new(x,y,width,height,id, src_rect,sx,sy, spritebatch) 
                self.entitymanager:add(Consumable:new(x,y,16,16,"Consumable",{x=16,y=112,width=16,height=16},1,1,self.entitymanager.spritebatch))
            end
        end 
    end 

    --load at the end so for rendering purposes
    if not self.playerAdded then 
        self.entitymanager:add(Player:new(playerX,playerY,self.entitymanager.spritebatch)) 
        self.entitymanager:add(PlayerLiquid:new(self.entitymanager.spritebatch, self.entitymanager))
        self.playerAdded = true
    end 



end 


--all levels might be 3 layers


function TileMap:loadAllLayers()
    
    for i = 1, 3 do
        local layer = WriteFile.readTable2D(self.dir .. "/layer" .. tostring(i) .. ".lua")

        
        if layer ~= nil then 
          
            self:loadLayer(i) 
        end 
       
    end 


end 


return TileMap 