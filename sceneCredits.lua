require("sceneManager")
require("utils")

local sceneCredits = newScene("credits")

sceneCredits.load = function()

end

sceneCredits.update = function(dt)

end

sceneCredits.draw = function()

    setFont("Pixelfraktur", 150)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Merci",0,100,1000,"center")
    love.graphics.setColor(1,1,1)

    setFont("pixarial", 15)
    love.graphics.printf("Robin de la promo Kinshasa,\n Aymeric, Cédric et Cyril de la promo Casablanca\n et Nicolas Animapix pour votre aide",240,300,500,"center")

    love.graphics.printf("(Game Campus module 1 - 15/12/2024)",240,400,500,"center")


    setFont("Bitmgothic", 20)
    love.graphics.printf("Press SPACE for menu",0,500,1000,"center")
end

sceneCredits.keypressed = function(key)
    if key == "space" then
        changeScene("menu", "Scene loaded...")
    end
end 