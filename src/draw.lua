function drawBeforeCamera()
    if gamestate == 0 then
        title:draw()
    end

    if gamestate == 1 then
        about:draw()
    end

    if gamestate == 2 then
        controls:draw()
    end
end

function drawCamera()

    if gamestate == 0 then return end
    setWhite()

    if gameMap.layers["Background"] then
        gameMap:drawLayer(gameMap.layers["Background"])
    end

    if gameMap.layers["Base"] then
        gameMap:drawLayer(gameMap.layers["Base"])
    end
  
    if gameMap.layers["Objects"] then
        gameMap:drawLayer(gameMap.layers["Objects"])
    end

    if gameMap.layers["Test"] then
        --gameMap:drawLayer(gameMap.layers["Test"])
    end

    drawShadows()
    walls:draw()
    effects:draw(-1) -- two layers of effects
    chests:draw(-1)
    bombs:draw()
    boomerang:draw()
    loots:draw()
    arrows:draw(-1)
    fireballs:draw(-1)
    grapple:draw(-1)
    effects:draw(0)
    trees:draw(-1)
    if player.drawOnTop == false then
        player:draw()
    end
    chests:draw(1)
    arrows:draw(1)
    fireballs:draw(1)
    grapple:draw(1)
    npcs:draw()
    enemies:draw()
    effects:drawDarkMagic()
    blasts:draw()
    projectiles:draw()
    effects:draw(1)
    particles:draw()
    trees:draw(1)

    if gameMap.dark then
        --love.graphics.setShader(shaders.trueLight)
        --love.graphics.rectangle("fill", -10, -10, 10000, 10000)
        --love.graphics.setShader()
        love.graphics.draw(sprites.effects.darkness, player:getX(), player:getY(), nil, nil, nil, sprites.effects.darkness:getWidth()/2, sprites.effects.darkness:getHeight()/2)
    end

    if gameMap.layers["Overhangs"] then
        gameMap:drawLayer(gameMap.layers["Overhangs"])
    end

    if player.drawOnTop == true then
        player:draw()
    end
end

function drawAfterCamera()
    curtain:draw()
    if gamestate == 0 then return end
    drawHUD()
    talkies.draw()
    pause:draw()
end
