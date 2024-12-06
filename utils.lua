-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end


function isIntersecting(x1, y1, r1, x2, y2, r2 )
    local dist = distance(x1,y1,x2,y2)
    local radiusSum = r1 + r2
    return dist < radiusSum
end