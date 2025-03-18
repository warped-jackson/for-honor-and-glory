function drawHUD()
    if gamestate == 10 then
        --drawHearts()
        --drawItemBox()
        --drawMoney()
        drawForHonorGloryBar()
    end
end

function drawForHonorGloryBar()
    local bar = {}

    setWhite()
    love.graphics.setFont(fonts.score)
    love.graphics.printf("Score", 4*scale, 4*scale, 25*scale, "left")
    setWhite()

    bar.sprite = sprites.hud.forHonorAndGloryBarSheet
    bar.width = 206
    bar.height = 28
    bar.x = 18*scale
    bar.y = 3*scale
    bar.grid = anim8.newGrid(bar.width, bar.height, bar.sprite:getWidth(), bar.sprite:getHeight())
    bar.animation = {}
    bar.animation.negative10 = anim8.newAnimation(bar.grid(1, 1), 0.1)
    bar.animation.negative9 = anim8.newAnimation(bar.grid(1, 2), 0.1)
    bar.animation.negative8 = anim8.newAnimation(bar.grid(1, 3), 0.1)
    bar.animation.negative7 = anim8.newAnimation(bar.grid(1, 4), 0.1)
    bar.animation.negative6 = anim8.newAnimation(bar.grid(1, 5), 0.1)
    bar.animation.negative5 = anim8.newAnimation(bar.grid(1, 6), 0.1)
    bar.animation.negative4 = anim8.newAnimation(bar.grid(1, 7), 0.1)
    bar.animation.negative3 = anim8.newAnimation(bar.grid(1, 8), 0.1)
    bar.animation.negative2 = anim8.newAnimation(bar.grid(1, 9), 0.1)
    bar.animation.negative1 = anim8.newAnimation(bar.grid(1, 10), 0.1)
    bar.animation.neutral = anim8.newAnimation(bar.grid(1, 11), 0.1)
    bar.animation.positive1 = anim8.newAnimation(bar.grid(1, 12), 0.1)
    bar.animation.positive2 = anim8.newAnimation(bar.grid(1, 13), 0.1)
    bar.animation.positive3 = anim8.newAnimation(bar.grid(1, 14), 0.1)
    bar.animation.positive4 = anim8.newAnimation(bar.grid(1, 15), 0.1)
    bar.animation.positive5 = anim8.newAnimation(bar.grid(1, 16), 0.1)
    bar.animation.positive6 = anim8.newAnimation(bar.grid(1, 17), 0.1)
    bar.animation.positive7 = anim8.newAnimation(bar.grid(1, 18), 0.1)
    bar.animation.positive8 = anim8.newAnimation(bar.grid(1, 19), 0.1)
    bar.animation.positive9 = anim8.newAnimation(bar.grid(1, 20), 0.1)
    bar.animation.positive10 = anim8.newAnimation(bar.grid(1, 21), 0.1)

    score_scale = data.score * 1
    bar.anim = bar.animation.neutral
    if score_scale == -10 then
        bar.anim = bar.animation.negative10
    elseif score_scale == -9 then
        bar.anim = bar.animation.negative9
    elseif score_scale == -8 then
        bar.anim = bar.animation.negative8
    elseif score_scale == -7 then
        bar.anim = bar.animation.negative7
    elseif score_scale == -6 then
        bar.anim = bar.animation.negative6
    elseif score_scale == -5 then
        bar.anim = bar.animation.negative5
    elseif score_scale == -4 then
        bar.anim = bar.animation.negative4
    elseif score_scale == -3 then
        bar.anim = bar.animation.negative3
    elseif score_scale == -2 then
        bar.anim = bar.animation.negative2
    elseif score_scale == -1 then
        bar.anim = bar.animation.negative1
    elseif score_scale == 0 then
        bar.anim = bar.animation.neutral
    elseif score_scale == 1 then
        bar.anim = bar.animation.positive1
    elseif score_scale == 2 then
        bar.anim = bar.animation.positive2
    elseif score_scale == 3 then
        bar.anim = bar.animation.positive3
    elseif score_scale == 4 then
        bar.anim = bar.animation.positive4
    elseif score_scale == 5 then
        bar.anim = bar.animation.positive5
    elseif score_scale == 6 then
        bar.anim = bar.animation.positive6
    elseif score_scale == 7 then
        bar.anim = bar.animation.positive7
    elseif score_scale == 8 then
        bar.anim = bar.animation.positive8
    elseif score_scale == 9 then
        bar.anim = bar.animation.positive9
    elseif score_scale == 10 then
        bar.anim = bar.animation.positive10
    end

    bar.anim:draw(bar.sprite, bar.x, bar.y, nil, scale/2)
end

function drawHearts()
    for i = 0, data.maxHealth-1 do
        local heartSpr = sprites.hud.emptyHeart
        if player.health - i == 0.5 then
            heartSpr = sprites.hud.halfHeart
        elseif player.health > i then
            heartSpr = sprites.hud.heart
        end
        love.graphics.draw(heartSpr, 6 + (i * 15*scale), 6, nil, scale)
    end
end

function drawMoney()
    local mx = love.graphics.getWidth() - 23*scale
    local my = love.graphics.getHeight() - 10*scale
    local tx = love.graphics.getWidth() - 12*scale
    local ty = love.graphics.getHeight() - 11*scale
    setWhite()
    love.graphics.draw(sprites.hud.coin, mx, my, nil, 1.5*scale)
    love.graphics.setFont(fonts.coins)
    love.graphics.print(data.money, tx, ty)
end

function drawItemBox()
    -- Below the hearts
    --local bx = 6
    --local by = 16*scale

    -- Upper-right
    local bx = love.graphics.getWidth() - 19*scale
    local by = 6

    love.graphics.setColor(0,0,0, 0.35)
    love.graphics.rectangle("fill", bx+1, by+1, 16*scale, 16*scale)
    setWhite()
    love.graphics.draw(sprites.hud.itemBox, bx, by, nil, scale)

    local ammoCount = -1
    local maxed = false
    if data.item.x == 2 then
        ammoCount = data.bombCount
        if data.bombCount == data.maxBombCount then
            maxed = true
        end
    elseif data.item.x == 3 then
        ammoCount = data.arrowCount
        if data.arrowCount == data.maxArrowCount then
            maxed = true
        end
    end

    if ammoCount > -1 then
        love.graphics.setColor(0,0,0, 0.35)
        love.graphics.rectangle("fill", bx+(3*scale), by+(20*scale), 11*scale, 7*scale)
        setWhite()
        love.graphics.draw(sprites.hud.ammoBox, bx+(2.5*scale), by+(19*scale), nil, scale)

        love.graphics.setFont(fonts.ammo)
        if maxed then love.graphics.setColor(0,1,0,1) end
        love.graphics.printf(ammoCount, bx+(4.5*scale), by+(20*scale), 9.5*scale, "center")
        --love.graphics.print(ammoCount, bx+(3*scale), by+(20*scale))
        setWhite()
    end

    local spr = sprites.items.boomerang
    local offX = -1.5
    local offY = -1.5
    local scaleMod = 1.25
    if data.item.x == 1 then -- boomerang
        spr = sprites.items.boomerang
    elseif data.item.x == 2 then -- bomb
        spr = sprites.items.bomb
        offX = 2.3
        offY = 2.8
        scaleMod = 1.1
    elseif data.item.x == 3 then -- bow
        spr = sprites.items.bowIcon
        offX = 4.2
        offY = 2.3
        scaleMod = 0.17
    end
    love.graphics.draw(spr, bx + (offX * scale), by + (offY * scale), nil, scale * scaleMod)
end
