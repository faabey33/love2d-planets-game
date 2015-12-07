planets = {}
planets.count = 0
planets.mass = {}
planets.x = {}
planets.y = {}
planets.size = {}
planets.distances = {}
planets.level = 1
planets.levelText = "Level "..planets.level;

planets.targetx = love.graphics.getWidth() - 150
planets.targety = love.graphics.getHeight()/2
planets.targetsize = 35



function planets:newPlanet(x, y, size, inf)
	planets.x[planets.count] = x
	planets.y[planets.count] = y
	planets.size[planets.count] = size
	planets.mass[planets.count] = inf

	planets.count=planets.count+1;
end

function planets:update()
	for i=0, planets.count-1 do
		planets.distances[i] = planets:distance(player.x, player.y, planets.x[i], planets.y[i])-planets.size[i]
	end

	if planets:collision()==true then
		planets:reset()
	end

	if planets:target()==true then
		win()
	end
end

function planets:draw()
	love.graphics.setFont(spacefont)
	love.graphics.print(planets.levelText, love.graphics.getWidth()/2-100, 0)
	love.graphics.setFont(defaultfont)

	love.graphics.setColor(0,255,0,255)
	love.graphics.circle("line",planets.targetx, planets.targety, planets.targetsize)
	love.graphics.setColor(255,255,255,255)

	for i=0 ,planets.count-1 do
		love.graphics.setColor(0,255,0,35)
		love.graphics.line(player.x, player.y, planets.x[i], planets.y[i])
		love.graphics.setColor(planets.mass[i]/10,0,255,255)
		love.graphics.circle("line", planets.x[i], planets.y[i], planets.size[i])
		love.graphics.print(planets.mass[i], planets.x[i], planets.y[i])
		love.graphics.setColor(255,255,255,255)
	end

end

function planets:distance(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end


function planets:collision()
	for k=0, planets.count-1 do
		if planets.distances[k] < planets.size[k]/6.28 then
			return true
		end
	end
end

function planets:target()
	--if player.x>planets.targetx and player.x<planets.targetx+planets.targetwidth and player.y<planets.targety and player.y<planets.targety+planets.targetheight then
	if planets:distance(player.x, player.y, planets.targetx, planets.targety) < planets.targetsize then
		return true
	end
end


function planets:reset()
	player.launch = false
	player.x = 200
	player.velX = 10
	player.velY = 0
	player.speededit = true
end

function win()
	planets.level = planets.level + 1
	planets.levelText = "Level "..planets.level;

	player.launch = false
	player.x = 200
	player.velX = 10
	player.velY = 0
	player.speededit = true

	planets:newPlanet(math.random(400,800),math.random(100,700),math.random(40, 100), math.random(2000,8000))


	for k=0, planets.level-1 do
		planets.x[k] = math.random(400,800)
		planets.y[k] = math.random(100,700)
		planets.size[k] = math.random(40, 100)
		planets.mass[k] = math.random(2000,8000)
	end	

	planets.targety = math.random(300,600)
end