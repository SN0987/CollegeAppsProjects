local Tile = require("game.Tile") 
local AnimatableTile = setmetatable({} , {__index=Tile}) 
AnimatableTile.__index = AnimatableTile


--[[
    srcRect = {
        startX
        srcWidth
        srcHeight 
        srcY 
        srcX = startX 
        maxFrames 
        fps

    }

]]
function AnimatableTile:new(x,y, width,height, spritebatch, col_status, srcRect,id)  

    --Tile:new(x,y,width,height,src_rect,id, spritebatch)
    local at = setmetatable(Tile:new(x,y,width,height, srcRect,id,spritebatch),AnimatableTile)

    at.col_status = col_status
    
    at.isAnimate = true 


    --Sprite:addAnimation(name,maxFrame, fps, srcX, srcY, srcWidth, srcHeight)
    at:addAnimation("animation",srcRect.maxFrames,srcRect.fps,srcRect.x,srcRect.y,srcRect.width,srcRect.height)

    at:changeAnimation("animation")

    return at

end 

function AnimatableTile:update(dt)

    self:updateAnimating(dt)

    self:updateImgCoords()
end 

function AnimatableTile:draw() 

end     


return AnimatableTile
