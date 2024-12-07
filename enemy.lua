local hero = require("hero")


function createEnemy()
    local enemy = {}

    enemy.x = love.math.random(-50, 800)
    enemy.y = love.math.random(-50, 800)
    enemy.radius = 10
    enemy.free = false
    enemy.life = 10
    enemy.speed = 100
    enemy.seekRange = 1000
    enemy.image = love.graphics.newImage("images/enemy.png")
                         

    enemy.idleMaxDuration = 5
    enemy.idleMinDuration = 2
    enemy.idleTimer = math.random(enemy.idleMinDuration, enemy.idleMaxDuration)

    enemy.direction = math.random(0, 2 * math.pi)
    enemy.shootMaxDuration = 1
    enemy.shootMinDuration = 0.5
    enemy.shootTimer = math.random(enemy.shootMinDuration, enemy.shootMaxDuration)

    enemy.update = function(dt)
        enemy.state(dt)
        enemy.checkHeroDistance()
    
    
    end

    enemy.idleState = function(dt)
        if enemy.idleTimer <= 0 then
            enemy.idleTimer = math.random(enemy.idleMinDuration, enemy.idleMaxDuration)
            if math.random(1, 7) ~= 1 then
                enemy.state = enemy.shootState
            end
        else
            enemy.idleTimer = enemy.idleTimer - dt
        end

        enemy.checkHeroDistance()
    end

    enemy.shootState = function(dt)
        enemy.x = enemy.x + math.cos(enemy.direction) * enemy.speed * dt
        enemy.y = enemy.y + math.sin(enemy.direction) * enemy.speed * dt

        if enemy.shootTimer <= 0 then
            enemy.shootTimer = math.random(enemy.shootMinDuration, enemy.shootMaxDuration)
            enemy.direction = math.random(enemy.direction - math.pi / 4, enemy.direction + math.pi / 4)
            if math.random(1, 7) == 1 then
                enemy.state = enemy.idleState
            end
        else
            enemy.shootTimer = enemy.shootTimer - dt
        end
        enemy.checkHeroDistance()
    end

    enemy.chargeState = function(dt)
        angle = math.atan2(hero.y - enemy.y, hero.x - enemy.x)
        enemy.x = enemy.x + math.cos(angle) * enemy.speed * dt
        enemy.y = enemy.y + math.sin(angle) * enemy.speed * dt
        enemy.checkHeroDistance()
    end

    enemy.attackState = function(dt)
        local destX, destY
        destX = math.random(hero.x - 20, hero.x + 20)
        destY = math.random(hero.y - 20, hero.y + 20)
        local angle = math.angle(enemy.x, enemy.y, destX, destY)
        enemy.x = enemy.x + math.cos(angle) * enemy.speed * dt
        enemy.y = enemy.y + math.sin(angle) * enemy.speed * dt
    end

    enemy.checkHeroDistance = function()
        if math.dist(hero.x, hero.y, enemy.x, enemy.y) < hero.radius then
            changeScene("gameover", "Scene loaded...")
        end
    end

    enemy.state = enemy.chargeState

    enemy.draw = function()
        local offsetX = enemy.image:getWidth() / 2
        local offsetY = enemy.image:getHeight() / 2
        local r = angle + math.pi/2
        love.graphics.draw(enemy.image, enemy.x, enemy.y, r, 1, 1, offsetX, offsetY)
 
        
        -- "hit box" des ennemis
        --love.graphics.setColor(0, 1, 0)
        --love.graphics.circle("line", enemy.x, enemy.y, enemy.radius)
        --love.graphics.setColor(1, 1, 1)
    end

    enemy.takeDamage = function(damage)
        print("take damage")
        print(damage)

        enemy.life = enemy.life - damage
        if enemy.life <= 0 then
            enemy.queueFree()
        end
    end

    enemy.queueFree = function()
        print("free enemy")
        enemy.free = true
    end

    return enemy
end
