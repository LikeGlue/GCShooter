require("utils")
require("effects")
require("hero")
local bullets = {}
--local bulletTrailList = {}

function newBullet()
    local bullet = {}
    bullet.x = 0
    bullet.y = 0
    bullet.angle = 0
    bullet.vx = 0
    bullet.vy = 0
    bullet.speed = 1200
    bullet.damage = 10
    bullet.radius = 8
    bullet.startX = 0
    bullet.startY = 0
    bullet.range = 1000
    bullet.free = false  

    bullet.trailList = {}

    bullet.createTrail = function(x,y,r)
        print("bullet trail nb: "..#bullets)
        local bulletTrail = {}
        bulletTrail.x = x
        bulletTrail.y = y
        bulletTrail.radius = r
        bulletTrail.life = 0.03
        table.insert(bullet.trailList, bulletTrail)
    end

    bullet.updateTrail = function(dt)
        for n=#bullet.trailList,1,-1 do 
            local trail = bullet.trailList[n]
            trail.life = trail.life - dt
            if trail.life <= 0 then
                table.remove(bullet.trailList, n)
            end
        end
    end

    bullet.fire = function(x, y, angle)
        bullet.x = x
        bullet.y = y
        bullet.vx = math.cos(angle) * bullet.speed
        bullet.vy = math.sin(angle) * bullet.speed
        bullet.startX = x
        bullet.startY = y
    end

    bullet.update = function(dt)
        bullet.x = bullet.x + bullet.vx * dt
        bullet.y = bullet.y + bullet.vy * dt
        
        bullet.createTrail(bullet.x, bullet.y, bullet.radius)
        bullet.updateTrail(dt)


        local dist = math.dist(bullet.startX, bullet.startY, bullet.x, bullet.y)
        if dist > bullet.range then
            bullet.queueFree()
        end
    end

    bullet.queueFree = function()
        print("free bullet")
        bullet.free = true
    end

    bullet.draw = function()
        for n=1,#bullet.trailList do
            local trail = bullet.trailList[n]
            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", trail.x, trail.y, trail.radius )
            love.graphics.setColor(1,1,1,1)
        end
    end

    table.insert(bullets, bullet)
    return bullet
end


function updateBullets(dt)

    for _,bullet in ipairs(bullets) do
        
        bullet.update(dt)
    end

    for i=#bullets, 1, -1 do
        if bullets[i].free then
            table.remove(bullets, i)
        end
    end
end

function drawBullets()
    for _,bullet in ipairs(bullets) do
        bullet.draw()
    end
end

function drawBulletDebug()
    love.graphics.print("Bullets: "..#bullets, 10, 10)
end

function checkCollisions(enemies)
    for _,bullet in ipairs(bullets) do
        for _,enemy in ipairs(enemies) do
            if isIntersecting(bullet.x, bullet.y, bullet.radius, enemy.x, enemy.y, enemy.radius) then
                enemy.takeDamage(bullet.damage)
                ajouteExplosion(bullet.x,bullet.y, bullet.angle)
                bullet.queueFree()
            end       
        end
    end
end

function initBullets()
    bullets = {}
    bulletTrailList = {}
end