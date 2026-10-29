local Weapon = require("Game.Weapon")
local Gun = setmetatable({},Weapon)
local Projectiles = require("Game.Projectiles")
local consts = require("consts")
local Label = require("Engine.Label")
Gun.__index = Gun 



function Gun:new(x,y,em,ui_manager) 
    
    local g = setmetatable(Weapon:new(x,y,"Gun"),Gun)
    consts.indexes.gun = consts.indexes.gun + 1
    g.width = 48 
    g.height = 48 


    g.em = em
    g.img = consts.AssetManager:getImage("Gun","Weapons/gun.png")

    g.projectiles = {} 
    
    g.projectiles["left"] = Projectiles:new(g.x,g.y,10,10,{r=0.5,g=0.35,b=0.05},"Gun-Projectiles-Left",{img=g.img,animate=false,quad=love.graphics.newQuad(16,16,16,16,g.img:getWidth(),g.img:getHeight())})
    g.projectiles["right"] = Projectiles:new(g.x,g.y,10,10,{r=0.5,g=0.35,b=0.05},"Gun-Projectiles-Right",{img=g.img,animate=false,quad=love.graphics.newQuad(0,16,16,16,g.img:getWidth(),g.img:getHeight())})
    g.projectiles["up"] = Projectiles:new(g.x,g.y,10,10,{r=0.5,g=0.35,b=0.05},"Gun-Projectiles-Up",{img=g.img,animate=false,quad=love.graphics.newQuad(32,16,16,16,g.img:getWidth(),g.img:getHeight())})
    g.projectiles["down"] = Projectiles:new(g.x,g.y,10,10,{r=0.5,g=0.35,b=0.05},"Gun-Projectiles-Down",{img=g.img,animate=false,quad=love.graphics.newQuad(48,16,16,16,g.img:getWidth(),g.img:getHeight())})

    for k,v in pairs(g.projectiles) do
        
        v.maxDistance.x = 250 
        v.maxDistance.y = 250 
    end
    g.pressedSpace = false 
    g.mousePressed = false 
   
    g.quad = love.graphics.newQuad(0,0,16,16,g.img:getWidth(),g.img:getHeight())
    g.dir = "right"

    g.ammo = 50
    g.ui_manager = ui_manager 
    g.label = Label:new(30,30,tostring(g.ammo), 30,"assets/fonts/font_pixel.ttf",{r=1,g=1,b=1},500,"Gun-Label: " .. consts.indexes.gun)
    g.label:addImage(g.img,love.graphics.newQuad(32,16,16,16,g.img:getWidth(),g.img:getHeight()),20,consts.HEIGHT-30,20,20)
    g.label:setText(40,consts.HEIGHT-28,tostring(self.ammo),15,{r=1,g=1,b=1},"assets/fonts/font_pixel.ttf")
    

    g.ui_manager:addElement(g.label)
    return g 
end 

function Gun:shooting(player) 
    
    self.ammo = self.ammo - 1 
    
    self.attackBool = true 


    if player.dashing.dir == "right" then 
            
                
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            self.projectiles["up"]:settings(self.x+(self.width/2)-5,self.y+self.height,{x=0,y=-450},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            }, true)
            self.quad = love.graphics.newQuad(3*16,0,16,16,self.img:getWidth(),self.img:getHeight())
            self.dir = "up"

        elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then 
            self.projectiles["down"]:settings(self.x+(self.width/2)-5,self.y,{x=0,y=450},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            },true)
            self.quad = love.graphics.newQuad(5*16,0,16,16,self.img:getWidth(),self.img:getHeight())
            self.dir = "down"
        else 
            self.projectiles["right"]:settings(self.x+self.width,self.y+(self.height/2)-5,{x=450,y=0},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            },true)
            self.quad = love.graphics.newQuad(0,0,16,16,self.img:getWidth(),self.img:getHeight())
            
            self.dir = "right"
        end 
    end 
            
    if player.dashing.dir == "left" then 
           
               
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            self.projectiles["up"]:settings(self.x+(self.width/2)-5,self.y+self.height,{x=0,y=-450},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            },true)

            self.quad = love.graphics.newQuad(2*16,0,16,16,self.img:getWidth(),self.img:getHeight())

            self.dir = "up"
        elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then 
            self.projectiles["down"]:settings(self.x+(self.width/2)-5,self.y,{x=0,y=450},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            },true)
            self.quad = love.graphics.newQuad(4*16,0,16,16,self.img:getWidth(),self.img:getHeight())
            
            self.dir = "down"
        else 
            self.quad = love.graphics.newQuad(16,0,16,16,self.img:getWidth(),self.img:getHeight())
            self.dir = "left"
            self.projectiles["left"]:settings(self.x,self.y+(self.height/2)-5,{x=-450,y=0},{
                x=self.x+(self.width/2)-5,y=self.y+self.height, width=10,height=10,offsetX = 0,offsetY = 0
            },true)
        end 
    end 
end 

function Gun:update(dt) 

   
    local label = self.ui_manager:getElements(self.label.name)[1]

    if self.pickedUp then 
        label:setText(40,consts.HEIGHT-28,tostring(self.ammo),15,{r=1,g=1,b=1},"assets/fonts/font_pixel.ttf")
        consts.player.equipment = self
        self.label.show = true 
        
        if love.keyboard.isDown(consts.keys["Shoot"]) and not self.pressedSpace then 
            self:shooting(consts.player)
        end


        if self.ammo <= 0 then 
            self.delete = true 
            self.ui_manager:removeAllElementsByName(self.label.name) 
        end 
   
        self.pressedSpace = love.keyboard.isDown(consts.keys["Shoot"])
        
        if love.mouse.isDown(1) and not self.mousePressed then 
            self:shooting(consts.player)
        
        end 

        self.mousePressed = love.mouse.isDown(1)

        if self.attackBool == false then 
            if consts.player.dashing.dir == "right" then 
                self.dir = "right"
                self.quad = love.graphics.newQuad(0,0,16,16,self.img:getWidth(),self.img:getHeight())
            end 

            if consts.player.dashing.dir == "left" then
                self.dir = "left"
                self.quad = love.graphics.newQuad(16,0,16,16,self.img:getWidth(),self.img:getHeight())
            end
        end 

        if not love.mouse.isDown(1) and not love.keyboard.isDown(consts.keys["Shoot"]) then 
            self.attackBool = false 
        end 

        
        if self.dir == "left" then
            
            self.center.x = consts.player.x - 5 

        else
            self.center.x = consts.player.x
        end
        
        self.center.y = consts.player.y 
        
    else 
        self.center.x = self.x 
        self.center.y = self.y 
        label.show = false 
    end 
    

    for k,v in pairs(self.projectiles) do 
        v:update(dt)
    end 
    self:parentUpdate(dt)   

end 


function Gun:draw() 
    local scaleX = self.width/16
    local scaleY = self.height/16 

    love.graphics.draw(self.img,self.quad,self.x,self.y,0,scaleX,scaleY)

    if self.pickedUp then 
     
        for k,v in pairs(self.projectiles) do
            v:draw()
            
        end
    end 
  

  
end 


return Gun 