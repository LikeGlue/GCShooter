love.graphics.setDefaultFilter("nearest")

require("utils")
require("ui")
require("effects")
require("sceneManager")
require("sceneGame")
require("sceneMenu")
require("sceneGameOver")



function love.load()
    -- cam shake
    t, shakeDuration, shakeMagnitude = 0, -1, 0
    love.graphics.setFont(font)
    love.window.setTitle("XSHTX")
    love.window.setMode(1024,576)
    SCR_WIDTH = love.graphics.getWidth()
    SCR_HEIGHT = love.graphics.getHeight()
    
    function startShake(duration, magnitude)
        t, shakeDuration, shakeMagnitude = 0, duration or 1, magnitude or 5
    end
    
    changeScene("menu")
end

function love.update(dt)
    if t < shakeDuration then
        t = t + dt
    end
    updateCurrentScene(dt)
end

function love.draw()

    if t < shakeDuration then
        local dx = love.math.random(-shakeMagnitude, shakeMagnitude)
        local dy = love.math.random(-shakeMagnitude, shakeMagnitude)
        love.graphics.translate(dx, dy)
    end

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

  