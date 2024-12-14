local hero = require("hero")
require("utils")


spriteList = {}
enemyShotsList = {}
extraEnemyList = {}

local ESTATES = {}
ESTATES.NONE = ""
ESTATES.CHARGE = "charge"
ESTATES.ATTACK = "attack"
ESTATES.SHOOT = "shoot"
ESTATES.CHANGEDIR = "change"

function newEnemy(pType,pX,pY)
    local pImg = ""
    if pType == 1 then
        pImg = "enemy2"
    elseif pType == 2 then
        pImg = "enemy3"
    end

    local extraEnemy = newSprites(pImg,pX,pY)

    extraEnemy.sleep = true
    extraEnemy.shootTimer = 0

    if pType == 1 then
        extraEnemy.range = 300
    elseif pType == 2 then
        --
    end

    table.insert(extraEnemyList,extraEnemy)
end

function newSprites(pImg,pX,pY)

    sprite = {}
    sprite.x = pX
    sprite.y = pY
    sprite.delete = false
    sprite.img = love.graphics.newImage("images/"..pImg..".png")
    sprite.w = sprite.img:getWidth()
    sprite.h = sprite.img:getHeight()
    sprite.radius = 20
    sprite.speed = 100
    sprite.angle = 0
    sprite.state = ESTATES.CHARGE
    sprite.range = 0

    table.insert(spriteList,sprite)
    return sprite
end

function checkHeroDistance()
    if math.dist(hero.x, hero.y, sprite.x, sprite.y) < sprite.radius then
        changeScene("gameover", "Scene loaded...")
    end
end

function loadEnemies()
    newEnemy(1, 100, 100)
end

function createShots(pImg, pX, pY, pVX, pVY)
    local shot = newSprites(pImg, pX, pY)
    shot.type = pType
    shot.vx = pVitesseX
    shot.vy = pVitesseY
    table.insert(enemyShotsList, shot)
    
    --sonShoot:play()
end


function updateExtraEnemies(dt)
    checkHeroDistance()

    for n=#extraEnemyList,1,-1 do
        local enemy = extraEnemyList[n]

        if enemy.state == ESTATES.NONE then
            Print("***ERROR STATE NIL***")
        end

        if enemy.state == ESTATES.NONE then
            enemy.state = ESTATES.CHARGE
        end

        if enemy.state == ESTATES.CHARGE then
            if enemy.type == 1 then
                enemy.angle = math.atan2(hero.y - enemy.y, hero.x - enemy.x)
                enemy.x = enemy.x + math.cos(enemy.angle) * enemy.speed * dt
                enemy.y = enemy.y + math.sin(enemy.angle) * enemy.speed * dt

                local distance = math.dist(enemy.x, enemy.y, hero.x, hero.y)
                if distance < enemy.range then
                    enemy.state = ESTATES.SHOOT
                end
            end
        end

        if enemy.state == ESTATES.SHOOT then
            if enemy.type == 1 then 
                enemy.angle = math.atan2(hero.y - enemy.y, hero.x - enemy.x)
                enemy.x = enemy.x + math.cos(enemy.angle) * dt
                enemy.y = enemy.y + math.sin(enemy.angle) * dt

                enemy.shootTimer = sprite.shootTimer - 1*(60*dt)
                if enemy.shootTimer <= 0 then
                    enemy.shootTimer = 40
                    createShots("enemyBullet",enemy.x,enemy.y,vx,vy)
                end
            end
        end

        for n=#spriteList,1,-1 do
            if spriteList[n].delete == true then
                table.remove(spriteList,n)
            end
        end
    end

    function updateShots(dt)
        print("Enemy bullets: "..#enemyBulletList)

        for n=#enemyBulletList,1,-1 do
            local shots = enemyBulletList[n]
            shots.x = shots.x + shots.vx
            shots.y = shots.y + shots.vy
            

            if shots.y < 0 or shots.y > SCR_HEIGHT or shots.x < 0 or shots.x > SCR_WIDTH then 
                shots.delete = true
                table.remove(enemyBulletList, n)
            end
        end
    end
end

function drawSprites()
    for n=1,#spriteList do
        local s = spriteList[n]
        local r = sprite.angle + math.pi/2
        love.graphics.draw(s.img, s.x, s.y, r, 1, 1, s.w/2, s.h/2)
    end
end