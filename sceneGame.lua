require("sceneManager")
require("enemy")
require("enemyScourge")
require("bullet")
require("bulletScourge")

local hero = require("hero")
local enemies = {}
local scourges = {}
local sceneGame = newScene("game")

local spawn = false
local spawnTimer = 0
local spawnScourgeTimer = 0
local startTimer = 0

local heroStart = false

sceneGame.load = function(data)
    loadShake()
    hero.load()
    spawn = false
    heroStart = false
    hero.speed = 0
    startTimer = 4
    startShake(duration, magnitude)
    
end

sceneGame.unLoad = function()
    initEnemies()
    initBullets()
    initEffects()
    initScourge()
end

sceneGame.update = function(dt)
    updateShake(dt)

    startTimer = startTimer - (1 * dt)
    if startTimer <= 1 then
        spawn = true
        heroStart = true
    end

    if heroStart == true then
        hero.speed = 400
        updateBullets(dt)
        checkCollisions(enemies)
        checkCollisions(scourges)

        updateBlast(dt)
        updateParticule(dt)
    end

    hero.update(dt, spawn)

    for _, enemy in ipairs(enemies) do
        enemy.update(dt)
    end

    for _, scourge in ipairs(scourges) do
        scourge.update(dt)
    end

    if spawn == true then
        spawnTimer = spawnTimer + (1 * dt)
        if spawnTimer >= 1 then
            --table.insert(enemies, createEnemy())
            spawnTimer = 0
        end

        spawnScourgeTimer = spawnScourgeTimer + (1 * dt)
        if spawnScourgeTimer >= 3 then
            table.insert(scourges, createScourge())
            spawnScourgeTimer = 0
        end
    end

    if spawn == false then
        spawnTimer = 0
        for e = 1, #enemies do
            table.remove(enemies, e)
        end
        for s = 1, #scourges do
            table.remove(scourges, s)
        end
    end


    for i = #enemies, 1, -1 do
        if enemies[i].free then
            table.remove(enemies, i)
        end
    end
    for n = #scourges, 1, -1 do
        if scourges[n].free then
            table.remove(scourges, n)
        end
    end
end

sceneGame.draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)

    love.graphics.printf("SCORE: " .. hero.score, 0, 10, 1000, "center")
    if startTimer >= 1 then
        setFont("Pixelfraktur", 150)
        love.graphics.printf(math.floor(startTimer), 0, 100, 1000, "center")
        setFont("Bitmgothic", 20)
    end

    if spawn == true then
        shakeDraw()
        hero.laserDraw()
        for _, enemy in ipairs(enemies) do
            --enemy.draw()
        end

        for _, scourge in ipairs(scourges) do
            scourge.draw()
        end

        drawBullets()
        drawBlast()
        drawParticule()
        hero.drawTarget()
    end
    hero.draw()

    --love.graphics.printf("number of enemies: "..#enemies, 10, 10 + 16 * 2)
    --love.graphics.printf("SpawnTimer: "..spawnTimer, 10, 10 + 16 * 3)

    --drawBulletDebug()
    --hero.drawDebug()
end
