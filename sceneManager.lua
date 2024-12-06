local scenes = {}


function newScene(title)
    local scene = {}

    scene.title = title

    scene.load = function (data)
    end

    scene.update = function(dt)
    end

    scene.draw = function()
    end

    scene.keypressed = function(key)
    end

    scene.mousepressed = function(x, y, button)
    end

    scene.unLoad = function()
    end

    scenes[title] = scene
    return scene
end

local currentScene = nil

function changeScene(title, data)
    if currentScene ~= nil then
        currentScene.unLoad()
    end
    currentScene = scenes[title]
    currentScene.load()
end

function updateCurrentScene(dt)
    currentScene.update(dt)
end

function drawCurrentScene()
    currentScene.draw()
end

function keypressed(key)
    currentScene.keypressed(key)
end

function mousepressed(x, y, button)
    currentScene.mousepressed(x, y, button)
end