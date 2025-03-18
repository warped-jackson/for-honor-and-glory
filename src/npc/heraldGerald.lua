 local function heraldGeraldinit(npc, x, y, args)
    npc.sprite = sprites.npc.heraldGerald
    npc.width = 14
    npc.height = 20
    npc.y = y - (npc.height/2) - 2

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
        love.graphics.draw(npc.sprite, npc.x, npc.y)
    end

    return npc
end

return heraldGeraldinit
