local Animator = {}

Animator.__index = Animator 


function Animator:new() 
    local instance = setmetatable({},Animator)
   
    instance.counterX = 0
    instance.counterY = 0
    instance.animations = {}
    instance.currentAnimationName = "null"
    instance.updating = false 
    return instance
end 


function Animator:setName(name) 



    if self.currentAnimationName ~= name then
        
        self.currentAnimationName = name 
        self.counterX = 0
        self.counterY =0
    end
    
    
   
    
        --print("Animation Name Is Already Set")
    
end 
function Animator:add(img,srcY,srcWidth,srcHeight,name,fps,maxFrame)  
    local sheetWidth = img:getWidth() 
    local sheetHeight = img:getHeight() 
    local quads = {}
    for i = 0,math.floor(sheetWidth/srcWidth) do 
        local quad = love.graphics.newQuad(i*srcWidth,srcY*srcHeight,srcWidth,srcHeight,sheetWidth,sheetHeight)
        table.insert(quads,quad)
    end     

    local animation = { }
    animation.quads = quads 
    animation.fps = fps
    animation.frame = 1
    animation.maxFrame = maxFrame
 
    self.animations[name] = animation
end 

function Animator:getAnimation(name)
    return self.animations[name] 
end 


function Animator:update(dt) 
    if not self.updating then 
        self.updating = true 
    end 
    if self.currentAnimationName == "null" then 
        --print("Animation Name Not Set") 
    else 
        
        local anim = self.animations[self.currentAnimationName]

        self.counterX = self.counterX + dt
        if self.counterX >= 1 / anim.fps then
            --self.counterX = self.counterX - 1 / anim.fps -- Reset timer
            self.counterX = 0
            anim.frame = anim.frame + 1
            if anim.frame > anim.maxFrame then
                anim.frame = 1 -- Loop back to the first frame
            end
        end
        
        --print(self.counterX)
        --print(self.currentAnimationName)
    end 


    

    

    
end 


--take in image and x,y and coords and scale it
function Animator:draw(img, x, y,scaleX,scaleY) 
    
    if self.updating == false then 
        --print("Not Updating")
    end 

    if self.currentAnimationName == "null" then 
        --print("In Draw Animation: CurrentName Not Set")
    else 
        local anim = self.animations[self.currentAnimationName]
        love.graphics.draw(img, anim.quads[anim.frame], x, y, 0, scaleX, scaleY)
    end 

    
end 

-- add angle + center
function Animator:drawWithAngle(img, x, y,scaleX,scaleY,angle,center) 

    if self.currentAnimationName == "null" then 
        --print("In Draw Animation: CurrentName Not Set")
    else 
        local anim = self.animations[self.currentAnimationName]
        love.graphics.draw(img, anim.quads[anim.frame], x, y, angle, scaleX, scaleY,center.width,center.height)
    end 

    
end 



return Animator 