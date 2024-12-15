-- FONTS -- Bitmgothic.ttf // Pixelfraktur.ttf

function setFont(name, size)
    love.graphics.setFont(love.graphics.newFont("fonts/" .. name .. ".ttf", size))
end

