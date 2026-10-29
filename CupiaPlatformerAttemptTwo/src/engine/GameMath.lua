local Events = require("engine.Events")
local GameMath = {}


function GameMath.rectangleCollision(rect_one, rect_two) 

    local rightOne = rect_one.x + rect_one.width 
    local rightTwo = rect_two.x + rect_two.width 
    local bottomOne = rect_one.y + rect_one.height 
    local bottomTwo = rect_two.y + rect_two.height 

    return (rect_one.x < rect_two.x+rect_two.width and rect_one.x + rect_one.width > rect_two.x and rect_one.y < rect_two.y+rect_two.height and rect_one.y+rect_one.height > rect_two.y)

end 


function GameMath.pointRectCollision(rect_one,x,y) 
    

    return (x >= rect_one.x and x <= rect_one.width + rect_one.x and y >= rect_one.y and y <= rect_one.height + rect_one.y )
end 



function GameMath.accelerate(velocity, acceleration,max) 

    if velocity > 0 then 

        if velocity <= max then 
            velocity = velocity + acceleration
        end 
        
    end 

    if velocity < 0 then 
        if(velocity >= -max ) then 
            velocity = velocity - acceleration
        end 
    end 

   
    

end 

function GameMath.hover(coordinate, velocity,dt) 
    
    coordinate = coordinate + (velocity*math.sin(Events.timePassed)) * dt


    return coordinate
    

end 

function GameMath.hover2(coordinate,period_speed,amplitude,dt) 
    coordinate = coordinate+(math.sin(Events.timePassed*period_speed)*amplitude)*dt
    return coordinate
end 

function GameMath.withInDistance(point_one, point_two, distance) 
    
    local dist = math.abs((point_two-point_one)) 


    if dist <= distance then 
        return true 
    end     

    return false 
end 

function GameMath.withInDiagonalDistance(vec1,vec2, distance) 

    local distX = math.pow((vec2.x-vec1.x),2)
    local distY = math.pow((vec2.y-vec1.y),2)

    local dist = math.sqrt(distX+distY)


    if dist <= distance then 
        return true 
    end 

    return false
end 


-- returns true if something is 
function GameMath.clamp(pos,min, max)
    
    if pos <= min then 

        pos = min
        return true 
    elseif pos >= max then 
        pos = max
        return true 
    end 
    

end 



return GameMath 