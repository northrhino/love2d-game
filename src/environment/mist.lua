mist = {}
mist.sprite = love.graphics.newImage("sprites/effects/mist.png")
mist.x = 0
mist.y = 0
mist.speedx = -10
mist.speedy = 8
mist.alpha = 0.6

function mist:update(dt)
    mist.x = mist.x + mist.speedx * dt
    mist.y = mist.y + mist.speedy * dt

    local w = mist.sprite:getWidth()
    local h = mist.sprite:getHeight()

    -- perfect wrapping using modulo
    mist.x = mist.x % w
    mist.y = mist.y % h
end

function mist:draw()
    love.graphics.setColor(1, 1, 1, mist.alpha)

    local w = mist.sprite:getWidth()
    local h = mist.sprite:getHeight()

    love.graphics.draw(mist.sprite, mist.x, mist.y)
    love.graphics.draw(mist.sprite, mist.x - w, mist.y)
    love.graphics.draw(mist.sprite, mist.x, mist.y - h)
    love.graphics.draw(mist.sprite, mist.x - w, mist.y - h)

    love.graphics.setColor(1, 1, 1, 1)
end