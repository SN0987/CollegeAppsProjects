local UIManager = {}
UIManager.__index = UIManager

function UIManager:new(camera) 
    local um = setmetatable({}, UIManager )


    um.camera = camera 

    --contain all the elements

    um.comps = {}


    um.debug = true 

    return um 
end 

function UIManager:setDebug(bool)
    self.debug = bool  
end 

function UIManager:add(comp)
    local index = 0

    for k,v in ipairs(comp) do 
        if comp.type == v.type then 
            index = index + 1
        end 
    end 

    comp.type = comp.type .. index 
    

    table.insert(self.comps,comp)

    return index
end 


function UIManager:getComps(comp_type) 
    
    local comp_list = {}
    for k,v  in ipairs(self.comps) do 
        local spos, epos = string.find(v.type, comp_type, 1, true) 


        if spos then 
            table.insert(comp_list,v) 
        end
        
    end 

    return comp_list 
end 

function UIManager:update(dt )

    for k, v in ipairs(self.comps) do 
        v.debug = self.debug
        v:updateParent(dt)

        v:update(dt)
  
    end 
end 

function UIManager:listDraw() 
    for k,v in ipairs(self.comps) do 

        if v.visible then 
            v:draw() 
        end 
      
    end 
end 
function UIManager:draw() 



    self:listDraw()
 
end 


return UIManager