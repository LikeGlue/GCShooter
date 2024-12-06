require("sceneManager")
require("enemy")
require("bullet")

local enemy = require("enemy")
local hero = require("hero")
local enemies = {}
local score = 0

local sceneGame = newScene("game")

sceneGame.load = function(data)
    print(data)
    hero.load()
    enemy.createEnemy()
end

sceneGame.update = function(dt)
    hero.update(dt)
    enemy.update(dt)
    --checkCollisions(enemies)
    updateBullets(dt)

end

sceneGame.draw = function()
    hero.draw()
    enemy.draw()
 
    drawBullets()
    drawBulletDebug()
end
