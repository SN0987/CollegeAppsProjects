local UI_Manager = {}
UI_Manager.__index = UI_Manager 

function UI_Manager:new() 
    local u = setmetatable({},UI_Manager)

    u.elements = {}

    return u 
end 


function UI_Manager:addElement(element) 
    table.insert(self.elements,element)

end 

function UI_Manager:getElements(name) 

    local elements = {}
    for k,v in ipairs(self.elements) do 
        if v.name == name then 
            table.insert(elements,v) 
        end 
    end 
    return elements 
end 
function UI_Manager:getAllElements() 
    for k,v in ipairs(self.elements) do 
        return v
    end 
end 

function UI_Manager:setElements(name,list)
    for k,v in ipairs(self.elements) do 
        if v.name == name then 
            for i = 1, #list do 
                v = list[i]
            end 
        end 
    end 
end 

function UI_Manager:removeAllElementsByName(name) 
    for k,v in ipairs(self.elements) do 
        if v.name == name then 
            table.remove(self.elements,k)
        end 
    end 
end 
function UI_Manager:removeElementsFromList(name,index) 
    local index_two = 1
    for k,v in ipairs(self.elements) do 
        if v.name == name then 

            if index_two == index_two then 
                table.remove(self.elements,k)
            else
                index_two = index_two + 1
            end 
        end 
    end 


end 

function UI_Manager:getSingleElement(name) 
    for k,v in ipairs(self.elements) do 
        if v.name == name then 
            return v 
        end 
    end 
end 


function UI_Manager:update(dt,camera) 
    for k,v in ipairs(self.elements) do 
        v:update(dt, camera )

        if v.font_path == "assets/fonts/font_pixel.ttf" and v.font ~= nil then 
            v.font:setFilter("nearest","nearest")
        end 
    end 
end 


function UI_Manager:draw()
    for k,v in ipairs(self.elements) do 
        v:draw() 
    end 
end 


return UI_Manager 