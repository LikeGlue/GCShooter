require("hero")
require("enemy")

font = love.graphics.newFont("fonts/Bitmgothic.ttf",50,normal)
--font = love.graphics.newFont("fonts/Heinz.otf", 100, normal)
--font = love.graphics.newFont("fonts/Pixelfraktur.ttf", 200,light)

function setFont(name, size)
    love.graphics.setFont(love.graphics.newFont("fonts/" .. name .. ".ttf", size))
end

