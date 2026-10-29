

--[[
    In the entity manager go through a list of maps and load the level like that, everything will be handled by special handlers, uiManager, entityManager, backgroundManager


]]


local utf8 = require("utf8")
local globals = require("globals")
local EntityManager = require("engine.EntityManager")
local GameMath      = require("engine.GameMath")

local Player = require("game.Player")
local PlayerLiquid = require("game.PlayerLiquid")
local test_em = EntityManager:new(globals.am:get("default"))
local Camera = require("engine.Camera") 
local TilemapEditor = require("engine.TilemapEditor")

local Events = require("engine.Events") 


local WriteFile = require("engine.WriteFile") 



test_em:add(Player:new(globals.WIDTH/2-24,globals.HEIGHT/2 - 24, test_em.spritebatch))
test_em:add(PlayerLiquid:new(test_em.spritebatch,test_em))

local camera = Camera:new(0,0,globals.WIDTH,globals.HEIGHT)



camera:zoom(3,3)

--local tm = TilemapEditor:new("src/assets/maps/Overworld/Overworld1")


local states = require("game.States")


function love.load()
    
    love.keyboard.setKeyRepeat(true)

    love.graphics.setDefaultFilter("nearest","nearest")

    states:start()


    Events:load()
end 



-- text input and backspace 
function love.textinput(t) 
    globals.text_from_event = globals.text_from_event .. t 
end 

function love.keypressed(key) 
    if key == "backspace" then 
        local byteoffset = utf8.offset(globals.text_from_event,-1)
        if byteoffset then 
            globals.text_from_event = string.sub(globals.text_from_event,1,byteoffset - 1) 

        end 
    end     
end 

--global events
    
function love.resize(w,h) 

    globals.screenWidth = w 
    globals.screenHeight = h 
    
end 

function love.update(dt) 






    
    --[[local gx, gy = camera:getGlobalMousePos()

    print("GX: " .. gx .. " GY: " .. gy)]]



    --tm:update(dt)

    
    if love.keyboard.isDown("escape" ) then love.event.quit() end 

   -- test_em:update(dt)


    Events:update(dt)
    states:update(dt)

   -- camera:update(dt)
end     

function love.draw( )


    --[[camera:apply()
    test_em:draw()
    camera:unapply()]]

    --tm:draw()

    

    states:draw()

end     
