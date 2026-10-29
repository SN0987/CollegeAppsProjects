
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

local ui_manager = require("Engine.UI_Manager")
local entityManager = require("Engine.EntityManager")
--[[
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
    end     

]]

local fake_u = ui_manager:new()
local fake_em = entityManager:new()
return {
    {entity=Player:new(0,0,fake_u),value=-1},
    {entity=Sword:new(0,0,fake_em,fake_u),value=-2},
    {entity=BluePot:new(0,0,fake_em),value=-3},
    {entity=FlappyEnemy:new(0,0,fake_em),value=-4},
    {entity=Trap:new(0,0,64,64,"Trap",fake_em,{x_offset=0,y_offset=0,width=64,height=64},consts.AssetManager:getImage("Blender","Enemies/blender.png"),{maxFrames=4,srcY=0,fps=12,name="moving",animate=true}),value=-5},
    {entity=Trap:new(0,0,32,32,"Trigger-Trap",fake_em,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Stone-Trigger","Enemies/trigger.png"),{srcX=0,srcY=0,animate=false}),value=-6},
    {entity=PersianArmor:new(0,0,fake_em),value=-7},
    {entity=Gun:new(0,0,fake_em,fake_u),value=-8},
    {entity=KingPot:new(0,0,fake_em),value=-9},
    {entity=Bow:new(0,0,fake_em,fake_u),value=-10},
    {entity=Utensils:new(0,0,650,fake_em),value=-11},
    {entity=Trap:new(0,0,32,32,"Trap",fake_em,{x_offset=0,y_offset=0,width=32,height=32},consts.AssetManager:getImage("Spikes","Enemies/traps.png"),{srcX=0,srcY=0,animate=false}),value=-12},
    {entity= Trap:new(0,0,32,32,"Trap",fake_em,{x_offset=0,y_offset=0,width=32,height=32},consts.AssetManager:getImage("Spikes","Enemies/traps.png"),{srcX=1,srcY=0,animate=false}),value=-13},
    {entity=BloodCake:new(0,0,fake_em,fake_u),value=-14},
    {entity=MeasuringCup:new(0,0,fake_em),value=-15},
    {entity=JumperPlate:new(0,0,fake_em),value=-16},
    {entity=SamuraiArmor:new(0,0,fake_em),value=-17},
    {entity=RomanArmor:new(0,0,fake_em),value=-18},
    {entity=Flag:new(0,0,1,fake_u),value=-19},
    {entity=Trampoline:new(0,0,fake_em),value=-20},
    {entity=Trap:new(0,0,16,16,"Trap",fake_em,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=0,srcY=0,animate=false}),value=-21},
    {entity=Trap:new(0,0,16,16,"Trap",fake_em,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=1,srcY=0,animate=false}),value=-22},
    {entity=Trap:new(0,0,16,16,"Trap",fake_em,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=2,srcY=0,animate=false}),value=-23},
    {entity=Trap:new(0,0,16,16,"Trap",fake_em,{x_offset=0,y_offset=0,width=16,height=16},consts.AssetManager:getImage("Spikes-Two","Enemies/spikes.png"),{srcX=3,srcY=0,animate=false}),value=-24}
  
}