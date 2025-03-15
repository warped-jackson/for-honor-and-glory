 local function undefinedInit(npc, x, y, args)
    npc.sprite = sprites.npc.undefined
    npc.width = 14
    npc.height = 20
    npc.y = y - (npc.height/2) - 2

    function npc:interact()
        if talkies.isOpen() then return end

        talkies.say(
            "???",
            "..."
        )
    end

    function npc:update(dt)
    end

    function npc:draw()
        love.graphics.draw(npc.sprite, npc.x, npc.y)
    end

    return npc
end

return undefinedInit
