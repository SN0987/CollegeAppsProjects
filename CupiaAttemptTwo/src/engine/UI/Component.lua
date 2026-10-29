local Component = {}
local GameMath = require("engine.GameMath")
 
Component.__index = Component 


--[[
    comp_types: 
    button 
    label
    input box 

]]
function Component:new(x,y,comp_type,camera,debug) 
    local c = setmetatable({}, Component)

    c.x = x 
    c.y = y 
    c.width = width 
    c.height = height 
    c.type = comp_type 
    c.debug = debug 

    c.color = {r=1,g=1,b=1,a=1} 

    c.img = nil 
    c.imgQuad = nil 

    c.quad = nil 
    c.enabledTyping = false 
    c.camera = camera 

    c.dragMode = false 

    c.scale = {
        x = 1, 
        y = 1
    }
    c.visible = true 

    return c 
end 


function Component:enableDragMode() 
    if not self.dragMode then 
        self.dragMode = true 
    end 
end 


function Component:generateMouseRect() 
    local mx,my = self.camera:getGlobalMousePos() 

    local mRect = {
        x = mx, y = my, width = mx + 0.00001, height = my + 0.00001   
    }   



    return mRect 
end 

function Component:update(dt) 

end 


function Component:updateParent() 

    if self.debug then 
        if not self.dragMode then 
            local r = self:generateMouseRect() 
   
            if love.mouse.isDown(2) and GameMath.pointRectCollision(self,r.x,r.y) then 

                self:enableDragMode()
            end 
        end 

        if self.dragMode then 
            local mx,my = love.mouse.getPosition() 

            self.x = mx - self.width / 2
            self.y = my  - self.height / 2


            self:setBounds(self.x,self.y,self.width,self.height) 
            if love.mouse.isDown(1) then
                
                print("X: " .. self.x .. " Y: " .. self.y)
                self.dragMode = false 
            end 
        end 
    end 
 
end 



function Component:drawImage() 

    if self.img ~= nil then  

        love.graphics.setColor(self.color.r,self.color.g,self.color.b,self.color.a)

        if self.scale.x < 0 then 
           

            if self.quad ~= nil then 
                local x,y,w,h = self.quad:getViewport()
                love.graphics.draw(self.img, self.quad, self.x+(-self.scale.x*w),self.y,0,self.scale.x,self.scale.y)
            
            else 
                love.graphics.draw(self.img,self.x+(-self.scale.x*self.width),self.y,0,self.scale.x,self.scale.y)
            end 
           
        else
            
            if self.quad ~= nil then 
                love.graphics.draw(self.img, self.quad, self.x,self.y,0,self.scale.x,self.scale.y)

            else 
                love.graphics.draw(self.img, self.x,self.y,0,self.scale.x,self.scale.y)
            end 

        end 
       
        love.graphics.setColor(1,1,1,1)
    end 
end 

function Component:setImage(img_name,quad, assetmanager,dWidth,dHeight)

    self.img = assetmanager:get(img_name) 
    self.quad = quad 

    x,y,width,height = self.quad:getViewport() 


    self.scale.x = dWidth/width 
    self.scale.y = dHeight/height 

    self.width = dWidth 
    self.height = dHeight 


end 


function Component:setBounds(x,y,width,height) 

    self.x = x 
    self.y = y 
    self.width = width 
    self.height = height 
end

function Component:onClick(func) 

    
    if GameMath.rectangleCollision(self:generateMouseRect(), self) then 
        func() 
    end     
end 

function Component:setColor(r,g,b,a)
    
    self.color.r = r 
    self.color.g = g 
    self.color.b = b 
    self.color.a = a
    
end

function Component:draw() 
    self:drawBounds()
end 

function Component:drawBounds() 
    love.graphics.setColor(self.color.r,self.color.g,self.color.b,self.color.a) 
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height) 
    love.graphics.setColor(1,1,1,1)
end 

return Component