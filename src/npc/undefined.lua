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

    return npc
end

return undefinedInit
