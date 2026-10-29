local Sprite = require("engine.Sprite")
local globals = require("globals")
local ProjectileList = require("game.ProjectileList")
local TeaBullet = require("game.TeaBullet")
local Player = setmetatable({}, {__index=Sprite})
local Events = require("engine.Events")
local GameMath = require("engine.GameMath")
Player.__index = Player





function Player:new(x,y, spritebatch) 
    local p = setmetatable(Sprite:new(x,y,16,19, "player",{x=0,y=0,width=16 ,height = 16}, 2, 2, spritebatch), Player)

    p.col_status = "dynamic"

    p.isAnimate = true 


    p:addAnimation("idle",3,3,0,0,16,16)
    p:addAnimation("running",3,5,0,16,16,16)


  --  p:addAnimation("running",3,10,0,2,24,24)

    p.bullets = ProjectileList:new() 


    p.bullets:add(TeaBullet:new(p.x,p.y, 50,50),true)

    
    p.offset.x = 9
    p.offset.y = 9

    p:setJumpTable(450, 405, 0.8)
    p:setKinematics(0,0,150, 0, 350, 0, 1450, 0)
   
    
    return p 
end 

function Player:testGround() 
    if self.y >= globals.HEIGHT-self.height then 
        self.y = globals.HEIGHT - self.height
        self.jumpTable.isGrounded = true
    end 
end 


function Player:xInput(dt)
    if love.keyboard.isDown(globals.gameKeys["left"][2]) or love.keyboard.isDown(globals.gameKeys["left"][1]) then 
        

        self:changeAnimation("running")
        
        self:resetVelocityX(dt,"left",-1)
        self:accelerateX(dt, -1)

     
    elseif love.keyboard.isDown(globals.gameKeys["right"][2]) or love.keyboard.isDown(globals.gameKeys["right"][1]) then 
        
        self:changeAnimation("running")
        self:resetVelocityX(dt,"right",1)
    
        self:accelerateX(dt, 1)

    else
        self:resetVelocityX(dt,"nothing",1)
        self:changeAnimation("idle")
        self.vel.x = 0
    end 
end 

function Player:yInput(dt)
    
    if love.keyboard.isDown("space") or love.keyboard.isDown(globals.gameKeys["jump"][2]) or love.keyboard.isDown(globals.gameKeys["jump"][1]) then 
        self:jump()
    end 

end 






function Player:updateBulletLogic(dt) 

    --if love.keyboard.isDown(globals.gameKeys["shoot"])

    if Events:onePress(globals.gameKeys["shoot"]) then 
        self.bullets:add(TeaBullet:new(self.x,self.y, 50,50),true)
    end     
    
    self.bullets:update(dt) 
end 

function Player:update(dt )



    
    self:flipX(self.ogScale.x,self.vel.x)

    
    self:updateAnimating(dt)


  

    self:xInput(dt)
    self:moveX(dt)
    

    self:updateCollisionAxis()
    self:findCollision() 
    self:collisionX()


    

    
    
    self:yInput(dt)
    self:updateJumping(dt)

    self:updateGravity()
    self:moveY(dt)

    self:updateImgCoords()
    self:updateCollisionAxis()
   
    self:findCollision() 
    self:collisionY()
    

    self:updateBulletLogic(dt)
    
   
    --self:manageJumpTable()



    --self:testGround()

  
  
 

    
end 


function Player:drawBulletLogic() 

    self.bullets:draw() 
end 

function Player:draw() 

    --[[love.graphics.setColor(1,1,0,1)
    love.graphics.rectangle("fill", self.x,self.y,self.width,self.height)]]

    self:drawBulletLogic()
end 

return Player