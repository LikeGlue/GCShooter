require("sceneManager")
require("enemy")
require("bullet")

local hero = require("hero")
local enemies = {}
local score = 0

local sceneGame = newScene("game")

sceneGame.load = function(data)
    print(data)
    hero.load()
    for i=1,10 do
        table.insert(enemies, createEnemy())
    end
    print("number of enemies: "..#enemies)
end

sceneGame.update = function(dt)
    hero.update(dt)

    for _, enemy in ipairs(enemies) do
        enemy.update(dt)
    end

    updateBullets(dt)
    checkCollisions(enemies)
    

    for i=#enemies, 1, -1 do
        if enemies[i].free then
            table.remove(enemies, i)
        end
    end

end

sceneGame.draw = function()
    hero.draw()
    for _, enemy in ipairs(enemies) do
        enemy.draw()
    end
 
    drawBullets()
    drawBulletDebug()
end
