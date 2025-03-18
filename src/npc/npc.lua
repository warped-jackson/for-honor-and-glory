npcs = {}

function spawnNPC(x, y, type, args)
    local npc = {}
    npc.width = 16
    npc.height = 24
    -- Move the NPC so that the x and y position that was passed become the bottom middle of the sprite
    npc.x = x - (npc.width/2)
    npc.y = y - npc.height
    -- By default, the collision box around the NPC is the same as the full width and height of the sprite
    npc.collisionX = npc.x
    npc.collisionY = npc.y
    npc.collisionWidth = npc.width
    npc.collisionHeight = npc.height

    npc.type = type
    npc.layer = -1
    npc.sprite = sprites.enemies.eye1
    npc.behindCounter = false
    npc.gone = false

    if args and args.behindCounter ~= nil then
        npc.behindCounter = args.behindCounter
    end

    -- Function that sets the properties of the new npc
    local init
    if npc.type == "potionMaster" then
        init = require("src/npc/potionMaster")
    elseif npc.type == "king" then
        init = require("src/npc/king")
    elseif npc.type == "heraldGerald" then
        init = require("src/npc/heraldGerald")
    elseif npc.type == "dragon" then
        init = require("src/npc/dragon")
    else
        init = require("src/npc/undefined")
    end

    npc = init(npc, x, y, args)

    -- if NPC is behind a counter, increase height of the collision by one tile
    if npc.behindCounter == true then
        npc.collisionHeight = npc.collisionHeight + 16
    end

    -- Wall spawned overtop of the npc, passed npc as parent
    spawnWall(npc.collisionX, npc.collisionY, npc.collisionWidth, npc.collisionHeight, nil, nil, npc)

    function npc:update_generic(dt)
    end

    table.insert(npcs, npc)
end

function npcs:update(dt)
    for _,n in ipairs(npcs) do
        n:update(dt)
        n:update_generic(dt)
    end
end

function npcs:draw(layer)
    love.graphics.setColor(1,1,1,1)
    for _,n in ipairs(npcs) do
        n:draw()
    end
end

function npcs:removeCharacter()
    local i = #npcs
    while i > 0 do
        if npcs[i].gone then
            if npcs[i].physics then
                npcs[i].physics:destroy()
            end
            table.remove(npcs, i)
        end
        i = i - 1
    end
end
