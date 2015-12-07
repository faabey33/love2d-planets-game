player = {}
player.x = 200
player.y = 100
player.size = 10
player.mass = 100

player.tracex = {}
player.tracey = {}

player.launch = false
player.speed = 80

player.velX = 10
player.velY = 0

player.s = 1
player.speededit = true
player.speedtext = "100"

a=0
q=0
drawTrace=false
speedtext = "100"

function player:init()
	for h=0, 20000 do
		player.tracex[h]=0
		player.tracey[h]=0
	end
	
end

function player:update(dt)
	if love.keyboard.isDown("up") and player.launch == false then
		player.y = player.y - 200 * dt
	elseif love.keyboard.isDown("down") and player.launch == false then
		player.y = player.y + 200 * dt
	elseif love.keyboard.isDown(" ") then
		player.launch = true
	end


	if player.launch == true then
		player:fly(dt)
		if a<20000 then
		player.tracex[a] = player.x
		player.tracey[a] = player.y
		a=a+1
		end
	end
end


function love.textinput(t)
	if player.speededit == true then
		player.speedtext = player.speedtext .. t
	end
end

function love.keypressed(k)
	if k == "return" and player.speededit == false then
		planets.reset()
	elseif k == "return" and player.speededit == true then
		changeSpeed()
	elseif k == "backspace" and player.speededit == true then
		delete()
	end
end

function changeSpeed()
	player.velX = player.speedtext/10
end

function delete() 
	local string = player.speedtext

	if (#string > 0) then
		string = string:sub( 1, #string - 1 )
		player.speedtext = string;
	end
end


function player:draw()
	love.graphics.setColor(255,255,255,30)
	love.graphics.line(200,0,200,love.graphics.getHeight())
	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("fill",player.x, player.y, player.size)
	love.graphics.print(player.mass, player.x-12, player.y - 28)

	love.graphics.setColor(255,255,255,100)
	love.graphics.print("X Velocity: "..math.ceil(player.velX*10), 10,50)
	love.graphics.print("Y Velocity: "..math.ceil(player.velY*10), 10,70)
	love.graphics.setColor(255,255,255,255)
	
	if player.launch == true then
		drawTrace = true
		player.speededit = false
	end
	if drawTrace == true then
		for j=0, 20000 do
			love.graphics.setColor(255,255,255,100)
			love.graphics.point(player.tracex[j], player.tracey[j])
			love.graphics.setColor(255,255,255,255)
		end
	end
	
	if player.launch == false then
		love.graphics.rectangle("line",player.x-55, player.y-10, 34, 16)
		love.graphics.print("Speed: ", player.x-120, player.y-10)
		love.graphics.print(player.speedtext,player.x-53, player.y-8)

		local mousex, mousey = love.mouse.getPosition()
		if mousex > player.x-55 and mousex < player.x-55+34 and mousey > player.y-10 and mousey < player.y-10+16 and player.speededit==true then

		end

	end



end

function player:fly(dt)

	local G = 1

	player.x = player.x + player.velX*dt*player.s
	player.y = player.y + player.velY*dt*player.s


	for i=0, planets.count-1 do


		if player.x < planets.x[i] then
			player.velX = player.velX + 0.5*(1/planets.distances[0]^2)*planets.mass[i]
		else
			player.velX = player.velX - 0.5*(1/planets.distances[0]^2)*planets.mass[i]
		end


		if player.y < planets.y[i] then
			player.velY = player.velY + 0.5*(1/planets.distances[0]^2)*planets.mass[i]
		else
			player.velY = player.velY - 0.5*(1/planets.distances[0]^2)*planets.mass[i]
		end

	end



	

end

