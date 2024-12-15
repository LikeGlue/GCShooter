require("sceneManager")
require("utils")

local sceneMenu = newScene("menu")

sceneMenu.load = function()
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
    love.graphics.printf("Press SPACE to start",0,450,1000,"center")
    setFont("Bitmgothic", 15)
    love.graphics.setColor(1,1,1,0.2)
    love.graphics.printf("Press ENTER for credits",0,550,1850,"center")
    love.graphics.setColor(1,1,1,1)
    
end

sceneMenu.keypressed = function(key)
    if key == "space" then
        changeScene("game", "Scene loaded...")
    end
    if key == "return" then
        changeScene("credits", "Scene loaded...")
    end
end 