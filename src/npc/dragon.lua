local function dragonInit(npc, x, y, args)
    if data.quest.dragon.state > 4 then
        npc.gone = true
        return npc
    end

    npc.sprite = sprites.npc.dragon

    -- The width and height refer to the head, which is where the player interacts with the dragon
    npc.width = 80
    npc.height = 48

    -- The full_width and full_height refer to the full sprite, since the player only interacts with
    -- the head of the dragon
    npc.full_width = 192
    npc.full_height = 160

    npc.overhangBufferLeft = 18
    npc.overhangBufferRight = 32
    npc.overhangBufferTop = 32
    npc.overhangBufferBottom = 0
    npc.overhangBufferHorizontal = npc.overhangBufferLeft + npc.overhangBufferRight
    npc.overhangBufferVertical = npc.overhangBufferTop + npc.overhangBufferBottom

    npc.collisionX = npc.x - (npc.width/2) + 18
    npc.collisionY = npc.y - npc.height
    npc.collisionWidth = npc.width
    npc.collisionHeight = npc.height

    npc.x_offset = npc.width / 2
    npc.y_offset = npc.full_height

    -- Wall spawned overtop of the npc, passed nil as parent
   spawnWall(npc.x - npc.x_offset + npc.overhangBufferLeft, npc.y - npc.y_offset + npc.overhangBufferTop, npc.full_width - npc.overhangBufferHorizontal, npc.full_height - npc.overhangBufferVertical, nil, nil, nil)

    function npc:interact()
        if talkies.isOpen() then return end

        if data.quest.dragon.state == 0 then
            talkies.say(
                "Sleeping Dragon",
                "zzzzzzzz"
            )
        end

        if data.quest.dragon.state == 1 then
            talkies.say(
                "The Crimson Dragon",
                "The King has called for you to go see him, and to get rid of me? But I dont feel so good, Mage. I feel (sniffle, sniffle) sick."
            )
            data.quest.dragon.state = 2
        end

        if data.quest.dragon.state == 2 then
            talkies.say(
                "The Crimson Dragon",
                "GrUmBlE uMbLe. I could really go for a health potion right about now."
            )
            if data.inventory.healingPotion > 0 or data.inventory.deathPotion > 0 then
                data.quest.dragon.state = 3
            end
        end

        if data.quest.dragon.state == 3 then

            potionOptions = {{'Don\'t give the dragon anything', function () npc:givePotion("nothing") end}}

            if data.inventory.healingPotion > 0 then
                table.insert(potionOptions, {'Give the Dragon an Elixir of Healing', function () npc:givePotion("healing") end})
            end
            if data.inventory.deathPotion > 0 then
                table.insert(potionOptions, {'Give the Dragon a Draught of Death', function () npc:givePotion("death") end})
            end

            if ( data.inventory.healingPotion > 0 ) or
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
            data.inventory.healingPotion = data.inventory.healingPotion - 1
            data.quest.dragon.state = 4
            updateScore(30)
        end

        if type == "death" then
            talkies.say(
                "The Crimson Dragon",
                "Arg, what did you give me? You sneaky li...\n(The Crimson Dragon dies on the spot)"
            )
            data.inventory.deathPotion = data.inventory.deathPotion - 1
            npc.sprite = sprites.npc.dragonDead
            data.quest.dragon.state = 5
            updateScore(-50)
        end
    end

    function npc:update(dt)
    end

    function npc:draw()
        love.graphics.draw(npc.sprite, npc.x, npc.y, nil, nil, nil, npc.x_offset, npc.y_offset)
    end

    return npc
end

return dragonInit
