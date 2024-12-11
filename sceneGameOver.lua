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
    setFont("Pixelfraktur", 250)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("GAME",0,20,1040,"center")
    love.graphics.printf("OVER",0,370,1040,"center")
    setFont("Bitmgothic", 50)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Score: "..hero.score,0,230,1040,"center")
    love.graphics.printf("Press SPACE to enter menu",0,300,1040,"center")

end

sceneGameOver.keypressed = function(key)
    if key == "space" then
        changeScene("menu", "Scene loaded...")
        hero.score = 0
    end  
end