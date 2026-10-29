local Enemy = require("Game.Enemy")
local Projectiles = require("Game.Projectiles")
local Trap = setmetatable({},{__index=Enemy})
local consts = require("consts")
Trap.__index = Trap 


--[[

    hitbox_args = {
    
        x_offset,
        y_offset,
        width,
        height,

    }
    
    anim_args = {
        srcY,
        srcX -- optional
        maxFrames,
        animate,
        fps,
        name
    }

    types = "Trigger-Trap", "Trap", "Animatable-Trap"
]]


function Trap:new(x,y,width,height,types,em,hitbox_args,img,anim_args)
    
    local t = setmetatable(Enemy:new(x,y,width,height,type,em),Trap)

    t.collider_status = "none"
    
    t.type = types
    t.hitbox_args = hitbox_args 
    t.img = img 
    t.anim_args = anim_args 

 

    t.trigger = false 
    t.is_col = false 


    t.hitbox.x = t.x 
    t.hitbox.y = t.y 
    t.hitbox.width = t.hitbox_args.width 
    t.hitbox.height = t.hitbox_args.height

    t.quad = nil 
    t.projectiles = Projectiles:new(t.x,t.y,15,15,{r=0.3,g=0.15,b=0.075},"Trap-Projectiles",{img=consts.AssetManager:getImage("Coffee-Bean","projectiles/coffee_bean.png"),animate=false,quad=nil})
    t.projectiles.em = t.em
    t.collidedWithPlayer = false 
    if t.anim_args.animate == false then 
        t.quad = love.graphics.newQuad(t.anim_args.srcX*16,t.anim_args.srcY*16,16,16,t.img:getWidth(),t.img:getHeight())
    else
        t.animator:add(t.img,t.anim_args.srcY,16,16,t.anim_args.name,t.anim_args.fps,t.anim_args.maxFrames)
        t.animator:setName(t.anim_args.name)
    end 
    return t

end 



function Trap:update(dt,camera) 
    
    if self.type == "Trigger-Trap" then 
        if consts.player:hitBoxOverlap(self) and not self.is_col then 

            self.projectiles:settings(self.x,-20,{x=0,y=250},{
                x=self.x,y=-20, width=15,height=15,offsetX = 0,offsetY = 0
            },true)
            self.quad = love.graphics.newQuad(16,self.anim_args.srcY*16,16,16,self.img:getWidth(),self.img:getHeight())
        else
            self.quad = love.graphics.newQuad(0,self.anim_args.srcY*16,16,16,self.img:getWidth(),self.img:getHeight()) 
        end
        
        self.is_col = consts.player:hitBoxOverlap(self)
        self.projectiles:update(dt,camera)
        if self.projectiles:detectCollisionWithRect(consts.player.hitbox) and not self.collidedWithPlayer then 
            consts.player:beHurt()
        end 
        self.collidedWithPlayer = self.projectiles:detectCollisionWithRect(consts.player.hitbox)
        
    end 


    if self.type == "Trap" then 

        if consts.player:hitBoxOverlap(self) and not self.is_col then 
            consts.player:beHurt()
        end 

        self.is_col = consts.player:hitBoxOverlap(self)
    end 

    if self.anim_args.animate == true then 
        self.animator:update(dt)
        
    end 
    self.hitbox.x = self.x-self.hitbox_args.x_offset
    self.hitbox.y = self.y-self.hitbox_args.y_offset

end 

function Trap:draw()    
    local scaleX = self.width/16
    local scaleY = self.height/16 

    if self.type == "Trigger-Trap" then 
        self.projectiles:draw()
    end 

    if self.anim_args.animate == false then 
        love.graphics.draw(self.img,self.quad,self.x,self.y,0,scaleX,scaleY)
    else 
        self.animator:draw(self.img,self.x,self.y,scaleX,scaleY)
    end 


end


return Trap 