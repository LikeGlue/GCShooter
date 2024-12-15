require("utils")
require("effects")
require("hero")
local scourgeBullets = {}
--local scourgeBulletTrailList = {}

function newscourgeBullet()
    local scourgeBullet = {}
    scourgeBullet.x = 0
    scourgeBullet.y = 0
    scourgeBullet.angle = 0
    scourgeBullet.vx = 0
    scourgeBullet.vy = 0
    scourgeBullet.speed = 1200
    scourgeBullet.damage = 10
    scourgeBullet.radius = 8
    scourgeBullet.startX = 0
    scourgeBullet.startY = 0
    scourgeBullet.range = 1000
    scourgeBullet.free = false  

    scourgeBullet.trailList = {}

    scourgeBullet.createTrail = function(x,y,r)
        local scourgeBulletTrail = {}
        scourgeBulletTrail.x = x
        scourgeBulletTrail.y = y
        scourgeBulletTrail.radius = r
        scourgeBulletTrail.life = 0.03
        table.insert(scourgeBullet.trailList, scourgeBulletTrail)
    end

    scourgeBullet.updateTrail = function(dt)
        for n=#scourgeBullet.trailList,1,-1 do 
            local trail = scourgeBullet.trailList[n]
            trail.life = trail.life - dt
            if trail.life <= 0 then
                table.remove(scourgeBullet.trailList, n)
            end
        end
    end

    scourgeBullet.fire = function(x, y, angle)
        scourgeBullet.x = x
        scourgeBullet.y = y
        scourgeBullet.vx = math.cos(angle) * scourgeBullet.speed
        scourgeBullet.vy = math.sin(angle) * scourgeBullet.speed
        scourgeBullet.startX = x
        scourgeBullet.startY = y
    end

    scourgeBullet.update = function(dt)
        scourgeBullet.x = scourgeBullet.x + scourgeBullet.vx * dt
        scourgeBullet.y = scourgeBullet.y + scourgeBullet.vy * dt
        
        scourgeBullet.createTrail(scourgeBullet.x, scourgeBullet.y, scourgeBullet.radius)
        scourgeBullet.updateTrail(dt)


        local dist = math.dist(scourgeBullet.startX, scourgeBullet.startY, scourgeBullet.x, scourgeBullet.y)
        if dist > scourgeBullet.range then
            scourgeBullet.queueFree()
        end
    end

    scourgeBullet.queueFree = function()
        scourgeBullet.free = true
    end

    scourgeBullet.draw = function()
        for n=1,#scourgeBullet.trailList do
            local trail = scourgeBullet.trailList[n]
            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", trail.x, trail.y, trail.radius )
            love.graphics.setColor(1,1,1,1)
        end
    end

    table.insert(scourgeBullets, scourgeBullet)
    return scourgeBullet
end


function updatescourgeBullets(dt)

    for _,scourgeBullet in ipairs(scourgeBullets) do
        
        scourgeBullet.update(dt)
    end

    for i=#scourgeBullets, 1, -1 do
        if scourgeBullets[i].free then
            table.remove(scourgeBullets, i)
        end
    end
end

function drawscourgeBullets()
    for _,scourgeBullet in ipairs(scourgeBullets) do
        scourgeBullet.draw()
    end
end

function drawscourgeBulletDebug()
    love.graphics.print("scourgeBullets: "..#scourgeBullets, 10, 10)
end

--[[ function checkCollisions(enemies)
    for _,scourgeBullet in ipairs(scourgeBullets) do
        for _,enemy in ipairs(enemies) do
            if isIntersecting(scourgeBullet.x, scourgeBullet.y, scourgeBullet.radius, enemy.x, enemy.y, enemy.radius) then
                enemy.takeDamage(scourgeBullet.damage)
                ajouteExplosion(scourgeBullet.x,scourgeBullet.y, scourgeBullet.angle)
                scourgeBullet.queueFree()
            end       
        end
    end
end ]]

function initscourgeBullets()
    scourgeBullets = {}
    scourgeBulletTrailList = {}
end