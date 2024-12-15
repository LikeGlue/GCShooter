local hero = require("hero")
require("utils")
require("enemy")


function createScourge()
    local scourge = {}
    local spawnRadius = 600
    scourge.x, scourge.y = 100,100
    scourge.barrelLength = 15
    scourge.radius = 10
    scourge.free = false
    scourge.life = 10
    scourge.speed = 150
    scourge.seekRange = 1000
    scourge.shootRange = 400
    scourge.image = love.graphics.newImage("images/scourge.png")
    scourge.angle = 0

    scourge.idleMaxDuration = 5
    scourge.idleMinDuration = 2
    scourge.idleTimer = math.random(scourge.idleMinDuration, scourge.idleMaxDuration)

    scourge.direction = math.random(0, 2 * math.pi)
    scourge.shootMaxDuration = 1
    scourge.shootMinDuration = 0.5
    scourge.shootTimer = math.random(scourge.shootMinDuration, scourge.shootMaxDuration)

    scourge.update = function(dt)
        scourge.state(dt)
        scourge.checkHeroDistance()    
    end

    scourge.shootState = function(dt)
        local speed = 1
        scourge.angle = math.atan2(hero.y - scourge.y, hero.x - scourge.x)
        scourge.x = scourge.x + math.cos(scourge.angle) * speed * dt
        scourge.y = scourge.y + math.sin(scourge.angle) * speed * dt
        
        if math.dist(hero.x, hero.y, scourge.x, scourge.y) > hero.radius + scourge.shootRange then
            scourge.state = scourge.chargeState
        end
    end

    scourge.chargeState = function(dt)
        scourge.angle = math.atan2(hero.y - scourge.y, hero.x - scourge.x)
        scourge.x = scourge.x + math.cos(scourge.angle) * scourge.speed * dt
        scourge.y = scourge.y + math.sin(scourge.angle) * scourge.speed * dt
        scourge.checkHeroDistance()

        if math.dist(hero.x, hero.y, scourge.x, scourge.y) < hero.radius + scourge.shootRange then
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

