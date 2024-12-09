-- Débogueur Visual Studio Code 
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")


require("utils")
require("effects")
require("sceneManager")
require("sceneGame")
require("sceneMenu")
require("sceneGameOver")

-- cam shake
local t, shakeDuration, shakeMagnitude = 0, -1, 0

function love.load()
    love.window.setTitle("shootah (temp)")
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

  