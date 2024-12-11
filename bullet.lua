require("utils")
require("effects")
require("hero")
local bullets = {}
local bulletTrailList = {}


function newBullet()
    local bullet = {}
    bullet.x = 0
    bullet.y = 0
    bullet.angle = 0
    bullet.vx = 0
    bullet.vy = 0
    bullet.speed = 500
    bullet.damage = 10
    bullet.radius = 7
    bullet.startX = 0
    bullet.startY = 0
    bullet.range = 1000
    bullet.free = false

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

        bulletTrail = {}
        bulletTrail.x = bullet.x
        bulletTrail.y = bullet.y
        bulletTrail.r = bullet.radius
        bulletTrail.life = 0.15
        table.insert(bulletTrailList, bulletTrail)

        for n=#bulletTrailList,1,-1 do 
            local trail = bulletTrailList[n]
            trail.life = trail.life - dt
            if trail.life <= 0 then
                table.remove(bulletTrailList, n)

            end
        end

        local dist = math.dist(bullet.startX, bullet.startY, bullet.x, bullet.y)

        if dist > bullet.range then
            bullet.queueFree()
        end
    end

    bullet.draw = function(dt)
        for n=1,#bulletTrailList do
            local trail = bulletTrailList[n]
            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", trail.x, trail.y, trail.r )
            love.graphics.setColor(1,1,1,1)
        end
    end

    bullet.queueFree = function()
        print("free bullet")
        bullet.free = true
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