local function potionMasterInit(npc, x, y, args)
    npc.sprite = sprites.npc.merchant

    npc.inventory = {}
    npc.inventory.healingPotion = 0
    npc.inventory.powerPotion = 0
    npc.inventory.deathPotion = 0
    npc.inventory.invisibilityPotion = 0

    if args.healingPotionQty then
        npc.inventory.healingPotion = args.healingPotionQty
    end

    if args.powerPotionQty then
        npc.inventory.powerPotion = args.powerPotionQty
    end

    if args.deathPotionQty then
        npc.inventory.deathPotion = args.deathPotionQty
    end

    if args.invisibilityPotionQty then
        npc.inventory.invisibilityPotion = args.invisibilityPotionQty
    end

    function npc:interact()
        if talkies.isOpen() then return end

        local potionOptions = {{'Nothing right now', function () npc:getPotion("nothing") end}}

        if npc.inventory.healingPotion > 0 then
            table.insert(potionOptions, {'Elixir of Healing', function () npc:getPotion("healing") end})
        end

        if npc.inventory.powerPotion > 0 then
            table.insert(potionOptions, {'Potion of Power', function () npc:getPotion("power") end})
        end

        if npc.inventory.deathPotion > 0 then
            table.insert(potionOptions, {'Draught of Death', function () npc:getPotion("death") end})
        end

        if ( npc.inventory.healingPotion > 0 ) or
           ( npc.inventory.powerPotion > 0 ) or
           ( npc.inventory.deathPotion > 0 )
        then
            talkies.say(
                "The Potion Master",
                "What potion can I sell to you today?",
                {
                    options = potionOptions
                }
            )
        else
            talkies.say(
                "The Potion Master",
                "Sorry, I am all out of potions right now"
            )
        end

    end

    function npc:getPotion(type)
        if type == "nothing" then
            talkies.say(
                "The Potion Master",
                "Please come back soon. I am always brewing up some new elixers!"
            )
        end

        if type == "healing" then
            talkies.say(
                "The Potion Master",
                "Thank you for buying the Elixir of Healing. Please stop by again."
            )
            npc.inventory.healingPotion = npc.inventory.healingPotion - 1
            data.inventory.healingPotion = data.inventory.healingPotion + 1
            player:gotItem(sprites.inventory.healingPotion)
        end

        if type == "power" then
            talkies.say(
                "The Potion Master",
                "Thank you for buying the Potion of Power. Please stop by again."
            )
            npc.inventory.powerPotion = npc.inventory.powerPotion - 1
            data.inventory.powerPotion = data.inventory.powerPotion + 1
            player:gotItem(sprites.inventory.powerPotion)
        end

        if type == "death" then
            talkies.say(
                "The Potion Master",
                "Thank you for buying the Draught of Death. Please be careful with that and stop by again."
            )
            npc.inventory.deathPotion = npc.inventory.deathPotion - 1
            data.inventory.deathPotion = data.inventory.deathPotion + 1
            player:gotItem(sprites.inventory.deathPotion)
        end
    end

    function npc:update(dt)
    end

    function npc:draw()
        love.graphics.draw(npc.sprite, npc.x, npc.y)
    end

    return npc
end

return potionMasterInit
