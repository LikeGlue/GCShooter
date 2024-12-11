listeParticules = {}
listeRocket = {}
listeBlasts = {}

listeDrop = {}
listeDrip = {}



particle = {}
particle.x = 0
particle.y = 0

blast = {}
blast.x = 0
blast.y = 0
blast.r = 0
blast.c = {0,0,0,0} -- color

timer = 0

function ajouteBlast(pX, pY)
    local monBlast = {}
    monBlast.x = pX
    monBlast.y = pY
    monBlast.r = love.math.random(5,20)
    monBlast.vx = love.math.random(-400,400)/200
    monBlast.vy = love.math.random(-400,400)/200
    monBlast.vie = love.math.random(50,400)/1000
    monBlast.c = {0,0,0,0}
    monBlast.speed = 30
    table.insert(listeBlasts, monBlast)
end

function updateBlast(dt)
    for n=#listeBlasts, 1, -1 do
        local blast = listeBlasts[n]
        blast.x = blast.x + blast.vx * (blast.speed * dt)
        blast.y = blast.y + blast.vy * (blast.speed * dt)
        blast.vie = blast.vie - dt
        if blast.vie <= 0 then
            table.remove(listeBlasts, n)
        end
    end
end

function drawBlast()
    for n=1,#listeBlasts do
        local blast = listeBlasts[n]
        blast.r = blast.r - 0.1
        if blast.vie > 0 then
            if blast.r < 20 then
                blast.c = {1,1,1,1}
            end
            if blast.r < 7 then
                blast.c = {0.4,0.4,0.4,1}
            end
         
           
        else
            love.graphics.setColor(1,1,1,1)
        end
        love.graphics.circle("fill", blast.x, blast.y, blast.r)
        love.graphics.setColor(blast.c)
        --love.graphics.setColor(1,1,1,1)
    end
end

function ajouteRocket()
    local monRocket = {}
    monRocket.x = love.math.random(0, love.graphics.getWidth())
    monRocket.y = love.graphics.getHeight()
    monRocket.longueur = love.math.random(400,550)
    monRocket.dist = 0
    table.insert(listeRocket, monRocket)
end

function updateRocket(dt)
    for n=#listeRocket,1,-1 do
        local Rocket = listeRocket[n]
        Rocket.dist = Rocket.dist + 3
        if Rocket.dist >= Rocket.longueur then
            ajouteExplosion(Rocket.x, love.graphics.getHeight() - Rocket.dist)
            table.remove(listeRocket, n)
        end
    end
end

function drawRocket()
    for n=1,#listeRocket do
        local Rocket = listeRocket[n]
        love.graphics.rectangle("fill", Rocket.x, love.graphics.getHeight() - Rocket.dist, 5, 5)
    end
end

function ajouteParticule(pX, pY, pAngle)
    local maParticule = {}
    maParticule.x = pX + love.math.random(-5,5)
    maParticule.y = pY + love.math.random(-5,5)
    maParticule.angle = pAngle
    maParticule.vx = love.math.random(-300,300)/300
    maParticule.vy = love.math.random(-300,300)/300
    maParticule.vie = love.math.random(50,300)/700
    maParticule.speed = 50
    table.insert(listeParticules, maParticule)
end

function updateParticule(dt)
    for n=#listeParticules, 1, -1 do
        local particle = listeParticules[n]
        particle.x = particle.x + particle.vx * (particle.speed * dt)
        particle.y = particle.y + particle.vy * (particle.speed * dt)
        particle.vie = particle.vie - dt
        if particle.vie <= 0 then
            table.remove(listeParticules, n)
        end
    end
end

function drawParticule()
    for n=1,#listeParticules do
        local particle = listeParticules[n]
        if particle.vie > 0 then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.rectangle("fill", particle.x, particle.y, 5, 5)
        love.graphics.setColor(1,1,1)
    end
end

function ajouteExplosion(pX,pY,pAngle)
    for n=1,15 do
        ajouteBlast(pX, pY)
    end
    for n=1,50 do
        ajouteParticule(pX,pY, pAngle)
    end
end