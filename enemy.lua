
local hero = require("hero")
local enemy = {}
local listSprites = {}

local ENEMYSTATES = {}

ENEMYSTATES.NONE = ""
ENEMYSTATES.ATTACK = "attack"
ENEMYSTATES.BITE = "bite"
ENEMYSTATES.SHOOT = "shoot"

local angle = 0
enemy.createEnemy = function()
    local myEnemy = enemy.createSprite(listSprites, "enemy", "enemy")
    --position
    myEnemy.x = love.math.random( - 50, SCR_WIDTH + 50)
    myEnemy.y = love.math.random(- 10, SCR_HEIGHT + 50)

    -- vitesse
    myEnemy.speed = 2
    myEnemy.angle = 0
    myEnemy.range = 1000
    myEnemy.target = nil
    myEnemy.radius = 20

    myEnemy.state = ENEMYSTATES.ATTACK

    myEnemy.vx = 0
    myEnemy.vy = 0



end

enemy.updateState = function(pEnemy, pEntities)

    if pEnemy.state == ENEMYSTATES.NONE then
    elseif pEnemy.state == ENEMYSTATES.ATTACK then
        local angle = math.angle(pEnemy.x, pEnemy.y, pEntities.x, pEntities.y)
        pEnemy.vx = pEnemy.speed * 60 * math.cos(angle)
        pEnemy.vy = pEnemy.speed * 60 * math.sin(angle)
    elseif pEnemy.state == ENEMYSTATES.SHOOT then
    end

end

enemy.createSprite = function(pList, pType, pImage)
    local mySprite = {}
    mySprite.type = pType
    mySprite.image = {}
    local filename = "images/"..pImage..".png"
    mySprite.image = love.graphics.newImage(filename)
    mySprite.x = 0
    mySprite.y = 0
    mySprite.vx = 0
    mySprite.vy = 0
    mySprite.angle = 0

    mySprite.width = mySprite.image:getWidth()
    mySprite.height = mySprite.image:getHeight()

    table.insert(pList, mySprite)

    return mySprite
end

--enemy.load = function()
    --local nEnemy
    --for nEnemy = 1, 5 do 
        --enemy.createEnemy()
    --end
--end

enemy.update = function (dt)
    local i 
    for i, sprite in ipairs(listSprites) do
        -- Velocité
        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt
        angle = math.angle(sprite.x, sprite.y, hero.x, hero.y)
        enemy.updateState(sprite, hero)
    end
end

enemy.draw = function()
    local r = angle + (math.pi/2)
    for i,sprite in ipairs(listSprites) do 
        love.graphics.draw(sprite.image, sprite.x, sprite.y, r, 1, 1, sprite.width/2, sprite.height/2 )

        -- Visuel du 'hitbox'
        love.graphics.setColor(0.5,1,0.2)
        love.graphics.circle("line", sprite.x, sprite.y, sprite.radius)
        love.graphics.setColor(1,1,1)
    end
end


return enemy