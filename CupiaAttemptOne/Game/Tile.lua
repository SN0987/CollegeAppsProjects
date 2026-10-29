
local Entity = require("Engine.Entity")
local Animator = require("Engine.Animator")
local Tile = setmetatable({},{__index=Entity})
local Projectiles = require("Game.Projectiles")
Tile.__index = Tile 

love.graphics.setDefaultFilter("nearest","nearest")

--{img_args = {srcX,srcY,srcWidth,srcHeight}}

-- anim_args = {maxFrames,fps name}
local globalMovementTimer = 0
--[[
    types: simple, moving, traps
]]
function Tile:new(x,y,width,height,col_status,type,name,img_args,anim_args,value,type_args) 
    local tile = setmetatable(Entity:new(x,y,width,height,name,col_status,nil),Tile)

    tile.type = type
    tile.img_args = img_args 
    tile.value = value

    --simple or dynamic tiles like coins 

    tile.scaleX = width/img_args.srcWidth 
    tile.scaleY = height/img_args.srcHeight 

    tile.quad = love.graphics.newQuad(tile.img_args.srcX*tile.img_args.srcWidth,tile.img_args.srcY*tile.img_args.srcHeight,tile.img_args.srcWidth,tile.img_args.srcHeight,tile.img_args.img:getWidth(),tile.img_args.img:getHeight())

    tile.anim_args = anim_args

    tile.animator = Animator:new()
    tile.gravity = 0
    tile.accelGravity = 0
    tile.is_col = false
    if anim_args ~= nil then 
        tile.animator:add(img_args.img,img_args.srcY,16,16,anim_args.name,anim_args.fps,anim_args.maxFrames)
        tile.animator:setName(anim_args.name)

        if tile.type == "Water" then 
            tile.animator:add(img_args.img,img_args.srcY+1,16,16,"Splash",6,4)
            
        end 
    end 



    if type_args ~= nil then 
        tile.type_args = type_args
        tile.type_args.counter = 0
    
    end 
  


    return tile 
end 


--[[

    moving:
    {speed, time }
]]

function Tile:setTypeArgs(type_args ) 
    self.type_args = type_args 
    self.type_args.counter = 0 
end 

function Tile:update(dt,camera) 

    if self.anim_args ~= nil then 
        self.animator:update(dt)
    end 

    if self.type == "moving" then 

        self.vel.x = self.type_args.speed.x 
        self.vel.y = self.type_args.speed.y 
        self.type_args.counter = self.type_args.counter + dt

        if self.type_args.counter >= self.type_args.time then 
            self.type_args.counter =0 
            self.type_args.speed.x = self.type_args.speed.x * -1 
            self.type_args.speed.y = self.type_args.speed.y * -1 
        end 
   

    end 



  
end 


function Tile:draw(camera) 

    
    if self.anim_args == nil then 
        love.graphics.draw(self.img_args.img,self.quad,self.x,self.y,0,self.scaleX,self.scaleY)
    else 
        self.animator:draw(self.img_args.img,self.x,self.y,self.scaleX,self.scaleY)
    end 

    if self.type == "trap" then 
        self.projectiles:draw()
    end 
    

    --love.graphics.setColor(1.0,1.0,1.0,1.0)
    --love.graphics.rectangle("fill",self.x-camera.x,self.y-camera.y,self.width,self.height )
end 


return Tile 