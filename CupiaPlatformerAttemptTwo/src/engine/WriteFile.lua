local WriteFile = {}
local Image = require("engine.UI.Image")

function WriteFile.writeTable2D(path,table,row,col) 
    local file, err = io.open(path,"w") 

    if not file then 
        print("Could Not Create or Write to File: " .. err) 

    else

        file:write("return {\n")    
      
        for i = 1, row do 
            file:write("{")
            for j = 1, col do 

                if j ~= col then 
                    file:write(tostring(table[i][j]) .. ",")

                    
                else
                    file:write(tostring(table[i][j]))
                end 
                
            end 

            if i ~= row then 
                file:write("},\n")
            else
                file:write("}\n")
            end 
            
        end 

        file:write("}")
        file:close() 
    end     

end 


function WriteFile.checkLoveFile(path) 
    local info  = love.filesystem.getInfo(path,"file")
    
    if info then 
        return true 

    else

        print("Not Found File")
        return false 
    end 


end 

function WriteFile.writeString(path,string) 
    local file, err = io.open(path, "w") 

    if not file then 
        print("Could Not Create File: " .. err) 

    else 

        file:write(string) 
        file:close() 
    end 
end 


function WriteFile.writeImageTable(path, images)

    local file, err = io.open(path, "w")

    if not file then
        print("Could not open file: " .. err)
        return false
    end

    file:write("return {\n")

    for _, v in ipairs(images) do

        local srcX, srcY, srcWidth, srcHeight =
            v.quad:getViewport()


        --table[1] = srcX table[2] = srcY table[3] = srcWidth table[4] = srcHeight table[5] = ogScaleX table[6] = ogScaleY table[7] = debug table[8] = number 
        file:write(
            "    {",
            srcX, ",",
            srcY, ",",
            srcWidth, ",",
            srcHeight, ",",
            v.ogScale.x, ",",
            v.ogScale.y, ",",
            tostring(v.debug), ",",
            tostring(v.number),
            "},\n"
        )

    end

    file:write("}\n")

    file:close()

    return true
end
function WriteFile.readString(path) 
    local file, err = io.open(path, "r") 

    if not file then 
        print("No File To Open " .. path) 
    else
        local table = file:read("*all") 
        file:close() 

        return table
    end 
end 

function WriteFile.readTable2D(path)
    local chunk, err = loadfile(path)
    

    if not chunk then 
        print("Failed to load 2d table " .. err) 
    else
        return chunk()
    end 

end 

return WriteFile