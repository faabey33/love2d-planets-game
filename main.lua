love.window.setTitle("Love2d Planets Game");
love.window.setMode(1280,720);

require "planets"
require "player"

function love.load()

	spacefont = love.graphics.newFont("aspace_demo.otf", 32)
	defaultfont = love.graphics.setNewFont(12)

	player:init()
	--x,y,size,inf

	planets:newPlanet(500,360,72,4000)


end

function love.update(dt)
	planets:update()
	player:update(dt)
end

function love.draw()
	planets:draw()
	player:draw()

	

end