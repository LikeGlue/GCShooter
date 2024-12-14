-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function isIntersecting(x1, y1, r1, x2, y2, r2 )
    local dist = math.dist(x1,y1,x2,y2)
    local radiusSum = r1 + r2
    return dist < radiusSum
end

function spawnOffscreen(cx,cy,radius,max)
    local angle = love.math.random() * 2 * math.pi
    local distance = love.math.random(radius,max)
    local x = cx + distance * math.cos(angle)
    local y = cy + distance * math.sin(angle)
    return x, y
end