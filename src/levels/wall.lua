walls = {}

function spawnWall(x, y, width, height, name, type, parent, z)

    -- Do not spawn the wall if the name is in data.breakables
    if data.breakables[name] then return end

    local wall = world:newRectangleCollider(x, y, width, height, {collision_class = "Wall"})
    wall:setType('static')
    wall.dead = false
    wall.offY = 0
    wall.name = name
    wall.parent = parent
    wall.type = type
    wall.z = z

    if name and name:startswith('break') then
        wall.breakable = true

        -- an example of a name is 'breakRock1', where Rock tells us the sprite
        if name:find("Rock") then
            wall.sprite = sprites.environment.breakableRock
            function wall:onBreak()
                data.breakables[self.name] = true
                particleEvent("rockBreak", x+width/2, y+height/2)
            end
        elseif name:find("Wall") then
            wall.sprite = sprites.environment.breakableWall
            wall.offY = -8
            function wall:onBreak()
                data.breakables[self.name] = true
                particleEvent("rockBreak", x+width/2, y+height/2)
            end
        elseif name:find("Door") then
            wall.sprite = sprites.environment.lockedDoor
            wall.offY = -4
            wall.type = "lockedDoor"

            function wall:onBreak()
                data.breakables[self.name] = true
                shake:start(0.1, 1, 0.03)
            end
        end
    end

    if wall.type then
        if wall.type == 'ground' then
            wall:setCollisionClass('Ground')
        end
        if wall.type == 'ground1' then
            wall:setCollisionClass('Ground1')
        end
        if wall.type == 'water' then
            wall:setCollisionClass('Water')
        end
    end

    table.insert(walls, wall)

end

function walls:update(dt)
    local i = #walls
    while i > 0 do
        if walls[i].dead then
            walls[i]:onBreak()
            walls[i]:destroy()
            table.remove(walls, i)
        end
        --------------------
        if player.jumping then     
            if walls[i].name == "z1" then
                walls[i]:setCollisionClass('WallTemp')
            end

            if walls[i].name == "z2" and player.z == 1 then
                walls[i]:setCollisionClass('WallTemp')
            end
        else
            if walls[i].name == "z1" and player.z == 0 then
                walls[i]:setCollisionClass('Wall')
            end 

            if walls[i].name == "z2" and (player.z < 2) then
                walls[i]:setCollisionClass('Wall')
            end 
        end
        --------------------
        i = i - 1
    end
end

function walls:draw()
    -- most walls are invisible colliders, but some have sprites
    for _,w in ipairs(walls) do
        if w.sprite then
            love.graphics.draw(w.sprite, w:getX(), w:getY() + w.offY, nil, nil, nil, w.sprite:getWidth()/2, w.sprite:getHeight()/2)
        end
    end
end
