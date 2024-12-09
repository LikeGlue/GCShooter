require("sceneManager")
require("enemy")
require("bullet")

local hero = require("hero")
local bullets = {}
local enemies = {}
local sceneGame = newScene("game")

local spawn = false
local spawnTimer = 0

MAP_WIDTH = 16
MAP_HEIGHT = 9
TILE_HEIGHT = 64
TILE_WIDTH = 64

sceneGame.load = function(data)
    hero.load()
    spawn = true

    if spawn == true then
        for i=1,1 do
            table.insert(enemies, createEnemy())
        end
    end
    
end

sceneGame.unLoad = function()
    spawn = false -- problème j'ai cette operation dans update et c'est la seule condition pour que ça marche
    spawnTimer = 0
    for e=1,#enemies do
        table.remove(enemies, e)
    end
    for b=1,#bullets do
        table.remove(bullets, b)
    end
end

sceneGame.update = function(dt)

     if spawn == true then
        hero.update(dt)
        for _, enemy in ipairs(enemies) do
            enemy.update(dt)
        end
        updateBullets(dt)
        checkCollisions(enemies)
        updateBlast(dt)
        updateParticule(dt)

        spawnTimer = spawnTimer + (1 * dt)
        if spawnTimer >= 1 then
            table.insert(enemies, createEnemy())
            spawnTimer = 0
        end
    end
    
    if spawn == false then
        spawnTimer = 0
        for e=1,#enemies do
            table.remove(enemies, e)
        end
        for b=1,#bullets do
            table.remove(bullets, b)
        end
    end  

    for i=#enemies, 1, -1 do
        if enemies[i].free then
            table.remove(enemies, i)
            hero.score = hero.score + 100
        end
    end

end

sceneGame.draw = function()
    love.graphics.setBackgroundColor(0.89,0.796,0.678)
   

    hero.draw()
    if spawn == true then
        for _, enemy in ipairs(enemies) do
            enemy.draw()
        end
    end
    hero.drawTarget()
    love.graphics.print("SCORE: "..hero.score, SCR_WIDTH/2, 10 )
    love.graphics.print("number of enemies: "..#enemies, 10, 10 + 16 * 2)
    love.graphics.print("SpawnTimer: "..math.floor(spawnTimer), 10, 10 + 16 * 3)



    drawBullets()
    
    drawBulletDebug()
    --hero.drawDebug()
    drawBlast()
    drawParticule()
end
