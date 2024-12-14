local hero = {}
hero.x = 0
hero.y = 0
hero.img = love.graphics.newImage("images/hero.png")
hero.width = hero.img:getWidth()
hero.height = hero.img:getHeight()
hero.hp = 100
hero.angle = 0
hero.radius = 10
hero.speed = 400
hero.fireRate = 0.1
hero.shootTimer = 0
hero.barrelLength = 15
hero.targetImage = love.graphics.newImage("images/target.png")
hero.score = 0

local oldMouseButtonState = false

hero.load = function()
    hero.x = SCR_WIDTH/2
    hero.y = SCR_HEIGHT/2
    hero.angle = math.rad(270)
end

hero.aim = function(x,y)
    local angle = math.atan2(y - hero.y, x - hero.x)
    hero.angle = angle
end

hero.shoot = function ()
    if hero.shootTimer <= 0 then
        local bullet = newBullet()
        local x = hero.barrelLength * math.cos(hero.angle) + hero.x
        local y = hero.barrelLength * math.sin(hero.angle) + hero.y
        
        bullet.fire(x,y, hero.angle)
        hero.shootTimer = hero.fireRate
    end
end

hero.move = function(dt)
    if love.keyboard.isScancodeDown("w") and hero.y > 0 + hero.height/2 then
        hero.y = hero.y - hero.speed * dt
    end
    if love.keyboard.isScancodeDown("a") and hero.x > 0 + hero.width/2 then
        hero.x = hero.x - hero.speed * dt
    end
    if love.keyboard.isScancodeDown("s") and hero.y < SCR_HEIGHT - hero.height/2 then
        hero.y = hero.y + hero.speed * dt
    end
    if love.keyboard.isScancodeDown("d") and hero.x < SCR_WIDTH - hero.width/2 then
        hero.x = hero.x + hero.speed * dt
    end
end

hero.update = function(dt,spawn)
    hero.move(dt)
    hero.aim(love.mouse.getPosition())
    if spawn then
        if love.mouse.isDown(1) and oldMouseButtonState == false then
            hero.shoot()
        end
    end

    if hero.shootTimer > 0 then
        hero.shootTimer = hero.shootTimer - dt
    end
    oldMouseButtonState = love.mouse.isDown(1)
end

hero.drawTarget = function()
    local targetX, targetY = love.mouse.getPosition()
    love.graphics.draw(hero.targetImage, targetX, targetY, 0, 2, 2, hero.targetImage:getWidth()/2, hero.targetImage:getHeight()/2)
end

hero.draw = function()
    -- hero
    love.graphics.draw(hero.img, hero.x, hero.y, hero.angle + math.rad(90), 1, 1, hero.img:getWidth()/2, hero.img:getHeight()/2)
end

hero.laserDraw = function()
    -- laser sight
    local targetX, targetY = love.mouse.getPosition()
    love.graphics.setColor(1,1,1,1)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(2)
    love.graphics.line( hero.x, hero.y, targetX, targetY)
    love.graphics.setColor(1,1,1,1)
end

hero.drawDebug = function()
    love.graphics.print("Hero HP: "..hero.hp, 10, 30)
end

--[[ hero.setFireRate = function(rate)
    if rate < 0 then
        rate = 0
    elseif hero.rate > 10 then
        rate = 10
    end
end ]]

return hero

  