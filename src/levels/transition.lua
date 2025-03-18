transitions = {}

function spawnTransition(x, y, width, height, id, destX, destY, transitionType)

    local transition = world:newRectangleCollider(x, y, width, height, {collision_class = "Transition"})
    transition:setType('static')

    transition.id = id
    transition.destX = destX
    transition.destY = destY
    transition.type = "standard"

    if transitionType then transition.type = transitionType end

    table.insert(transitions, transition)

end

function triggerTransition(id, destX, destY)
    local newMap = "test"

    if id == "toOpening" then
        newMap = "Opening"
    elseif id == "toHubZone" then
        newMap = "HubZone"
    elseif id == "toTown" then
        newMap = "Town"
    elseif id == "toCastle" then
        newMap = "Castle"
    elseif id == "toDragonLayer" then
        newMap = "DragonLayer"
    else
        newMap = id
    end

    gamestate = 10
    player:setPosition(destX, destY)

    loadMap(newMap)
end
