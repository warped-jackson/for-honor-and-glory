function createNewSave(fileNumber)

    -- This represents the save data
    data = {}
    data.saveCount = 0 -- times the game was saved
    data.progress = 0 -- milestone tracker
    data.playerX = 0 -- player's X position
    data.playerY = 0 -- player's Y position
    data.maxHealth = 4 -- maximum number of hearts
    data.money = 0 -- amount of currency
    data.keys = 0 -- number of keys
    data.map = "" -- currently loaded map
    data.outfit = 1 -- which cloak is equipped
    data.score = 0

    data.inventory = {}
    data.inventory.healingPotion = 0
    data.inventory.powerPotion = 0
    data.inventory.deathPotion = 0

    data.quest = {}

    --[[
    To the King Quest Progress
    0 - Not yet received the message from Herald Gerald
    1 - First meeting with the King
    2 - End of the quest, on to the Dragon Quest
    ]]--
    data.quest.king={}
    data.quest.king.state = 0
    data.quest.king.startTime = nil
    data.quest.king.endTime = nil

    --[[
    Dragon Quest Progress
    0 - Quest not yet accepted
    1 - Quest accpeted
    2 - Encountered Dragon
    3 - Potion Acquired, either Health or Death
    4 - Dragon is Gone
    5 - King Ends your quest
    ]]--
    data.quest.dragon = {}
    data.quest.dragon.state = 0

    if fileNumber == nil then fileNumber = 1 end
    data.fileNumber = fileNumber -- which file are we using

    -- Currently, can equip an item to Z and X
    data.item = {}
    data.item.left = "sword"
    data.item.right = "bow"
    data.item.altL = "fire"
    data.item.altR = "fire"

    -- keep track of certain stackable items
    data.arrowCount = 25
    data.maxArrowCount = 30
    data.bombCount = 10
    data.maxBombCount = 20

    -- table that keeps track of breakables that have been destroyed
    data.breakables = {}

    -- table that keeps track of chests that have been opened
    data.chests = {}
end

function saveGame()
    data.saveCount = data.saveCount + 1
    data.playerX = player:getX()
    data.playerY = player:getY()
    data.map = loadedMap

    if data.fileNumber == 1 then
        love.filesystem.write("file1.lua", table.show(data, "data"))
    elseif data.fileNumber == 2 then
        love.filesystem.write("file2.lua", table.show(data, "data"))
    elseif data.fileNumber == 3 then
        love.filesystem.write("file3.lua", table.show(data, "data"))
    end
end
  
function loadGame(fileNumber)
    if fileNumber == 1 then
        if love.filesystem.getInfo("file1.lua") ~= nil then
            local data = love.filesystem.load("file1.lua")
            data()
        else
            startFresh(1)
            return "No data found for save file #1"
        end
    elseif fileNumber == 2 then
        if love.filesystem.getInfo("file2.lua") ~= nil then
            local data = love.filesystem.load("file2.lua")
            data()
        else
            startFresh(2)
            return "No data found for save file #2"
        end
    elseif fileNumber == 3 then
        if love.filesystem.getInfo("file3.lua") ~= nil then
            local data = love.filesystem.load("file3.lua")
            data()
        else
            startFresh(3)
            return "No data found for save file #3"
        end
    end

    --loadMap(data.map, data.playerX, data.playerY)
    player.direction = "down"
    --player.state = 0
    --gamestate = 10
end

function startFresh(fileNumber)
    createNewSave(fileNumber)
    data.map = "Opening"
    data.playerX = 23 * 16
    data.playerY = 18 * 16
    player.state = 0
end
