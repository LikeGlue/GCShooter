local hero = {}
hero.x = 0
hero.y = 0
hero.img = love.graphics.newImage("images/hero.png")
hero.angle = 0
hero.speed = 400
hero.fireRate = 0.15
hero.shootTimer = 0
hero.barrelLength = 15
hero.targetImage = love.graphics.newImage("images/target.png")

local oldMouseButtonState = false


hero.load = function()
    hero.x = SCR_WIDTH/2
    hero.y = SCR_HEIGHT/2
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
    if love.keyboard.isScancodeDown("w") then
        hero.y = hero.y - hero.speed * dt
    end
    if love.keyboard.isScancodeDown("a") then
        hero.x = hero.x - hero.speed * dt
    end
    if love.keyboard.isScancodeDown("s") then
        hero.y = hero.y + hero.speed * dt
    end
    if love.keyboard.isScancodeDown("d") then
        hero.x = hero.x + hero.speed * dt
    end
end

hero.update = function(dt)
    hero.move(dt)
    hero.aim(love.mouse.getPosition())

    if love.mouse.isDown(1) and oldMouseButtonState == false then
        hero.shoot()
    end
    if hero.shootTimer > 0 then
        hero.shootTimer = hero.shootTimer - dt
    end
    oldMouseButtonState = love.mouse.isDown(1)
end

hero.draw = function()

    -- target
    local targetX, targetY = love.mouse.getPosition()
    love.graphics.draw(hero.targetImage, targetX, targetY, 0, 2, 2, hero.targetImage:getWidth()/2, hero.targetImage:getHeight()/2)

    -- laser sight
    love.graphics.setColor(0.6,0,0.6,1)
    love.graphics.line( hero.x, hero.y, targetX, targetY)
    love.graphics.setColor(1,1,1,1)


    -- hero
    love.graphics.draw(hero.img, hero.x, hero.y, hero.angle + math.rad(90), 1, 1, hero.img:getWidth()/2, hero.img:getHeight()/2)
    

end

hero.setFireRate = function(rate)
    if rate < 0 then
        rate = 0
    elseif hero.rate > 10 then
        rate = 10
    end
end

return hero

  