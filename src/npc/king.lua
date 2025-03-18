 local function kingInit(npc, x, y, args)
    npc.sprite = sprites.npc.kingSheet
    npc.width = 25
    npc.height = 33
    npc.x = x
    npc.y = y
    npc.x_offset = npc.width / 2
    npc.y_offset = npc.height / 2

    npc.grid = anim8.newGrid(npc.width, npc.height, npc.sprite:getWidth(), npc.sprite:getHeight())
    npc.anim = anim8.newAnimation(npc.grid('1-4', 1), {2.4, 0.1, 2.8, 0.1})

    function npc:interact()
        if talkies.isOpen() then return end

        -- Mage speaks to the King before speaking with Herald Gerald
        if data.quest.king.state == 0 then
            talkies.say(
                "The King",
                "There you are Mage. I am glad you got my message..."
            )
            talkies.say(
                "The King",
                "You say you didn't get my message from Herald Gerald, who was waiting outside your house? That's not good."
            )
            data.score = data.score - 1
            talkies.say(
                "The King",
                "Anyways, now that you are here, I have something important to discuss with you."
            )
            data.quest.king.state = 2
        end

        -- Mage speaks with the King after speaking with Herald Gerald
        -- If the Mage speaks with the King less than 2 minutes after speaking with Herald Gerald, his score is increased by 1
        -- If the Mage speaks with the King less than 5 minutes after speaking with Herald Gerald, no score change
        -- If the Mage speaks with the King more than 5 minutes after speaking with Herald Gerald, his score is decreased by 1
        if data.quest.king.state == 1 then
            data.quest.king.endTime = os.time()
            deltaTime = os.difftime(data.quest.king.endTime, data.quest.king.startTime)
            print(deltaTime)
            if deltaTime < 120 then
                talkies.say(
                    "The King",
                    "Thank you Mage for seeing me so quickly!"
                )
                data.score = data.score + 1
            elseif deltaTime < 300 then
                talkies.say(
                    "The King",
                    "Thank you Mage for seeing me!"
                )
            else
                talkies.say(
                    "The King",
                    "Mage, you have kept your King waiting!"
                )
                data.score = data.score - 2
            end
            data.quest.king.state = 2
        end

        if data.quest.dragon.state == 0 then
            talkies.say(
                "The King",
                "We have a SERIOUS dragon problem. We need you to go and slay it for the glory of the kingdom!"
            )
            data.quest.dragon.state = 1
        end

        if data.quest.dragon.state == 1 then
            talkies.say(
                "The King",
                "Go forth and deal with that dragon!"
            )
        end

        if data.quest.dragon.state == 2 or data.quest.dragon.state == 3 then
            talkies.say(
                "The King",
                "The dragon is still terrorising us.Please save our kingdom."
            )
        end

        if data.quest.dragon.state == 4 or data.quest.dragon.state == 5 then
            talkies.say(
                "The King",
                "Thank you so much for saving the kingdom. Thank you for playing the 'For Honor And Glory' demo"
            )
            data.quest.dragon.state = 5
        end
    end

    function npc:update(dt)
        npc.anim:update(dt)
    end

    function npc:draw()
        love.graphics.draw(sprites.npc.kingShadow, npc.x, npc.y, nil, nil, nil, npc.x_offset, npc.y_offset - npc.height + 5)
        npc.anim:draw(sprites.npc.kingSheet, npc.x, npc.y, nil, nil, nil, npc.x_offset, npc.y_offset)
    end

    return npc
end

return kingInit
