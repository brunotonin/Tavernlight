-- Q3 - Fix or improve the name and the implementation of the below method
--[[
function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    for k, v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end
--]]

function removePlayerFromParty(playerId, memberName)
    -- Verify if the player and the member exist
    local player = Player(playerId)
    local playerMember = Player(memberName)

    if not player or not playerMember then
        return
    end

    -- Check if there is a party
    local party = player:getParty()
    if not party then
        return
    end

    -- check if member and player is in the same party
    if playerMember:getParty() ~= party then
        return
    end

    -- Remove the member from the party
    party:removeMember(playerMember)
end

