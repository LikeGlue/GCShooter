require("sceneManager")

local sceneGameOver = newScene("gameover")

sceneGameOver.load = function(data)
    print(data)
end

sceneGameOver.update = function(dt)

end

sceneGameOver.draw = function()
    love.graphics.print("GAMEOVER", SCR_WIDTH/2, SCR_HEIGHT/2)
end

sceneGameOver.keypressed = function(key)
    if key == "space" then
        changeScene("menu", "Scene loaded...")
    end  
end