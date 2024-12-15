-- FONTS -- Bitmgothic.ttf // Pixelfraktur.ttf // pixarial.ttf

function setFont(name, size)
    love.graphics.setFont(love.graphics.newFont("fonts/" .. name .. ".ttf", size))
end

