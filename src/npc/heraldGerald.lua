 local function heraldGeraldinit(npc, x, y, args)
    npc.sprite = sprites.npc.heraldGerald
    npc.width = 32
    npc.height = 35

    npc.x = x - (npc.width/2)
    npc.y = y - npc.height

    npc.collisionX = npc.x
    npc.collisionY = npc.y
    npc.collisionWidth = npc.width
    npc.collisionHeight = npc.height

    function npc:interact()
        if talkies.isOpen() then return end

        if data.quest.king.state == 0 then
            talkies.say(
                "Herald Gerald",
                "The King has called for you go see him. Move with haste, the King is waiting. Good luck Mage."
            )
            data.quest.king.state = 1
            data.quest.king.startTime = os.time()
        end

        if data.quest.king.state == 1 then
            talkies.say(
                "Herald Gerald",
                "Do NOT keep the King waiting."
            )
        end
    end

    function npc:update(dt)
    end

    function npc:draw()
        love.graphics.draw(sprites.npc.kingShadow, npc.x, npc.y + npc.height, nil, nil, nil, -2, 4)
        love.graphics.draw(npc.sprite, npc.x, npc.y)
    end

    return npc
end

return heraldGeraldinit
