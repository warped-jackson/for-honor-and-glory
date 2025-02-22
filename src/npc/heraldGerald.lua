 local function heraldGeraldinit(npc, x, y, args)
    npc.sprite = sprites.npc.heraldGerald
    npc.width = 14
    npc.height = 20
    npc.y = y - (npc.height/2) - 2

    function npc:interact()
        if talkies.isOpen() then return end

        talkies.say(
            "Herald Gerald",
            "The King has called for you go see him. He is wating in his castle at the TOP of the kingdom. Good Luck Mage."
        )
    end

    return npc
end

return heraldGeraldinit
