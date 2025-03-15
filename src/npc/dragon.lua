local function dragonInit(npc, x, y, args)
    if data.dragonQuestState == 4 then
        npc.gone = true
        return npc
    end

    npc.sprite = sprites.npc.dragon
    npc.width = 80
    npc.height = 48

    npc.collisionX = npc.x + 16
    npc.collisionY = npc.y + 112

    -- Wall spawned overtop of the npc, passed nil as parent
   spawnWall(npc.x + 16, npc.y, 176, 160, nil, nil, nil)

    function npc:interact()
        if talkies.isOpen() then return end
        
        if data.dragonQuestState == 0 then
            talkies.say(
                "Sleeping Dragon",
                "zzzzzzzz"
            )
        end

        if data.dragonQuestState == 1 then
            talkies.say(
                "The Crimson Dragon",
                "The King has called for you to go see him, and to get rid of me? But I dont feel so good, Mage. I feel (sniffle, sniffle) sick."
            )
            data.dragonQuestState = 2
        end

        if data.dragonQuestState == 2 then
            talkies.say(
                "The Crimson Dragon",
                "GrUmBlE uMbLe. I could really go for a health potion right about now."
            )
            if data.inventory.healthPotion > 0 or data.inventory.deathPotion > 0 then
                data.dragonQuestState = 3
            end
        end

        if data.dragonQuestState == 3 then

            potionOptions = {{'Don\'t give the dragon anything', function () npc:givePotion("nothing") end}}

            if data.inventory.healthPotion > 0 then
                table.insert(potionOptions, {'Give the Dragon an Elixir of Healing', function () npc:givePotion("healing") end})
            end
            if data.inventory.deathPotion > 0 then
                table.insert(potionOptions, {'Give the Dragon a Draught of Death', function () npc:givePotion("death") end})
            end

            if ( data.inventory.healthPotion > 0 ) or
               ( data.inventory.deathPotion > 0 )
            then
                talkies.say(
                    "Crimson Dragon",
                    "You say you have a potion you can give me? Thank you so much!",
                    {
                        options = potionOptions
                    }
                )
            end
        end
    end

    function npc:givePotion(type)
        if type == "nothing" then
            talkies.say(
                "The Crimson Dragon",
                "Please give me something to end this missery!"
            )
        end

        if type == "healing" then
            talkies.say(
                "The Crimson Dragon",
                "Thank you. I am starting to feel better already.\n\nWhen I am all better, I shall leave this kingdom."
            )
            data.inventory.healthPotion = data.inventory.healthPotion - 1
            data.dragonQuestState = 4
        end
        
        if type == "death" then
            talkies.say(
                "The Crimson Dragon",
                "Arg, what did you give me? You sneaky li...\n(The Crimson Dragon dies on the spot)"
            )
            data.inventory.deathPotion = data.inventory.deathPotion - 1
            npc.sprite = sprites.npc.dragonDead
            data.dragonQuestState = 4
        end
    end

    function npc:update(dt)
    end

    function npc:draw()
        love.graphics.draw(npc.sprite, npc.x, npc.y)
    end

    return npc
end

return dragonInit
