function love.load()
    math.randomseed(os.time())

    d1 = 0
    d2 = 0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()
    createNewSave()

    loadMap("menu")
 
    dj.volume("effect", 1)

end

function love.update(dt)
    updateAll(dt)
end

function love.draw()
    drawBeforeCamera()

    cam:attach()
        drawCamera()
        if colliderToggle then
            world:draw()
            particleWorld:draw()
        end
    cam:detach()

    drawAfterCamera()

    local debug = require "src/debug"
    --debug:d()
    --debug:single()
end

function love.keypressed(key)

    if gamestate == 1 then
        gamestate = 0
    end

    if key == 'q' then
        colliderToggle = not (colliderToggle and true);
    end

    if key == 'escape' then
        if pause.active then
            pause:toggle()
        else
            love.event.quit()
        end
    end

    if key == 'i' then
        if gamestate == 10 then
            pause:toggle()
        end
    end

    if key == 'space' then
        if talkies.isOpen() then
            talkies.onAction()
        elseif gamestate == 10 then
            player:interact()
        end
    end

    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        if talkies.isOpen() then
            talkies.nextOption()
        end
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        if talkies.isOpen() then
            talkies.prevOption()
        end
    end
end
