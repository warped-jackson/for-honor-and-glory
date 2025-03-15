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
    elseif id == "toMainOutside" then
        newMap = "openzone"
    elseif id == "toDragonLayer" then
        newMap = "dragon_layer"
    elseif id == "toThe_king" then
        newMap = "Room_KING"
    elseif id == "toThe_outside" then
        newMap = "MainOutside"
    else
        newMap = id
    end

    gamestate = 10
    player:setPosition(destX, destY)

    loadMap(newMap)
end
