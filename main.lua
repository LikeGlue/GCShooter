love.graphics.setDefaultFilter("nearest")

require("utils")
require("ui")
require("effects")
require("sceneManager")
require("sceneGame")
require("sceneMenu")
require("sceneGameOver")

function love.load()

    love.window.setTitle("XSHTX")
    love.window.setMode(1024,576)
    SCR_WIDTH = love.graphics.getWidth()
    SCR_HEIGHT = love.graphics.getHeight()

    changeScene("menu")

end

function love.update(dt)
    updateCurrentScene(dt)
end

function love.draw()
    drawCurrentScene()
end

function love.keypressed(key)
    local scanCode = love.keyboard.getScancodeFromKey(key)
    keypressed(key)
    --print(scanCode)
end

function love.mousepressed(x, y, button)
    mousepressed(x, y, button)
end

  