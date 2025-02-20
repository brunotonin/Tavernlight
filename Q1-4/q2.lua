-- Q2 - Fix or improve the implementation of the below method

--[[
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end
--]]

function printSmallGuildNames(memberCount)
    -- Check if memberCount is a number
    if type(memberCount) ~= "number" then
        print("memberCount must be a number")
        return
    end

    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

    if resultId then
        return
    end

    -- Iterate over all guilds that have less than memberCount max
    repeat
        local guildName = resultId.getString("name")
        print(guildName)
    until not result.next(resultId)
        
    -- Free the result
    result.free(resultId)
end
