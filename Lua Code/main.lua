--Q1 - Fix or improve the implementation of the below methods

--This depends on how we set up the addEvent function. If we set it up where everything that happens needs to get in line to run don't change anythings.
--setup test variables
local player = {}
local loc = 1000
player[loc] = 1

--Shows what the current player state it.
print("Current value")
print(player[1000])

--function to test the player state
function player:getStorageValue(storage_location)
    return player[storage_location]
end

--function to change the player state
function player:setStorageValue(storage_location, value)
    player[storage_location] = value
end

--function to simulate the the event que.
function addEvent(functions, location, value)
    functions(location, value)
 end

--this runs the function that changes the state.
local function releaseStorage(storage_location, player)
    player:setStorageValue(storage_location, -1)
end

--Execute code on logout
function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end

--starts this mess of code.
onLogout(player)

--Shows what the current player state it.
print("new value")
print(player[1000])
-- in my opinion this is way too much code to change one vaule...

-- Q2 - Fix or improve the implementation of the below method
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    --This next line was incorrect.
    local guildName = resultId.getString("name")
    print(guildName)
    end


--Q3 - Fix or improve the name and the implementation of the below method

--create a test case for the player
Player = {}
Player["ID"] = 2354715
Player["party"] = "HellDiver"
Player["membername"] = "The Crazy One"

--create a test party
Party = {}
Party["HellDiver"] = {"The Sane One", "The Crazy One", "The One who doen't know", "The One who knows"}

--print out who all is in the party
print("Here is the list of people in the party")
for k,v in pairs(Party["HellDiver"]) do
    print(v)
end
--function to enteract with the player and party data.
function Player:getParty()
    return Player["party"]
end

function Party:getMembers()
    return Party["HellDiver"]
end

function Party:removeMember()
    table.remove(Party["HellDiver"], 2);
    
end

function removeMemberFromParty(playerId, membername)
    local player = Player[playerId]
    local party = Player:getParty()
    
    for k,v in pairs(Party:getMembers()) do
        print(v, "test case")
        print(Player["membername"] , " player test case")
        if v == Player["membername"] then
            Party:removeMember(Player["membername"])
        end
    end
end


--runs this mess of code.
removeMemberFromParty(2354715, "The Crazy One")

--print out who all is in the party
print(" ")
print("Here is the list of people in the party")
for k,v in pairs(Party["HellDiver"]) do
    print(v)
end

--discalmer: I know I switched around alot of sintax to get my sudo "player" and "party" data to work. 
--I understand this is not how I would nomorly intract with a live data base.


