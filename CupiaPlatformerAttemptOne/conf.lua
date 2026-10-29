local consts = require("consts")

function love.conf(t) 
    
    t.window.width = consts.settings.screen_width
    t.window.height = consts.settings.screen_height
    t.window.minWidth = consts.WIDTH
    t.window.minHeight = consts.HEIGHT

    t.window.fullscreen = consts.settings.fullscreen
    t.console = true 
    t.window.resizable = false
end  