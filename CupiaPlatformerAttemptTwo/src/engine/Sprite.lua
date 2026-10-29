
local Entity = require("engine.Entity")
local Sprite = setmetatable({} ,{__index = Entity}) 
Sprite.__index = Sprite 


function Sprite:new(x,y,width,height,id, src_rect,sx,sy, spritebatch) 
    
    local s  = setmetatable(Entity:new(x,y,width,height,id), Sprite) 
        
    s.spritebatch = spritebatch

    s.isAnimate = false 


    s.animations = {}

    

    s.defaultSrcRect = src_rect


    --seperate rectangles and images for hitbox purposes 
    s.imgCoords = {
        x = x, 
        y = y 
    }
    s.scale = {
        x = sx,
        y = sy 
    }

    s.offset = {
        x=0,
        y = 0
    }

    s.ogScale = {
        x = sx,
        y = sy 
    }
    
    s.currentAnimation = ""


    s:addQuad(src_rect.x,src_rect.y,src_rect.width,src_rect.height); 

    return  s 
end 


--using spritebath
function Sprite:addQuad(srcX, srcY, srcWidth, srcHeight)

    local img = self.spritebatch:getTexture()
    local quad = love.graphics.newQuad(srcX,srcY, srcWidth, srcHeight, img:getWidth(), img:getHeight())
    self.batchId = self.spritebatch:add(quad, self.imgCoords.x,self.imgCoords.y, 0, self.scale.x, self.scale.y) 
end 
function Sprite:updateQuad(srcX, srcY, srcHeight, srcWidth) 
    local img = self.spritebatch:getTexture()
    local quad = love.graphics.newQuad(srcX,srcY, srcWidth, srcHeight, img:getWidth(), img:getHeight())

    if self.scale.x < 0 then 
        self.spritebatch:set(self.batchId, quad, self.imgCoords.x+(-self.scale.x*srcWidth), self.imgCoords.y, 0, self.scale.x,self.scale.y)
    else
        self.spritebatch:set(self.batchId, quad, self.imgCoords.x, self.imgCoords.y, 0, self.scale.x,self.scale.y)
    end
    

end 


function Sprite:addAnimation(name,maxFrame, fps, srcX, srcY, srcWidth, srcHeight)

    --[[

        animatation = {


            --happens horizontally
            currentFrame, maxFrame, fps, timer, startX,  
        }
    
    ]]
    
    local anim = {
        currentFrame = srcX, startX = srcX, fps = fps, maxFrame= maxFrame, srcY = srcY, srcWidth = srcWidth, srcHeight = srcHeight, timer = 0 
    }


 
    self.animations[name] = anim 

 
    if self.currentAnimation == "" then 
        self.currentAnimation = name 
    end 

end 
function Sprite:flipX(defaultScale, sign)
    
    
    if sign < 0 then
        
        if self.scale.x > 0 then 
            self.scale.x = -defaultScale
        end 
        

    elseif sign > 0 then 


        if self.scale.x < 0 then 
            self.scale.x = (defaultScale)
        end 
    
    end 

end 


function Sprite:updateImgCoords() 

    
    self.imgCoords.x = self.x - self.offset.x 
    self.imgCoords.y = self.y - self.offset.y 
    
    

end 

function Sprite:changeAnimation(name) 

    if self.currentAnimation ~= name then 

        self.animations[self.currentAnimation].currentFrame = self.animations[self.currentAnimation].startX 
        self.currentAnimation = name 
    end 


end 

function Sprite:updateAnimating(dt) 
    if self.isAnimate then 


        if self.currentAnimation ~= "" then 
        
            local animation = self.animations[self.currentAnimation]  



       
            animation.timer = animation.timer + dt 

            if animation.timer >= 1/animation.fps then 

                animation.timer = 0 

                if animation.currentFrame >= animation.maxFrame-1 then 
                    animation.currentFrame = animation.startX 

                else
                    
                    animation.currentFrame = animation.currentFrame + 1 
                end 
            end 



                    
            

            self:updateQuad(animation.currentFrame*animation.srcWidth, animation.srcY, animation.srcWidth, animation.srcHeight)
        
        end
    


        
        
        
    end 
end 

function Sprite:update(dt) 

end 

function Sprite:draw() 

end 

return Sprite 