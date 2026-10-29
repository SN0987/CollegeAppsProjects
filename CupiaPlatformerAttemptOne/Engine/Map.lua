
local Map = {}
local Entity = require("Engine.Entity")
local Player = require("Game.Player")
local Sword = require("Game.Sword")
local Tile = require("Game.Tile")
local consts = require("consts")
local EquipmentManager = require("Game.EquipmentManager")
local BluePot = require("Game.BluePot")
local FlappyEnemy = require("Game.FlappyEnemy")
local Trap = require("Game.Trap")
local PersianArmor = require("Game.PersianArmor")
local Gun = require("Game.Gun")
local KingPot = require("Game.KingPot")
local Bow = require("Game.Bow")
local Utensils = require("Game.Utensils")
local BloodCake = require("Game.BloodCake")
local MeasuringCup = require("Game.MeasuringCup")
local JumperPlate = require("Game.JumperPlate")
local ArmorManager = require("Game.ArmorManager")
local SamuraiArmor = require("Game.SamuraiArmor")
local RomanArmor = require("Game.RomanArmor")
local Flag = require("Game.Flag")
local Trampoline = require("Game.Trampoline")

Map.__index = Map 


--[[
    tilekey set up 
    style can be "block" , "vegetation", "interactive"
    tilekey = {
        {img,dimensions,src_rect,col_status,value,color,style}
    }
]]
function Map:new(file_name,column,row) 
    local m = setmetatable({},Map)

    m.tiles = {}

    local chunk, err = love.filesystem.load(file_name)
    if chunk then
        m.tile_map = chunk()
        
    else
        print("Error loading map:", err)
    end

    

    m.row = row
    m.column = column
    

    --[[local file = love.filesystem.read(file_name)

    for line in file:gmatch("[^\r\n]+") do 
        local row = {}
        for value in line:gmatch("[^,]+") do
            table.insert(row, tonumber(value)) -- Convert to number and insert into row
        end 
        table.insert(m.tile_map,row)
    end]]

    return m 
end 


--ignore this one 
function Map:loadTileSet(tile_key,i,j,entityManager) 
    for k,v in ipairs(tile_key) do 
        if self.tile_map[i][j] == v.value then 
            local tile = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.width,v.height,v.collider_status,v.type,v.id,v.img_args,v.anim_args,v.value,v.type_args) 


            entityManager:add(tile)


            --[[if v.layer == nil then 
                if v.anim_args == nil then 
                    tile = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.width,v.height,v.col_status,v.type,v.name,v.img_args,nil,v.value,v.type_args)
                else
                    tile = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.width,v.height,v.col_status,v.type,v.name,v.img_args,v.anim_args,v.value,v.type_args)
                end 
                entityManager:add(tile)
            else
                local tile_two 
                if v.layer.anim_args == nil then 
                    tile_two = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.layer.width,v.layer.height,v.layer.col_status,v.type,v.layer.name,v.layer.img_args,nil,v.value,v.type_args)
                else 
                    tile_two = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.layer.width,v.layer.height,v.layer.col_status,v.type,v.layer.name,v.layer.img_args,v.layer.anim_args,v.value,v.type_args)
                end 
                if v.anim_args == nil then 
                    tile = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.width,v.height,v.col_status,v.type,v.name,v.img_args,nil,v.value,v.type_args)
                else
                    tile = Tile:new((j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,v.width,v.height,v.col_status,v.type,v.name,v.img_args,v.anim_args,v.value,v.type_args)
                end 

                entityManager:add(tile)
                entityManager:add(tile_two)
            end ]]

            
        end 
    end 
end 
--use this one
function Map:addTileSet(tile_key,entityManager) 
    for i = 1, self.row do 
        for j = 1, self.column do 
            self:loadTileSet(tile_key,i,j,entityManager)
        end 
    end 
end 

function Map:loadEntity(entityManager,level,i,j,ui_manager,counter)
    local equipmentManager = entityManager:getEntity("EquipmentManager")

    local armorManager = entityManager:getEntity("ArmorManager")

    if armorManager == nil then 
        entityManager:add(ArmorManager:new())
        armorManager = entityManager:getEntity("ArmorManager")
    end 

    if equipmentManager == nil then 
            entityManager:add(EquipmentManager:new())
            equipmentManager = entityManager:getEntity("EquipmentManager")
            equipmentManager.entityManager = entityManager
            equipmentManager.loaded = true     
       
    end 
    if self.tile_map[i][j] == -1 then 
        local player = Player:new((j-1)*16,(i-1)*16,ui_manager)
       
        entityManager:add(player)

        
        entityManager:swapManagersWithPlayer()
      
      

       
       

    elseif self.tile_map[i][j] == -2 then 

     
        local sword = Sword:new((j-1)*16,(i-1)*16,entityManager, ui_manager)
        equipmentManager:add(sword)
    elseif self.tile_map[i][j] == -3 then 
        local bluepot = BluePot:new((j-1)*16,(i-1)*16,entityManager)
        bluepot.level = level

       -- print(bluepot.level.pause_table.pause)
        entityManager:add(bluepot)

    elseif self.tile_map[i][j] == -4 then 
        local flappingenemy = FlappyEnemy:new((j-1)*16,(i-1)*16,entityManager)
        flappingenemy.level = level 

        entityManager:add(flappingenemy)

    elseif self.tile_map[i][j] == -5 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,64,64,"Trap",entityManager,{x_offset=0,y_offset=0,width=64,height=64},consts.AssetManager:getImage("Blender","Enemies/blender.png"),{maxFrames=4,srcY=0,fps=12,name="moving",animate=true})
        Trap.level = level 
        entityManager:add(Trap)

    elseif self.tile_map[i][j] == -6 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,32,32,"Trigger-Trap",entityManager,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Stone-Trigger","Enemies/trigger.png"),{srcX=0,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    elseif self.tile_map[i][j] == -7 then 
        local PersianArmor = PersianArmor:new((j-1)*16,(i-1)*16,entityManager)
        armorManager:add(PersianArmor)
    elseif self.tile_map[i][j] == -8 then 
        local gun = Gun:new((j-1)*16,(i-1)*16,entityManager,ui_manager)
        equipmentManager:add(gun)
    elseif self.tile_map[i][j] == -9 then 
        local kingpot = KingPot:new((j-1)*16,(i-1)*16,entityManager)
        kingpot.level = level

       -- print(bluepot.level.pause_table.pause)
        entityManager:add(kingpot)

    elseif self.tile_map[i][j] == -10 then 
        local bow = Bow:new((j-1)*16,(i-1)*16,entityManager,ui_manager)
        
    
       -- print(bluepot.level.pause_table.pause)
        equipmentManager:add(bow)
    elseif self.tile_map[i][j] == -11 then 
        local utensil = Utensils:new((j-1)*16,(i-1)*16,650,entityManager)
        
        entityManager:add(utensil)

    elseif self.tile_map[i][j] == -12 then 

        local Trap = Trap:new((j-1)*16,(i-1)*16,32,32,"Trap",entityManager,{x_offset=0,y_offset=0,width=32,height=32},consts.AssetManager:getImage("Spikes","Enemies/traps.png"),{srcX=0,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    elseif self.tile_map[i][j] == -13 then 

        local Trap = Trap:new((j-1)*16,(i-1)*16,32,32,"Trap",entityManager,{x_offset=0,y_offset=0,width=32,height=32},consts.AssetManager:getImage("Spikes","Enemies/traps.png"),{srcX=1,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)

    elseif self.tile_map[i][j] == -14 then 
        local BloodCake = BloodCake:new((j-1)*16,(i-1)*16,entityManager,ui_manager)
        entityManager:add(BloodCake)
    elseif self.tile_map[i][j] == -15 then 
        local MeasuringCup = MeasuringCup:new((j-1)*16,(i-1)*16,entityManager)
        entityManager:add(MeasuringCup)
    elseif self.tile_map[i][j] == -16 then 
        local JumperPlate = JumperPlate:new((j-1)*16,(i-1)*16,entityManager)
        entityManager:add(JumperPlate)

    elseif self.tile_map[i][j] == -17 then 
        local SamuraiArmor = SamuraiArmor:new((j-1)*16,(i-1)*16,entityManager)
        armorManager:add(SamuraiArmor)
    elseif self.tile_map[i][j] == -18 then 
        local RomanArmor = RomanArmor:new((j-1)*16,(i-1)*16,entityManager)
        armorManager:add(RomanArmor)
    elseif self.tile_map[i][j] == -19 then 
        local Flag = Flag:new((j-1)*16,(i-1)*16,counter,ui_manager)
        entityManager:add(Flag)
    elseif self.tile_map[i][j] == -20 then 
        local Trampoline = Trampoline:new((j-1)*16,(i-1)*16,entityManager)
        entityManager:add(Trampoline)
    elseif self.tile_map[i][j] == -21 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,16,16,"Trap",entityManager,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=0,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    elseif self.tile_map[i][j] == -22 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,16,16,"Trap",entityManager,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=1,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    elseif self.tile_map[i][j] == -23 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,16,16,"Trap",entityManager,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=2,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    elseif self.tile_map[i][j] == -24 then 
        local Trap = Trap:new((j-1)*16,(i-1)*16,16,16,"Trap",entityManager,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=3,srcY=0,animate=false})
        Trap.level = level 
        entityManager:add(Trap)
    end     

end 

function Map:addEntity(entityManager,level,ui_manager,counter) 
    for i = 1, self.row do 
        for j = 1,self.column do 
            self:loadEntity(entityManager,level,i,j,ui_manager,counter)
            
        end 
    end 
end 

function Map:update(dt,camera) 

end

function Map:draw(camera) 
 
end 





return Map 