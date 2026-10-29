local consts = require("consts")
local Tile = require("Game.Tile")
local Camera = require("Engine.Camera")

local Map = require("Engine.Map")
local copy = require("libs.copy")
local TileMapEditor = {}


TileMapEditor.__index = TileMapEditor

function TileMapEditor:new(file_name,rows,columns)

    local t = setmetatable({},TileMapEditor)

    t.edit = false 
    t.file_name = file_name 

    t.rows = rows 
    t.columns = columns 
    t.width = t.rows * consts.TILE_SIZE
    t.height = t.columns * consts.TILE_SIZE

  
    t.mapped = false 
 
    t.map = {}
    t.mapped = false 


    t.camera = Camera:new(0,0,consts.WIDTH,consts.HEIGHT)
   

    for i = 1, columns do 
        t.map[i] = {}
        for j=1, rows do 
            t.map[i][j] = 0 
        end 
    end 
          
    

    t.entityMode = false 
    

  

  


    t.mouseRect = {
        x = love.mouse.getX(),
        y = love.mouse.getY(),
        width = consts.TILE_SIZE,
        height = consts.TILE_SIZE,
        tile = nil,
        entity = nil,
        
    }

    t.tiles = {}
    t.entities = {}
    
    t.tiles_key = {}
    t.entity_keys = {}
    t.tile_counter = 1 
    t.entity_counter = 1 
    t.camera_speed = 250
    t.right_key = false 
    t.left_key = false 

    return t 


end 


function TileMapEditor:switchTile(tile,count) 
    if self.tiles_key[count] == nil then 
        self.tiles_key[count] = tile 
    end 
    
   
end 

function TileMapEditor:switchEntity(entity,count) 

    -- entity will have property of value and e 
    --[[
        for k,v in pairs(self.entity_keys) do 
            v.e 
            v.value 
        end
    ]]
    if self.entity_keys[count] == nil then 
        self.entity_keys[count] = entity  
    end 
end 

function TileMapEditor:add(tilemap_key) 
    
    for k,v in ipairs(tilemap_key) do
        
        local tile = v

        --if v.anim_args == nil then 
            tile = Tile:new(0,0,v.width,v.height,v.col_status,"simple",v.name,v.img_args,nil,v.value)
        --else
           -- tile = Tile:new(9,0,v.width,v.height,v.col_status,"simple",v.name,v.img_args,v.anim_args,v.value)
       -- end 


        self:switchTile(tile,k)

        
    end

end 



function TileMapEditor:addEntityKey(entity_key) 
    for k,v in ipairs(entity_key) do 
        
        
        local entity = {
            e = v.entity, 
            value = v.value 
        }
        
        self:switchEntity(entity,k)

    end 
end 
function TileMapEditor:serialize() 
    local lines = {}

    for i = 1, #self.map do 
        local row = self.map[i]
        local line = table.concat(row,",")
        table.insert(lines,line)
    end 

    return table.concat(lines,"\n")
end 


function TileMapEditor:save() 
    local file, err = io.open(self.file_name,"w")

    if not file then 
        print("NO FILE: " .. self.file_name .. err)
        
    end 

    file:write("return {\n")
    for i = 1, #self.map do
        local row = self.map[i]
        file:write(" {")
        for j = 1, #row do 
            file:write(tostring(row[j]))
            if j < #row then 
                file:write(", ")
            end 
        end 
        file:write("},\n")
    end
    
    file:write("}\n")
    file:close()


end 


function TileMapEditor:update(dt,screen)
    
    if love.keyboard.isDown("space") then 
        if self.edit == false then 
            self.edit = true  
        end 

        
    end 

    if love.keyboard.isDown("1") then
        
        self.entityMode = false 
    end

    if love.keyboard.isDown("2") then 
        self.entityMode = true 
    end 

    if love.keyboard.isDown("return") then 
        if self.edit then 
            self.edit = false 
        end 
    end 

    if self.edit then 
        

      
        if self.mouseRect.tile ~= nil or self.mouseRect.entity ~= nil then
            local leftKeyDown = love.keyboard.isDown("left")
            local rightKeyDown = love.keyboard.isDown("right")
            if leftKeyDown and not self.left_key then
                
                if not self.entityMode then 
                    if self.tile_counter > 1 then 
                        self.tile_counter = self.tile_counter - 1
                    end 
                end 

                if self.entityMode then 
                    if self.entity_counter > 1 then 
                        self.entity_counter = self.entity_counter - 1
                    end 
                end 
        
            end

            if rightKeyDown and not self.right_key then

                if not self.entityMode then 
                    if self.tile_counter < #self.tiles_key then 
                        self.tile_counter = self.tile_counter + 1
                    end 
                end 

                if self.entityMode then 
                    if self.entity_counter < #self.entity_keys then 
                        self.entity_counter = self.entity_counter + 1

                        print(self.entity_counter)
                    end 
                end 
              

            end

            self.right_key = rightKeyDown
            self.left_key = leftKeyDown
            
        end
        local mx,my = self.camera:globalMousePos()

        

        self.mouseRect.x = math.floor(mx / consts.TILE_SIZE) * consts.TILE_SIZE
        self.mouseRect.y = math.floor(my / consts.TILE_SIZE) * consts.TILE_SIZE

        if not self.entityMode then
            self.mouseRect.tile = self.tiles_key[self.tile_counter]
            self.mouseRect.tile:update(dt)
        end

        if self.entityMode then
            
            self.mouseRect.entity = self.entity_keys[self.entity_counter].e
            self.mouseRect.entity.img_dst_rect.x = self.mouseRect.x 
            self.mouseRect.entity.img_dst_rect.y = self.mouseRect.y
        end
        if love.keyboard.isDown("a") then 
            self.camera:move(dt,{x=-self.camera_speed,y=0})
        elseif love.keyboard.isDown("d") then 
            self.camera:move(dt,{x=self.camera_speed,y=0})
        end 
        self.camera:clampX(0,consts.WORLD_WIDTH-consts.WIDTH)
        self.camera:clampY(0,consts.HEIGHT)

        
        --self.mouseRect.x = love.mouse.getX() 
        --self.mouseRect.y = love.mouse.getY() 

        if love.mouse.isDown(1) then 


                
            for i = 1, #self.map do 
                for j = 1, #self.map[i] do 

                    local x = (j-1)*consts.TILE_SIZE
                    local y = (i-1)* consts.TILE_SIZE 

                    local width = consts.TILE_SIZE
                    local height = consts.TILE_SIZE

                    if self.mouseRect.x < x + width and self.mouseRect.x + width > x and self.mouseRect.y < y+height and self.mouseRect.y + height > y then 

                        if not self.entityMode then 
                            if self.map[i][j] == 0 then 

                                    
                                local p = self.tiles_key[self.tile_counter]
                                local newTile = Tile:new(x,y,p.width,p.height,p.collider_status,"simple",p.name,p.img_args,nil)
                                table.insert(self.tiles,newTile)

                                self.map[i][j] = p.value
                                print("I: " .. i) 
                                print("J: " .. j)
                            end 
                        end 
                            
                        if self.entityMode then 
                            if self.map[i][j] == 0 then 
                                local p = self.entity_keys[self.entity_counter].e
                           
                                local value = self.entity_keys[self.entity_counter].value
                                local a = copy.deep(p)
                                print(a.id)
                                a.x = x 
                                a.y = y
                                table.insert(self.entities,a)
                                self.map[i][j] = value
                                print(self.map[i][j])
                            end 
                        end 
        
                    end 
                    
                    
                end 
            end
            
        
    
             
            

            
        end 

        if love.keyboard.isDown("x") then 

            if not self.entityMode then 
                for i = 1, #self.map do 
                    for j = 1, #self.map[i] do 

                        local x = (j-1)*consts.TILE_SIZE
                        local y = (i-1)* consts.TILE_SIZE 

                        local width = consts.TILE_SIZE
                        local height = consts.TILE_SIZE


                        
                        if self.mouseRect.x < x + width and self.mouseRect.x + width > x and self.mouseRect.y < y+height and self.mouseRect.y + height > y then 

                            if not self.entityMode then 
                                for t = #self.tiles, 1, -1 do
                                    local tile = self.tiles[t]
                                    if tile.x == x and tile.y == y then
                                        table.remove(self.tiles, t)
                                        break
                                    end
                                end
                            end 

                            if self.entityMode then 
                                for e = #self.entities, 1, -1 do
                                    local entity = self.tiles[e]
                                    if entity.x == x and entity.y == y then
                                        table.remove(self.entities, e)
                                        break
                                    end
                                end
                            end 
                         

                            self.map[i][j] = 0
                            
                        end 
                    
                    
                    end 
                end
            end 
        
        end 

        if love.keyboard.isDown("s") then 
            
            self:save()
        end 
 
 
     

        if self.mouseRect.tile ~= nil and not self.entityMode then
         
            self.mouseRect.tile.x = self.mouseRect.x 
            self.mouseRect.tile.y = self.mouseRect.y  
            
        

            self.mouseRect.entity = nil 
        end

        if self.entityMode then 
            self.mouseRect.tile = nil 
            if self.mouseRect.entity ~= nil then 
                self.mouseRect.entity.x = self.mouseRect.x 
                self.mouseRect.entity.y = self.mouseRect.y 
            end 
        end 
    end 

    for k,v in ipairs(self.tiles) do
        
        v:update(dt,self.camera)
    end

    self.camera:update(dt)
    

end 

function TileMapEditor:draw()


    self.camera:scaleWithGraphics()
  
    self.camera:apply()


    -- i is y
    -- j is x 
    for k,v in ipairs(self.tiles) do 
        love.graphics.setColor(1.0,1.0,1.0,1.0)
        v:draw(nil)
        love.graphics.setColor(1.0,1.0,1.0,1.0)
    end 

    for k,v in ipairs(self.entities) do 
        love.graphics.setColor(1,1,1,1)
        v:draw(self.camera)
        love.graphics.setColor(1,1,1,1)
    end 

    if self.edit then 
        if self.mouseRect.tile == nil and self.mouseRect.entity == nil then 
            love.graphics.setColor(0.1,1,0.3,0.8)

            love.graphics.rectangle("fill",self.mouseRect.x,self.mouseRect.y,self.mouseRect.width,self.mouseRect.height)

            love.graphics.setColor(1.0,1.0,1.0,1.0)
        elseif self.mouseRect.tile ~= nil then 
            love.graphics.setColor(1.0,1.0,1.0,1.0)
            self.mouseRect.tile:draw()
        elseif self.mouseRect.entity ~= nil then 
            love.graphics.setColor(1.0,1.0,1.0,1.0)
            self.mouseRect.entity:draw()
            
        end 
    
        for i = 1,#self.map do 
            for j = 1, #self.map[i] do 
                love.graphics.setColor(0,0,1,1)
                love.graphics.rectangle("line",(j-1)*consts.TILE_SIZE,(i-1)*consts.TILE_SIZE,consts.TILE_SIZE,consts.TILE_SIZE)
                
            end    
        end 
    end 

    self.camera:unapply()
    self.camera:unscale()
  


 
end 

return TileMapEditor