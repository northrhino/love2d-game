Rain = {width = 1, height = 1, deltaX = 1, deltaY = 1, rainAmount = 1}

function Rain:new (o, width, height, deltaX, deltaY, rainAmount)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.width = width or 1
  self.height = height or 1
  self.deltaX = deltaX or 1
  self.deltaY = deltaY or 1
  self.rainAmount = rainAmount or 1
  self.rain = {}
  self.drops = {}

  for i=1,self.rainAmount do
    self.rain[i] = {}
    self.drops[i] = {}
    self.var = love.math.random(1, 2)
    self.rain[i].deltaX = self.deltaX * self.var
    self.rain[i].deltaY = self.deltaY * self.var
    self.rain[i].x1 = love.math.random(-500, self.width)
    self.rain[i].y1 = love.math.random(-500, -50)
    self.rain[i].x2 = self.rain[i].x1 + self.rain[i].deltaX
    self.rain[i].y2 = self.rain[i].y1 + self.rain[i].deltaY
    self.rain[i].speed = love.math.random(90, 200)
    self.rain[i].lenght = ((self.rain[i].x2 - self.rain[i].x1)^2 + (self.rain[i].y2 - self.rain[i].y1)^2)^0.5
    self.rain[i].sin = (self.rain[i].y2 - self.rain[i].y1)/self.rain[i].lenght
    self.rain[i].cos = (self.rain[i].x2 - self.rain[i].x1)/self.rain[i].lenght
    self.rain[i].color = love.math.random(1,10)/2
    self.rain[i].limit = love.math.random(1,  self.height)

    self.drops[i].radius = 0.5
  end

  return o
end

function Rain:update (dt)
  for i=1,self.rainAmount do
    -- Calulates the rain position
    self.rain[i].x1 = self.rain[i].x1 + self.rain[i].cos * self.rain[i].speed * dt
    self.rain[i].y1 = self.rain[i].y1 + self.rain[i].sin * self.rain[i].speed * dt
    self.rain[i].x2 = self.rain[i].x2 + self.rain[i].cos * self.rain[i].speed * dt
    self.rain[i].y2 = self.rain[i].y2 + self.rain[i].sin * self.rain[i].speed * dt

    -- Calculates the sequential fade when a rain drop hits the floor
    if (self.rain[i].y1 >= self.rain[i].limit) then
      self.rain[i].x2 = self.rain[i].x2 - self.rain[i].cos * self.rain[i].speed * dt
      self.rain[i].y2 = self.rain[i].y2 - self.rain[i].sin * self.rain[i].speed * dt

      if self.rain[i].y2 <= self.rain[i].y1 then
        self.drops[i].x = self.rain[i].x2
        self.drops[i].y = self.rain[i].y2
        self.drops[i].thing = true
        self.drops[i].radius = 0.5
        self.rain[i].x1 = love.math.random(-500, self.width)
        self.rain[i].y1 = love.math.random(-500, -50)
        self.rain[i].x2 = self.rain[i].x1 + self.rain[i].deltaX
        self.rain[i].y2 = self.rain[i].y1 + self.rain[i].deltaY
      end
    end

    -- Ellipses created when a rain drop hits the floor
    if self.drops[i].thing then
      self.drops[i].radius = self.drops[i].radius + 0.2
      if self.drops[i].radius >= 3 then
        self.drops[i].thing = false
      end
    end

  end
end

function Rain:draw ()
  for i=1,self.rainAmount do
    love.graphics.setLineWidth(0.7)
    -- Draw the rain drops
    love.graphics.setColor(self.rain[i].color, self.rain[i].color, self.rain[i].color, 0.3)
    love.graphics.line(self.rain[i].x1, self.rain[i].y1, self.rain[i].x2, self.rain[i].y2)

    -- Draw the ellipses that are created when a rain drop hits the floor
    if self.drops[i].thing then
      love.graphics.setColor(1,1,1,0.3)
      love.graphics.ellipse("line", self.drops[i].x, self.drops[i].y, self.drops[i].radius, self.drops[i].radius/2)
    end

    love.graphics.setLineWidth(1)
  end
end

return Rain
