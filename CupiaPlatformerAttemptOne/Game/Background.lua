local consts = require "consts"
local Background = {}
Background.__index = Background  
--[[
    layer = {
        x, y, width, height, img, ogWidth, ogHeight, scaleX,scaleY, renderOrder 
    }

]]


function Background:new() 
    local bg = setmetatable({},Background)

    bg.layers = {}

    bg.drawOrder = {}


    return bg 
end 

function Background:addLayer(name,layer) 
    self.layers[name] = layer 
    table.insert(self.drawOrder, {name=name, order = layer.renderOrder})
end 

function Background:update(dt) 
    table.sort(self.drawOrder,function(a,b) 
        return a.order < b.order
    end )

    for k,v in ipairs(self.drawOrder) do 
        local layer = self.layers[v.name]

        if layer.scroll == true then 
            layer.x = layer.x + layer.scrollSpeed * dt

            if layer.x >= consts.WIDTH then 
                layer.x = -16*layer.scaleX
                layer.quad = love.graphics.newQuad(16*love.math.random(0,2),0,16,16,48,16)
                layer.y = love.math.random(-160,30)
                layer.scrollSpeed = love.math.random(20,120)
            end 
        end 
    end 
end 


function Background:draw(camera) 
   -- print("drawing")

  

   for k,v in ipairs(self.drawOrder) do 
        local layer = self.layers[v.name]

        if layer.be_quad then 
            love.graphics.draw(layer.img,layer.quad,layer.x,layer.y,0,layer.scaleX,layer.scaleY)
        else 
            love.graphics.draw(layer.img,layer.x,layer.y,0,layer.scaleX,layer.scaleY)
        end 
       
   end

  
   
end 

return Background 