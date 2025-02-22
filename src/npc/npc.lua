npcs = {}

function spawnNPC(x, y, type, args)
    local npc = {}
    npc.width = 16
    npc.height = 24
    npc.x = x - (npc.width/2)
    npc.y = y - (npc.height/2)
    npc.collisionX = npc.x
    npc.collisionY = npc.y
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
        npc.height = npc.height + 16
    end

    -- Wall spawned overtop of the npc, passed npc as parent
    spawnWall(npc.collisionX, npc.collisionY, npc.width, npc.height, nil, nil, npc)

    function npc:update(dt)
    end

    table.insert(npcs, npc)
end

function npcs:update(dt)
    for _,n in ipairs(npcs) do
        n:update(dt)
    end
end

function npcs:draw(layer)
    love.graphics.setColor(1,1,1,1)
    for _,n in ipairs(npcs) do
        love.graphics.draw(n.sprite, n.x, n.y)
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
