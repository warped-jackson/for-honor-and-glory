local function potionMasterInit(npc, x, y, args)
    npc.sprite = sprites.npc.merchant

    npc.inventory = {}
    npc.inventory.healthPotion = 1
    npc.inventory.powerPotion = 1
    npc.inventory.deathPotion = 1

    function npc:interact()
        if talkies.isOpen() then return end

        local potionOptions = {{'Nothing right now', function () npc:getPotion("nothing") end}}

        if self.inventory.healthPotion > 0 then
            table.insert(potionOptions, {'Elixir of Healing', function () npc:getPotion("healing") end})
        end

        if self.inventory.powerPotion > 0 then
            table.insert(potionOptions, {'Potion of Power', function () npc:getPotion("power") end})
        end

        if self.inventory.deathPotion > 0 then
            table.insert(potionOptions, {'Draught of Death', function () npc:getPotion("death") end})
        end

        if ( self.inventory.healthPotion > 0 ) or
           ( self.inventory.powerPotion > 0 ) or
           ( self.inventory.deathPotion > 0 )
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
            self.inventory.healthPotion = self.inventory.healthPotion - 1
            data.inventory.healthPotion = data.inventory.healthPotion + 1
        end

        if type == "power" then
            talkies.say(
                "The Potion Master",
                "Thank you for buying the Potion of Power. Please stop by again."
            )
            self.inventory.powerPotion = self.inventory.powerPotion - 1
            data.inventory.powerPotion = data.inventory.powerPotion + 1
        end

        if type == "death" then
            talkies.say(
                "The Potion Master",
                "Thank you for buying the Draught of Death. Please be careful with that and stop by again."
            )
            self.inventory.deathPotion = self.inventory.deathPotion - 1
            data.inventory.deathPotion = data.inventory.deathPotion + 1
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
