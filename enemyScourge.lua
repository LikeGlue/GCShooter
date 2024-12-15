local hero = require("hero")
require("utils")
require("enemy")
require("bulletScourge")

function createScourge()
    local scourge = {}
    local spawnRadius = 600
    scourge.x, scourge.y = spawnOffscreen(SCR_WIDTH/2, SCR_HEIGHT/2,spawnRadius,600)
    scourge.barrelLength = 15
    scourge.radius = 10
    scourge.free = false
    scourge.life = 10
    scourge.speed = 150
    scourge.seekRange = 1000
    scourge.shootRange = 400
    scourge.image = love.graphics.newImage("images/scourge.png")
    scourge.angle = 0
    scourge.barrelLength = 15
    scourge.fireRate = 1.5
    scourge.width = scourge.image:getWidth()
    scourge.height = scourge.image:getHeight()

    scourge.shootMaxDuration = 1
    scourge.shootMinDuration = 0.5
    scourge.shootTimer = 1

    scourge.shoot = function ()
        if scourge.shootTimer <= 0 then
            local bullet = newScourgeBullet()
            local x = scourge.barrelLength * math.cos(scourge.angle) + scourge.x
            local y = scourge.barrelLength * math.sin(scourge.angle) + scourge.y
            
            bullet.fire(x,y, scourge.angle)
            scourge.shootTimer = scourge.fireRate
        end
    end

    scourge.update = function(dt)
        scourge.state(dt)
        scourge.checkHeroDistance()
        if scourge.shootTimer > 0 then
            scourge.shootTimer = scourge.shootTimer - dt
        end
        
    end

    scourge.shootState = function(dt)
        local speed = 1
        scourge.angle = math.atan2(hero.y - scourge.y, hero.x - scourge.x)
        scourge.x = scourge.x + math.cos(scourge.angle) * speed * dt
        scourge.y = scourge.y + math.sin(scourge.angle) * speed * dt
        scourge.shoot()

        
        if math.dist(hero.x, hero.y, scourge.x, scourge.y) > hero.radius + scourge.shootRange then
            scourge.state = scourge.chargeState
        end
    end

    scourge.chargeState = function(dt)
        scourge.angle = math.atan2(hero.y - scourge.y, hero.x - scourge.x)
        scourge.x = scourge.x + math.cos(scourge.angle) * scourge.speed * dt
        scourge.y = scourge.y + math.sin(scourge.angle) * scourge.speed * dt
        scourge.checkHeroDistance()

        if math.dist(hero.x, hero.y, scourge.x, scourge.y) < hero.radius + scourge.shootRange and 
        scourge.x - scourge.width * 2 > 0 and scourge.x - scourge.width * 2 < SCR_WIDTH and
        scourge.y - scourge.height * 2 > 0 and scourge.y + scourge.height * 2 < SCR_HEIGHT then
            scourge.state = scourge.shootState
        end
    end

    scourge.checkHeroDistance = function()
        if math.dist(hero.x, hero.y, scourge.x, scourge.y) < hero.radius then
            changeScene("gameover", "Scene loaded...")
        end
    end

    scourge.state = scourge.chargeState

    scourge.draw = function()
        local offsetX = scourge.image:getWidth() / 2
        local offsetY = scourge.image:getHeight() / 2
        local r = scourge.angle + math.pi/2
        love.graphics.draw(scourge.image, scourge.x, scourge.y, r, 1, 1, offsetX, offsetY)
 
        -- "hit box" des ennemis
        --love.graphics.setColor(0, 1, 0)
        --love.graphics.circle("line", scourge.x, scourge.y, scourge.radius)
        --love.graphics.setColor(1, 1, 1)
    end

    scourge.takeDamage = function(damage)
        local closeRange = 70
        if math.dist(hero.x, hero.y, scourge.x, scourge.y) < hero.radius + closeRange then
            startShake(0.3, 5)
        else
            startShake(0.2, 4)
        end

        scourge.life = scourge.life - damage
        if scourge.life <= 0 then
            scourge.queueFree()
            hero.score = hero.score + 100
        end
    end

    scourge.queueFree = function()
        print("free scourge")
        scourge.free = true
    end
    return scourge
end

function initScourge()
    scourges = {}
end

