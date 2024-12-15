local hero = require("hero")
require("utils")


function createEnemy()
    local enemy = {}
    local spawnRadius = 600
    enemy.x, enemy.y = spawnOffscreen(SCR_WIDTH/2, SCR_HEIGHT/2,spawnRadius,600)
    enemy.barrelLength = 15
    enemy.radius = 10
    enemy.free = false
    enemy.life = 10
    enemy.speed = 150
    enemy.seekRange = 1000
    enemy.image = love.graphics.newImage("images/enemy.png")
    enemy.angle = 0

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

    enemy.chargeState = function(dt)
        enemy.angle = math.atan2(hero.y - enemy.y, hero.x - enemy.x)
        enemy.x = enemy.x + math.cos(enemy.angle) * enemy.speed * dt
        enemy.y = enemy.y + math.sin(enemy.angle) * enemy.speed * dt
        enemy.checkHeroDistance()
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
        local r = enemy.angle + math.pi/2
        love.graphics.draw(enemy.image, enemy.x, enemy.y, r, 1, 1, offsetX, offsetY)
 
        -- "hit box" des ennemis
        --love.graphics.setColor(0, 1, 0)
        --love.graphics.circle("line", enemy.x, enemy.y, enemy.radius)
        --love.graphics.setColor(1, 1, 1)
    end

    enemy.takeDamage = function(damage)
        local closeRange = 70
        if math.dist(hero.x, hero.y, enemy.x, enemy.y) < hero.radius + closeRange then
            startShake(0.3, 5)
        else
            startShake(0.2, 4)
        end

        enemy.life = enemy.life - damage
        if enemy.life <= 0 then
            enemy.queueFree()
            hero.score = hero.score + 100
        end
    end

    enemy.queueFree = function()
        print("free enemy")
        enemy.free = true
    end
    return enemy
end

function initEnemies()
    enemies = {}
end

