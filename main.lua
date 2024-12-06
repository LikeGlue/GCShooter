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
require("sceneManager")
require("sceneGame")
require("sceneMenu")

function love.load()
    love.window.setTitle("shootah (temp)")
    love.window.setMode(1024,576)
    SCR_WIDTH = love.graphics.getWidth()
    SCR_HEIGHT = love.graphics.getHeight()

    changeScene("game")
end

function love.update(dt)
    updateCurrentScene(dt)
end

function love.draw()
    drawCurrentScene()
    
end

function love.keypressed(key)
    local scanCode = love.keyboard.getScancodeFromKey(key)
    print(scanCode)
    keypressed(key)
end

function love.mousepressed(x, y, button)
    mousepressed(x, y, button)
end

  