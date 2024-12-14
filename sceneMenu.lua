require("sceneManager")
require("utils")

local sceneMenu = newScene("menu")

sceneMenu.load = function(data)
    spawn = false
end

sceneMenu.update = function(dt)
    
end

sceneMenu.draw = function()

    setFont("Pixelfraktur", 240)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("XSHTX",0,180,1040,"center")
    love.graphics.setColor(1,1,1)
    setFont("Bitmgothic", 30)
    love.graphics.printf("Press SPACE to start",0,500,1000,"center")
end

sceneMenu.keypressed = function(key)
    if key == "space" then
        changeScene("game", "Scene loaded...")
    end
end 