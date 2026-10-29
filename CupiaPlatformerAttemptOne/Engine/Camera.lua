local Camera = {}
Camera.__index = Camera  

function Camera:new(x,y,width,height ) 
    local c = setmetatable({},Camera)

    c.x = x
    c.y = y
    c.width = width 
    c.height = height 
    c.shakes = false 
    c.shakeTime = 0
    c.prevX = c.x 
    c.prevY = c.y 
    c.scales = {
        x = 1,
        y = 1
    }
    c.stopShakingTime = 0 
    c.screen = nil 
    return c 
end 


--get the mouse position from the scale 
function Camera:globalMousePos() 
  
    local mx, my = love.mouse.getPosition()

    local worldX,worldY

    if self.screen ~= nil then 
        local screenW, screenH = love.graphics.getDimensions()
        local canvasW, canvasH = self.screen:getWidth(), self.screen:getHeight()
        local canvasX = screenW/2-canvasW/2
        local canvasY = screenH/2-canvasH/2

        -- Convert mouse to canvas coordinates
        local cx = mx - canvasX
        local cy = my - canvasY

        -- Convert to unscaled canvas space
        local ux = cx / self.scales.x
        local uy = cy / self.scales.y

        -- Convert to world space using camera position
        worldX = ux + self.x
        worldY = uy + self.y
    else
          -- Convert mouse to canvas coordinates
        local cx = mx 
        local cy = my 

        -- Convert to unscaled canvas space
        local ux = cx / self.scales.x
        local uy = cy / self.scales.y

        -- Convert to world space using camera position
        worldX = ux + self.x
        worldY = uy + self.y
    end 
    -- Get canvas position on screen (centered)


    return worldX, worldY

end 

function Camera:setScreen(screen )
    self.screen = screen 
end 

function Camera:move(dt,speed_vec) 
    self.x = self.x + speed_vec.x * dt 
    self.y = self.y + speed_vec.y * dt 
end 

function Camera:clampX(min,max)
    self.x = math.max(min,math.min(self.x,max))

end 


function Camera:shake(time) 
    if self.shakes ~= true then 
        self.shakes = true 
        self.prevX = self.x 
        self.prevY = self.y
        self.stopShakingTime = time 
    end 
end 


function Camera:update(dt) 
    if self.shakes then 
        self.shakeTime = self.shakeTime + dt 
        
        self.x = self.x + love.math.random(-50,50)
        self.y = self.y + love.math.random(-50,50)

    
        if self.shakeTime >= self.stopShakingTime then 
            self.shakes = false 
            self.x = self.prevX 
            self.y = self.prevY
            self.shakeTime = 0
        end 
    end 


end 

function Camera:follow(x,y)

    
    local screenW = self.width
    local screenH = self.height
    if not self.shakes then 
        self.x = x-screenW/2
        self.y = y-screenH/2
    end 

end

function Camera:translateSelf()
    
end 



function Camera:clampY(min, max) 
    self.y = math.max(min,math.min(self.y,max))

end

function Camera:scale() 
    
    
    self.scales.x = love.graphics.getWidth()/self.width
    self.scales.y = love.graphics.getHeight()/self.height
    love.graphics.push()
    love.graphics.scale(self.scales.x,self.scales.y)
end 

function Camera:scaleWithGraphics()
    self.scales.x = love.graphics.getWidth()/self.width
    self.scales.y = love.graphics.getHeight()/self.height
    love.graphics.push()
    love.graphics.scale(self.scales.x,self.scales.y)
end 

function Camera:apply()
    love.graphics.push()
    love.graphics.translate(-math.floor(self.x),-math.floor(self.y))
    
end 


function Camera:unapply() 
    love.graphics.pop() 

end 

function Camera:unscale() 
    love.graphics.pop()

end 

return Camera  