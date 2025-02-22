 local function kingInit(npc, x, y, args)
    npc.sprite = sprites.npc.king
    npc.width = 25
    npc.height = 33
    npc.collsionY = npc.y + 6

    function npc:interact()
        if talkies.isOpen() then return end

        if data.dragonQuestState == 0 then
            talkies.say(
                "The King",
                "There you are Mage. We have a SERIOUS dragon problem. We need you to go and slay it for the glory of the kingdom!"
            )
            data.dragonQuestState = 1
        elseif data.dragonQuestState == 1 then
            talkies.say(
                "The King",
                "Go forth and deal with that dragon!"
            )
        elseif data.dragonQuestState == 2 or data.dragonQuestState == 3 then
            talkies.say(
                "The King",
                "The dragon is still terrorising us.Please save our kingdom."
            )
        elseif data.dragonQuestState == 4 or data.dragonQuestState == 5 then
            talkies.say(
                "The King",
                "Thank you so much for saving the kingdom. Thank you for playing the 'For Honor And Glory' demo"
            )
            data.dragonQuestState = 5
        end
    end

    return npc
end

return kingInit