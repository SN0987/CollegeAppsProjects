
local ser = require("libs.ser")

local handle_data = function(file_name,information_table)
    local data = nil 

    local data_file_info = love.filesystem.getInfo(file_name)

    if data_file_info == nil then 
        data = information_table
        

        love.filesystem.write(file_name,ser(data))

        print("NEW FILE CREATED IN LOVE2D DIR: " .. file_name)

    else

        local chunk, err = love.filesystem.load(file_name)

        if chunk then 
            data = chunk()
        end 
        

        if data == nil then 
            print("DATA AT: " .. file_name .. " IS NOT LOADING")
        end 
    end 

    return data  


end 

return handle_data