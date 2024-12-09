require("sceneManager")


local sceneGameOver = newScene("gameover")
local hero = require("hero")

sceneGameOver.load = function(data)
    print(data)
    spawn = false

end

sceneGameOver.update = function(dt)

end

sceneGameOver.draw = function()
    love.graphics.print("GAMEOVER", SCR_WIDTH/2, SCR_HEIGHT/2)
    love.graphics.print("SCORE:"..hero.score, SCR_WIDTH/2, SCR_HEIGHT/2 + 16)
end

sceneGameOver.keypressed = function(key)
    if key == "space" then
        changeScene("menu", "Scene loaded...")
        hero.score = 0
    end  
end