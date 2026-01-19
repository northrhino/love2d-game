function loadMap(mapName, destX, destY)
    destroyAll()

    if destX and destY then
        player:setPosition(destX, destY)
    end

    loadedMap = mapName
    gameMap = sti("maps/" .. mapName .. ".lua")

    if gameMap.layers["Walls"] then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            spawnWall(obj.x, obj.y, obj.width, obj.height, obj.name, obj.type)
        end
    end

    if gameMap.layers["Enemies"] then
        for i, obj in pairs(gameMap.layers["Enemies"].objects) do
            local args = {}
            if obj.properties.form then args.form = obj.properties.form end
            spawnEnemy(obj.x, obj.y, obj.name, args)
        end
    end

    if gameMap.layers["Loot"] then
        for i, obj in pairs(gameMap.layers["Loot"].objects) do
            spawnLoot(obj.x, obj.y, obj.type, false, obj.properties.price)
        end
    end

    if gameMap.layers["Chests"] then
        for i, obj in pairs(gameMap.layers["Chests"].objects) do
            spawnChest(obj.x, obj.y, obj.name, obj.type)
        end
    end

    if gameMap.layers["NPC"] then
        for i, obj in pairs(gameMap.layers["NPC"].objects) do
            spawnNPC(obj.name, obj.x, obj.y)
        end
    end

    if gameMap.layers["Transitions"] then
        for i, obj in pairs(gameMap.layers["Transitions"].objects) do
            spawnTransition(obj.x, obj.y, obj.width, obj.height, obj.name, obj.properties.destX, obj.properties.destY, obj.type)
        end
    end

    if gameMap.layers["Triggers"] then
        for i, obj in pairs(gameMap.layers["Triggers"].objects) do
            spawnTrigger(obj.x, obj.y, obj.name)
        end
    end

    if gameMap.layers["Trees"] then
        for i, obj in pairs(gameMap.layers["Trees"].objects) do
            spawnTree(obj.x, obj.y, obj.type, obj.name)
        end
    end

    if gameMap.layers["Water"] then
        for i, obj in pairs(gameMap.layers["Water"].objects) do
            spawnWater(obj.x, obj.y, obj.width, obj.height)
        end
    end

    if gameMap.layers["Ground"] then
        for i, obj in pairs(gameMap.layers["Ground"].objects) do
             spawnWall(obj.x, obj.y, obj.width, obj.height, nil, 'ground')
        end
    end

    if gameMap.layers["Ground1"] then
        for i, obj in pairs(gameMap.layers["Ground1"].objects) do
             spawnWall(obj.x, obj.y, obj.width, obj.height, obj.name, 'ground1')
        end
    end
    

    if gameMap.properties.dark then
        gameMap.dark = gameMap.properties.dark
    else
        gameMap.dark = false
    end



    sound = {} -- move this to sounds{}

    if gameMap.properties.rain then

        --[[
            Rain variables
            deltaX: distance in pixels from the x1 value of a rain line to the x2
            deltaY: distance in pixels from the y1 value of a rain line to the y2
            rainAmount: amount of rain drops
        ]]--

        deltaX = 1
        deltaY = 3
        rainAmount = 1000

        sound[0] = love.audio.newSource("rain.ogg", "stream")
        sound[1] = love.audio.newSource("rain.ogg", "stream")
        sound[0]:setLooping(true)
        sound[0]:play()
        sound_time = 0

        local mapthWidth = gameMap.width * 16
        local mapthHeight = gameMap.height * 16
        rain = Rain:new (nil, mapthWidth, mapthHeight, deltaX, deltaY, rainAmount)
    end

end