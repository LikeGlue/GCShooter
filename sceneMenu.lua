require("sceneManager")

local sceneMenu = newScene("menu")

sceneMenu.load = function(data)
    spawn = false
end

sceneMenu.update = function(dt)

end

sceneMenu.draw = function()
    love.graphics.print("MENU", SCR_WIDTH/2, SCR_HEIGHT/2)
end

sceneMenu.keypressed = function(key)
    if key == "space" then
        changeScene("game", "Scene loaded...")
    end
end 