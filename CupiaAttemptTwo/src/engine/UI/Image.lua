local Component = require("engine.UI.Component") 
local Image = setmetatable({}, {__index = Component} )

Image.__index = Image 


--this was really for the arrow list
function Image:new(x,y,img, quad, scale,camera, debug,number)
    local i = setmetatable(Component:new(x,y,"Image", camera, debug), Image)

    i.img = img 
    i.quad = quad 
    i.ogScale = {
        x = scale.x,
        y = scale.y 
    }
    i.ogNumberX = scale.x 
    i.ogNumberY = scale.y 


    print("Constrcutor Scale X: " .. i.ogScale.x)
    i.scale.x = scale.x 
    i.scale.y = scale.y 
  

    i.itemBounds = {
        width = 32, 
        height = 32 
    }

    i.onTheList = true 

    --use this for tiles and maps 
    i.number = number

    
    local srcX,srcY,w, h = quad:getViewport() 
    i.scale.x = i.itemBounds.width/w 
    i.scale.y = i.itemBounds.height/h
    
    i:setBounds(x,y,w*i.scale.x,h*i.scale.y)  
     
    return i 

end 


function Image:update(dt) 


   --[[ print(
    "og:", self.ogScale.x, self.ogScale.y,
    " current:", self.scale.x, self.scale.y
)]] 
end 

function Image:draw() 

    if not self.onTheList then 
        local srcX,srcY,w, h = self.quad:getViewport() 
        
        self.scale.x = self.ogScale.x
        self.scale.y = self.ogScale.y
        self:setBounds(self.x,self.y,w*self.scale.x,h*self.scale.y)  

       
    end 
    

    --on the selection list or inventory
    if self.onTheList then 
        local srcX,srcY,w, h = self.quad:getViewport() 
        self.scale.x = self.itemBounds.width / w 
        self.scale.y = self.itemBounds.height / h 
        self:setBounds(self.x,self.y,w*self.scale.x,h*self.scale.y)  
       

    end     

    self:drawImage()
end     


return Image  