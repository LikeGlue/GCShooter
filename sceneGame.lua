require("sceneManager")
require("enemy")
require("bullet")

local hero = require("hero")
local enemies = {}
local sceneGame = newScene("game")

local spawn = false
local spawnTimer = 0
local startTimer = 0
local heroStart = false

MAP_WIDTH = 16
MAP_HEIGHT = 9
TILE_HEIGHT = 64
TILE_WIDTH = 64



sceneGame.load = function(data)
    hero.load()
    spawn = false
    heroStart = false
    hero.speed = 0
    startTimer = 4
    
end

sceneGame.unLoad = function()
    initEnemies()
    initBullets()
end

sceneGame.update = function(dt)

    startTimer = startTimer - (1 * dt)
    if startTimer <= 1 then
        spawn = true
        heroStart = true
    end

    if heroStart == true then
        hero.speed = 400
        updateBullets(dt)
        checkCollisions(enemies)
        updateBlast(dt)
        updateParticule(dt)
    end

    hero.update(dt,spawn)

    for _, enemy in ipairs(enemies) do
        enemy.update(dt)
    end

    if spawn == true then
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
    end  

    for i=#enemies, 1, -1 do
        if enemies[i].free then
            table.remove(enemies, i)
        end
    end
end

sceneGame.draw = function()
    love.graphics.setBackgroundColor(0,0,0)
   
    hero.draw()
    if spawn == true then
        for _, enemy in ipairs(enemies) do
            enemy.draw()
        end
        drawBullets()
        drawBlast()
        drawParticule()
    end

    if startTimer >= 1 then
        setFont("Pixelfraktur", 150)
         love.graphics.printf(math.floor(startTimer),0,100,1000,"center")
         setFont("Bitmgothic", 20)
    end

    hero.drawTarget()
    love.graphics.printf("SCORE: "..hero.score,0,10,1000,"center")
    --love.graphics.printf("number of enemies: "..#enemies, 10, 10 + 16 * 2)
    --love.graphics.printf("SpawnTimer: "..spawnTimer, 10, 10 + 16 * 3)

    --drawBulletDebug()
    --hero.drawDebug()
end
