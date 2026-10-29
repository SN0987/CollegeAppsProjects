local TilemapEditor = {}
local Camera = require("engine.Camera")
local UIManager = require("engine.UI.UIManager")
local Component = require("engine.UI.Component") 
local Label = require("engine.UI.Label")
local Button = require("engine.UI.Button")
local TextInput = require("engine.UI.TextInput")
local ArrowList = require("engine.UI.ArrowList")
local Image = require("engine.UI.Image") 
local EntityManager = require("engine.EntityManager")
local globals = require("globals")
local WriteFile = require("engine.WriteFile")
local GameMath  = require("engine.GameMath")
local TileMap = require("engine.TileMap")

TilemapEditor.__index = TilemapEditor


--[[
    need globals.WIDTH, globals.HEIGHT, globals.WORLD_WIDTH
]]


--[[
    1: grid mode, mouse down place, mouse right remove 
    2: adding images mode
    s: selection image 
    3: layer mode 
    4: add layer use arrow keys to add layers 
    o: save 

    scroll click to get rid of input box taking in text 
]]

function TilemapEditor:loadUI() 

    --function Label:new(x,y,text,camera,debug)


    --index 1 label mdode
    self.modeLabel = Label:new(20,30,"mode: " .. self.string_modes,self.camera, true) 
    self.modeLabel:setColor(1,1,1, 1.0)

    self.modeLabel:setFont(globals.am:getFont("assets/fonts/font_pixel.ttf",27),"assets/fonts/font_pixel.ttf")

    self.modeLabel:alignCenterX({x=0,y=0,width=globals.WIDTH,globals.HEIGHT}) 

    self.uiManager:add(self.modeLabel)
    
    self.image_input = TextInput:new(352,528,self.camera, true)

    self.image_input.visible = false 



    --index 2 of label 
    self.imageInputLabel = Label:new(414,499,"Enter Image Path: ",self.camera, true) 
    self.imageInputLabel:setFont(globals.am:getFont("assets/fonts/font_basic.ttf",18),"assets/fonts/font_basic.ttf")

    self.imageInputLabel.visible = false 
    self.uiManager:add(self.image_input)
    
    self.uiManager:add(self.imageInputLabel)

    self.arrowList = ArrowList:new(88,524,self.camera,true, 25)

    self.arrowList:setParams({r=1,g=1,b=1,a=1},20,2,2)

    self.arrowList.visible = true



    if self.spritesheet ~= nil then 
        self.arrowList:loadItems(self.map_path .. "/selection_table.lua",self.spritesheet)
    end 

    self.uiManager:add(self.arrowList)
    -- index 3 
    self.layerLabel = Label:new(31,30,"Layer: 1" ,self.camera, true) 
    self.layerLabel:setColor(1,1,1, 1.0)

    self.layerLabel:setFont(globals.am:getFont("assets/fonts/font_pixel.ttf",27),"assets/fonts/font_pixel.ttf")

    self.uiManager:add(self.layerLabel)
end 

function TilemapEditor:createCursor() 

    self.cursor = {
        x = 0, 
        y = 0 ,
        width = globals.TILE_SIZE, 
        height = globals.TILE_SIZE, 
        color = {r=0.1,g=0.75,b=0.1,a=0.8}, 
        img = nil 
    }


end     


function TilemapEditor:new(map_path) 
    local tm = setmetatable({} , TilemapEditor) 
    

    tm.layerDir = map_path.."/layer"
    

    if WriteFile.readTable2D(tm.layerDir .. "1.lua") then 
        tm.createNew = false 

    else
        tm.createNew = true 
    end 

    tm.camera = Camera:new(0,0,globals.WIDTH,globals.HEIGHT) 

    tm.map_path = map_path 


    tm.modes = {
        grid = false,
        adding = false, 
        layer = false, 
    }


    tm.keyTrackers = {}
   
    tm.string_modes = "default"

    tm.uiManager = UIManager:new(tm.camera) 

    
    tm.em = nil 

    tm.layers = {}
    if not tm.createNew then 
        for i = 1, 3 do 
            local n = tostring(i) 

            if(WriteFile.readTable2D(tm.layerDir .. n .. ".lua")) then 
                tm.layers[i] = WriteFile.readTable2D(tm.layerDir .. n .. ".lua")
            end     
        end 

        tm.spritesheet = love.graphics.newImage(WriteFile.readString(tm.map_path .."/img_info.txt")) 
    
        tm.em = EntityManager:new(tm.spritesheet)

        tm.tilemap = TileMap:new(tm.map_path,tm.em) 

        tm.tilemap:loadAllLayers() 



    end 
 
    
   

    tm.currentLayer = 1 

    tm.preventKeyboard = false 

    tm.tileImages = {} 
    
    tm:loadUI()


    tm:createCursor() 

    

    return tm 


end 

function TilemapEditor:onePress(name) 

    local bool 
    
    if love.keyboard.isDown(name) and not self.keyTrackers[name] then 
        bool = true   

    else
        bool = false 
    end 

    self.keyTrackers[name] = love.keyboard.isDown(name)


    return bool 
    
end 

function TilemapEditor:adjustUI(labels,textinputs) 

    


    labels[1]:setText("mode: " .. self.string_modes) 
    labels[1]:alignCenterX({x= 0 ,y=0 ,width=globals.screenWidth,height=globals.screenHeight})
    labels[3]:setText("Layer: "  .. self.currentLayer) 





    if self.modes.adding then 
        textinputs[1].visible = true 
        labels[2].visible = true    



        if self.spritesheet == nil then 
            labels[2]:setText("Enter Image Path: ")

            

            
            if(textinputs[1]:isInput()) then 

                if WriteFile.checkLoveFile(textinputs[1].text) then 
                    self.spritesheet = love.graphics.newImage(textinputs[1].text)
                    WriteFile.writeString(self.map_path .. "/img_info.txt", textinputs[1].text)
                    self.em = EntityManager:new(self.spritesheet)
                end 
                

              
            end 
         
            
        else
            labels[2]:setText("Enter X Y W H SX SY NUMBER")


            if textinputs[1]:isInput() then
                local text = textinputs[1].text 
                local item_params = {}
                
            
                self.preventTyping = true 
                for word in string.gmatch(text,"%S+" ) do
                    
                    table.insert(item_params, word) 

                end 
                
                if #item_params == 7 then 
                     local item_params_i = {}

                    for k,v in ipairs(item_params) do 
                        table.insert(item_params_i, tonumber(v)) 
                    end 

                    local item = {

                    
                        scale = {x = item_params_i[5], y=item_params_i[6] },
                        
                        quad = love.graphics.newQuad(item_params_i[1],item_params_i[2], item_params_i[3], item_params_i[4], self.spritesheet:getWidth(), self.spritesheet:getHeight()) 
                    }

                    

                    if self.arrowList.capacity >= self.arrowList.maxCapacity then 
                        self.arrowList.maxCapacity = self.arrowList.maxCapacity + 1
                    end 
                
                    self.arrowList:addItem(Image:new(0,0,self.spritesheet,item.quad,item.scale,self.camera,true,item_params_i[7]))  

                    WriteFile.writeImageTable(self.map_path .. "/selection_table.lua",self.arrowList.items)
                end 
           

           
            end 
        end     

    else 
        textinputs[1].visible = false 
        labels[2].visible = false
    end 
end   


function TilemapEditor:addLayer() 

    if not self.layers[self.currentLayer] then 
        self.layers[self.currentLayer] = {}


        for i = 1, globals.HEIGHT/globals.TILE_SIZE do 
            local t = {}

            for j = 1, globals.WORLD_WIDTH/globals.TILE_SIZE do 
                table.insert(t, 0)
            end 

            table.insert(self.layers[self.currentLayer], t) 

        end 

        
    end 


end 

function TilemapEditor:layerMode(dt, labels, textinputs,arrowlists) 
    if not self.modes.layer then 
        if self:onePress("4") and not self.modes.grid and not self.modes.adding then 
            self.modes.layer = true 
         
        end 

        arrowlists[1].visible = true 
    end 

    if self.modes.layer then 
        
        self.string_modes = "layer adjusting"
        if self:onePress("4") then 
            self.modes.layer = false 
            
        end 


        if self:onePress("left") then 
            if self.currentLayer > 1 then 
                self.currentLayer = self.currentLayer - 1 
            end 
        end 

        if self:onePress("right") then 
            if self.currentLayer < 3 then 
                self.currentLayer = self.currentLayer + 1
                self:addLayer() 
            end 
        end 

        if self.layers[self.currentLayer] == nil then 
            self:addLayer()
        end 

        arrowlists[1].visible = false 


        
    end 
end     


function TilemapEditor:adjustCursor(mx,my,dt) 



    if mx > (self.cursor.x + self.cursor.width)  and self.cursor.x < globals.WORLD_WIDTH-self.cursor.width then 
        self.cursor.x = self.cursor.x + globals.TILE_SIZE
        
    end 
    
    if mx < (self.cursor.x) and self.cursor.x > 0 then 
        self.cursor.x = self.cursor.x - globals.TILE_SIZE
    end 

    if my > (self.cursor.y + self.cursor.height) and self.cursor.y < globals.HEIGHT-self.cursor.height then 
        self.cursor.y = self.cursor.y + globals.TILE_SIZE
        
    end 
    
    if my < (self.cursor.y) and self.cursor.y > 0 then 
        self.cursor.y = self.cursor.y - globals.TILE_SIZE
    end 




    
end 

function TilemapEditor:gridMode(dt,arrowlists) 
    local mx,my = self.camera:getGlobalMousePos() 

   
    if not self.modes.grid then 
        --[[if love.keyboard.isDown("1") and not self.keyTrackers.one then 
            self.modes.grid = true 
        end

        self.keyTrackers.one = love.keyboard.isDown("1")]]

        if(self:onePress("1")) and not self.modes.adding and not self.modes.layer then 
            self.modes.grid = true 
        end 

    
    end 
    


    
    
    if self.modes.grid then 

        --[[if love.keyboard.isDown("1") and not self.keyTrackers.one then 
            self.modes.grid = false 
        end     

        self.keyTrackers.one = love.keyboard.isDown("1")]]

        if(self:onePress("1")) then 
            self.modes.grid = false 
        end 


        self.string_modes = "grid"

        self:handleGridMouseInput(dt,arrowlists)
        self:adjustCursor(mx,my)

        if love.keyboard.isDown("a") then 
            self.camera:move(-300,0,dt)

        end 

        if love.keyboard.isDown("d") then 
            self.camera:move(300,0, dt) 
        end 

        self:save(dt)
            
        if self:onePress("s")  then 
            local image =  self.arrowList:returnSelection()
            
            self.cursor.img = Image:new(image.x,image.y,image.img,image.quad,image.ogScale,self.camera,false,image.number)

        end     

   

    end     

    if not self.modes.grid and not self.modes.adding and not self.modes.layer then 
        self.string_modes = "none"
    end 
end 


function TilemapEditor:addingMode(dt,textinputs) 
    if not self.modes.adding then 
        
        if self:onePress("2") and not self.modes.grid and not self.modes.layer then 
            self.modes.adding = true    
        end 
    end 



    if self.modes.adding   then 
        self.string_modes = "adding"

        if self:onePress("2") and not textinputs[1].takeInput then 
            self.modes.adding = false 
        end 

       
    end 
end 

function TilemapEditor:addTile(dt) 
    

 
    for i = 1, #self.layers[self.currentLayer] do 
        for j = 1, #self.layers[self.currentLayer][1] do 
         
            
            if self.layers[self.currentLayer][i][j] == 0 then 
                local gridRect = {
                x = (j-1)*globals.TILE_SIZE, y = (i-1)*globals.TILE_SIZE,width = globals.TILE_SIZE, height= globals.TILE_SIZE
                }
    
                if GameMath.rectangleCollision(gridRect, self.cursor) then 
                    self.layers[self.currentLayer][i][j] = self.cursor.img.number

                    print("AT THIS POINT: " .. self.layers[self.currentLayer][i][j])

                    --Image:new(x,y,img, quad, scale,camera, debug,number)
                    local image = Image:new(gridRect.x,gridRect.y,self.cursor.img.img,self.cursor.img.quad,self.cursor.img.ogScale,self.camera,false,self.cursor.img.number)
                    image.onTheList = false 
                    table.insert(self.tileImages, image) 
                end 
            end
         
        end 
    end 
    

end 

function TilemapEditor:removeTile() 
 for i = 1, #self.layers[self.currentLayer] do 
        for j = 1, #self.layers[self.currentLayer][1] do 
         
            
            if self.layers[self.currentLayer][i][j] ~= 0 then 
                local gridRect = {
                x = (j-1)*globals.TILE_SIZE, y = (i-1)*globals.TILE_SIZE,width = globals.TILE_SIZE, height= globals.TILE_SIZE
                }
    
                if GameMath.rectangleCollision(gridRect, self.cursor) then 
                    self.layers[self.currentLayer][i][j] = 0

                    self.em:removeByPos(gridRect.x,gridRect.y)
                    print("AT THIS POINT: " .. self.layers[self.currentLayer][i][j])


                    --remove tiles from tileImages
                    for k,v in ipairs(self.tileImages) do 
                        if v.x == gridRect.x and v.y == gridRect.y then 
                            print("bruh")
                            table.remove(self.tileImages,k)
                        end 
                    end     
                end 
            end
         
        end 
    end 
end 




function TilemapEditor:save(dt) 

    if self:onePress("o") then 
        print("called")
        WriteFile.writeTable2D(self.map_path.."/layer"..tostring(self.currentLayer)..".lua", self.layers[self.currentLayer],globals.HEIGHT/globals.TILE_SIZE,globals.WORLD_WIDTH/globals.TILE_SIZE)
    end 
end


function TilemapEditor:handleGridMouseInput(dt,arrowlists) 

    if love.mouse.isDown(1) and not arrowlists[1].arrowBeingPressed  then 
        
        if self.cursor.img ~= nil then 
            self:addTile(dt)
        end 
       
    end    
    
    if love.mouse.isDown(2) then 
        self:removeTile(dt)
    end 
end 

function TilemapEditor:update(dt) 
    local labels = self.uiManager:getComps("Label") 
    local textinputs = self.uiManager:getComps("TextInput") 
    local arrowlists = self.uiManager:getComps("ArrowList")

    self:adjustUI(labels,textinputs)
    self:gridMode(dt,arrowlists)
    self:addingMode(dt,textinputs)
    self:layerMode(dt,labels,textinputs, arrowlists)

    self.camera:clampX(0,globals.WORLD_WIDTH-globals.WIDTH)
    self.camera:update(dt)

    self.camera:resize(globals.screenWidth,globals.screenHeight)

    self.uiManager:update(dt)


    
   

    if self.cursor.img ~= nil then 
        self.cursor.img:update(dt) 
        self.cursor.img.onTheList = false 
        self.cursor.img:setBounds(self.cursor.x,self.cursor.y, self.cursor.img.width,self.cursor.img.height)
    end 

    
    
end 

function TilemapEditor:draw() 

    self.camera:scaleApply() 
    self.uiManager:draw()
    self.camera:unapply()
    
    self.camera:apply()
    if self.modes.grid then    

        for row = 0, globals.HEIGHT/globals.TILE_SIZE do 
            for col = 0, globals.WORLD_WIDTH/globals.TILE_SIZE do 
                

                love.graphics.setColor(0.1,0.3,0.9,1.0)
                love.graphics.line(0,row*globals.TILE_SIZE, globals.WORLD_WIDTH, row*globals.TILE_SIZE + 1) 
                love.graphics.line(col*globals.TILE_SIZE, 0, col*globals.TILE_SIZE + 1, globals.HEIGHT)
                love.graphics.setColor(1.0,1.0,1.0,1.0)
            end 
        end 


        if self.cursor.img == nil then 
            love.graphics.setColor(self.cursor.color.r,self.cursor.color.g,self.cursor.color.b,self.cursor.color.a) 

            love.graphics.rectangle("fill", self.cursor.x,self.cursor.y, self.cursor.width,self.cursor.height)
            love.graphics.setColor(1,1,1,1)
        else
            self.cursor.img:draw()
        end 
       
    end 


    if self.em ~=  nil then 
        self.em:draw()
    end 
  
    for k,v in ipairs(self.tileImages) do 
        v:draw() 
    end 

    self.camera:unapply() 
end     


return TilemapEditor 