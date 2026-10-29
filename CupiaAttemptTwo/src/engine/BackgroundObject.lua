local BackgroundObject = {}

local GameMath = require("engine.GameMath")
BackgroundObject.__index = BackgroundObject 

function BackgroundObject:new(spritesheet, index, srcRect) 

    local bg = setmetatable({} , BackgroundObject) 

    bg.index = index 

    bg.spritesheet = spritesheet

    bg.quad = love.graphics.newQuad(srcRect.x,srcRect.y,srcRect.width,srcRect.height, bg.spritesheet:getWidth(), bg.spritesheet:getHeight()) 
    
    bg.scale = {
        x = 1, 
        y = 1
    }

    bg.x = 0
    bg.y = 0
    bg.shader = nil 
    bg.color = {
        r = 1,
        g = 1,
        b = 1,
        a = 1 
    }

    bg.enableDrag = false 

    bg.drag = false 
    local x,y,w,h = bg.quad:getViewport() 
    bg.width = w * bg.scale.x 
    bg.height = h * bg.scale.y 
    return bg 
end 



function BackgroundObject:setShader(path) 

    self.shader = love.graphics.newShader(path) 

end 





function BackgroundObject:parentUpdate(dt) 
    if self.enableDrag then 

        local mx,my = love.mouse.getPosition() 
        

        if love.mouse.isDown(1) then 
            if GameMath.pointRectCollision(self,mx,my) then 
                self.drag = true 
                print("in you")
            end 
        end 
        

        if not love.mouse.isDown(1) and self.drag then 
            self.drag = false 

            print("X: " .. self.x .. " Y: " .. self.y)
        end 


        if self.drag then 
            self.x = mx 
            self.y = my 
        end 
        
    end 
end 

function BackgroundObject:update(dt) 

end 

function BackgroundObject:parentDraw() 
    if self.shader == nil then 
        love.graphics.setColor(1,1,1,1) 

    else 
        love.graphics.setShader(self.shader) 
    end     
end 



function BackgroundObject:draw() 


end 

return BackgroundObject 