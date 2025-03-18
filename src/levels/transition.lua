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

function currentlyPlaying(tag)
    channels = dj.findTag(tag)
    if #channels > 0 then
        return true
    end
    return false
end

function triggerTransition(id, destX, destY)
    local newMap = "test"

    if id == "toOpening" then
        newMap = "Opening"
        if currentlyPlaying("overworld") == false  then
            dj.stop("music")
            dj.playLooping(sounds.music.overworld, "stream", {"music", "overworld"})
        end
    elseif id == "toHubZone" then
        newMap = "HubZone"
        if currentlyPlaying("overworld") == false  then
            dj.stop("music")
            dj.playLooping(sounds.music.overworld, "stream", {"music", "overworld"})
        end
    elseif id == "toTown" then
        newMap = "Town"
        if currentlyPlaying("town") == false  then
            dj.stop("music")
            dj.playLooping(sounds.music.town, "stream", {"music", "town"})
        end
    elseif id == "toCastle" then
        newMap = "Castle"
        if currentlyPlaying("castle") == false  then
            dj.stop("music")
            dj.playLooping(sounds.music.castle, "stream", {"music", "castle"})
        end
    elseif id == "toDragonLayer" then
        newMap = "DragonLayer"
        if currentlyPlaying("cave") == false  then
            dj.stop("music")
            dj.playLooping(sounds.music.cave, "stream", {"music", "cave"})
        end
    else
        newMap = id
    end
    dj.volume("music", 0.6)

    gamestate = 10
    player:setPosition(destX, destY)

    loadMap(newMap)
end
