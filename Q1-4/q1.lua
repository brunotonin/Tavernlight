-- 1-Q4 - Fix or improve the implementation of the below methods.

-- Q1 - Fix or improve the implementation of the below methods:
local function releaseStorage(playerId, storage)
    local player = Player(playerId)
    if not player then
        return false
    end

    player:setStorageValue(storage, -1)
    return true
end

function onLogout(player)
    local storage = 1000
    if player:getStorageValue(storage) == 1 then
        addEvent(releaseStorage, 1000, player:getId(), storage)
    end
    
    return true
end
