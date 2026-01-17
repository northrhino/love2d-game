function updateAll(dt)

    --if pause.active == false then
        updateGame(dt)
    --end
    
    pause:update(dt)
    dj.cleanup()
    if gameMap then gameMap:update(dt) end
    checkWindowSize()

end

function updateGame(dt)
    miscUpdate(dt)
    if globalStun > 0 then return end

    flux.update(dt)

    player:update(dt)
    world:update(dt)
    walls:update(dt)
    blasts:update(dt)
    effects:update(dt)
    waters:update(dt)
    chests:update(dt)
    arrows:update(dt)
    bombs:update(dt)
    boomerang:update(dt)
    grapple:update(dt)
    fireballs:update(dt)
    flames:update(dt)
    loots:update(dt)
    enemies:update(dt)
    enemies:destroyDead()
    projectiles:update(dt)
    trees:update(dt)

    cam:update(dt)
    shake:update(dt)
    shaders:update(dt)
    triggers:update(dt)
    particles:update(dt)
    particleWorld:update(dt)

    
    -- Rain update
    if gameMap.properties.rain then

        -- Rain soud
        sound_time = sound_time + dt
        if sound_time >= 20 then
          sound[1]:setVolume(0.8)
          sound[1]:play()
          sound_time = 0
        end

        rain:update(dt)
    end

    mist:update(dt)

end
