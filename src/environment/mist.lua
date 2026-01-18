-- mist.lua
mist = {}
mist.layers = {
    {
        sprite = love.graphics.newImage("sprites/environment/mist.png"),
        x = 0, y = 0,
        speedx = -6, speedy = -2,
        alpha = 0.1,
        scale = 1.0
    }
--[[     ,
    {
        sprite = love.graphics.newImage("sprites/environment/mist.png"),
        x = 0, y = 0,
        speedx = -12, speedy = -4,   -- faster for parallax
        alpha = 0.1,
        scale = 1.2                  -- slightly larger for depth
    } ]]
}

function mist:update(dt)
    for _, layer in ipairs(self.layers) do
        layer.x = (layer.x + layer.speedx * dt) % layer.sprite:getWidth()
        layer.y = (layer.y + layer.speedy * dt) % layer.sprite:getHeight()
    end
end

function mist:draw()
    for _, layer in ipairs(self.layers) do
        love.graphics.setColor(1, 1, 1, layer.alpha)

        local w = layer.sprite:getWidth() * layer.scale
        local h = layer.sprite:getHeight() * layer.scale

        -- how many tiles needed to cover the screen?
        local sw = love.graphics.getWidth()
        local sh = love.graphics.getHeight()

        -- start drawing slightly before the screen to avoid gaps
        local startX = -w + (layer.x % w)
        local startY = -h + (layer.y % h)

        for x = startX, sw, w do
            for y = startY, sh, h do
                love.graphics.draw(layer.sprite, x, y, 0, layer.scale, layer.scale)
            end
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end
