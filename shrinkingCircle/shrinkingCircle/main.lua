-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--
-- note
--
-- This project is to learn creating variables and variable-dependent variables
--
-----------------------------------------------------------------------------------------

-- Some initial variable settings
local xMax = display.contentWidth
local yMax = display.contentHeight
local rMax = 100

local xCircInit = xMax/2
local yCircInit = yMax/2
local rCircInit = rMax

local xCircle = xCircInit
local yCircle = yCircInit
local rCircle = rCircInit

local xScore = xMax/2
local yScore = yMax*0.05
local score = 0

-- Score display

local scoreDisplay = display.newText( score, xScore, yScore )
	scoreDisplay.size = 50

-- Circle display
local theCircle = display.newCircle( xCircle, yCircle, rCircle)
	local rRandom = math.random(0,10)/10
	local gRandom = math.random(0,10)/10
	local bRandom = math.random(0,10)/10
	theCircle:setFillColor( rRandom, gRandom, bRandom )

-- Start display
local startDisplay = display.newText( "TAP CIRCLE", xMax/2, yMax*3/4+25 )
	startDisplay.size = 50

-- Lose display
local loseDisplay = display.newText( "YOU LOSE!", xMax/2, yMax/2 )
	loseDisplay.size = 30
	loseDisplay.alpha = 0

-- Restart display
local restartDisplay = display.newText( "TAP TO RESTART", xMax/2, yMax/2+30 )

	restartDisplay.size = 30
	restartDisplay.alpha = 0

-- Lose function 
local function loseGame()

	theCircle.alpha = 0
	loseDisplay.alpha = 1
	restartDisplay.alpha = 1

	print( "GameLoseFunction" )

end

-- Shrink circle function
local function shrinkCircle ()

	if rCircle >1 then

		-- Reduce radius by 1
		rCircle = rCircle - 1
		theCircle.path.radius = rCircle
		timer.performWithDelay( 100, shrinkCircle )
		print( rCircle )

	else

		loseGame()

	end

end

-- Restart game function
local function restartGame()

	-- Get rid of lose display
	loseDisplay.alpha = 0
	restartDisplay.alpha = 0
	theCircle.alpha = 1

	-- reset score
	score = 0
	scoreDisplay.text = score

	-- reset cicle
	xCircle = xCircInit
	yCircle = yCircInit
	rCircle = rCircInit
	theCircle.x = xCircle
	theCircle.y = yCircle
	theCircle.path.radius = rCircle

	startDisplay.alpha = 1

	print( "GameRestartFunction" )

end

-- click circle function
local function clickCircle ()

	-- reset radius
	rCircle = rMax
	theCircle.path.radius = rCircle

	-- random position
	local xRandom = xMax*math.random( 20, 80) / 100
	local yRandom = yMax*math.random( 20, 80 ) / 100
	theCircle.x, theCircle.y = xRandom, yRandom

	-- increase score by 1
	score = score + 1
	scoreDisplay.text = score

	-- random color
	local rRandom = math.random( 2, 10 ) / 10
	local gRandom = math.random( 2, 10 ) / 10
	local bRandom = math.random( 2, 10 ) / 10
	theCircle:setFillColor( rRandom, gRandom, bRandom )

	-- run shrink circle function
	shrinkCircle()
	startDisplay.alpha = 0

	print( "ClickCircleFunction" )

end

-- Last step is to make a high score shown on the gameover screen
--[[
	Compare value of score with value in file.
	Write the larger number into file and save.
	High score display from file.
	Means I have to pre-include a high score file.
	Do a pre-check at the beginning for a high score file.
	If not present, make one.
]]--


restartDisplay:addEventListener( "tap", restartGame )
loseDisplay:addEventListener( "tap", restartGame )
theCircle:addEventListener( "tap", clickCircle )
