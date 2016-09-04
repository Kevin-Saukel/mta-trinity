--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 03.08.2016 *********--
--*****************************--

local function test_Editbox ( cmd, x, y, w, h )
	local editbox = Class:__Get("Lib","DX"):__Call("Editbox"):__New(tonumber(x),tonumber(y),tonumber(w),tonumber(h))
	editbox:__setColor(255,255,255,100)
end
addCommandHandler("test.neweditbox",test_Editbox)

local function test_Button ( cmd, x, y, w, h )
	showCursor(true)
	local button = Class:__Get("Lib","DX"):__Call("Button"):__New(tonumber(x),tonumber(y),tonumber(w),tonumber(h))
	button:__setImage(":vip/client/images/DX/box.png",":vip/client/images/DX/box.png")
end
addCommandHandler("test.button",test_Button)

local function test_Window ( cmd, x, y, w, h )
	local window = Class:__Get("Lib","DX"):__Call("Window"):__New(tonumber(x),tonumber(y),tonumber(w),tonumber(h))
end
addCommandHandler("test.window",test_Window)

local function test_Checkbox ( cmd, x, y, w, h )
	local checkbox = Class:__Get("Lib","DX"):__Call("Checkbox"):__New(tonumber(x),tonumber(y),tonumber(w),tonumber(h))
end
addCommandHandler("test.checkbox",test_Checkbox)

--[[local screenWidth, screenHeight = guiGetScreenSize()
local webBrowser

local function test_Browser ( )
	webBrowser = createBrowser(screenWidth, screenHeight, true, false)
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
		--After the browser has been initialized, we can load our file.
		loadBrowserURL(webBrowser, "http://mta/local/html/site.html")
		--Now we can start to render the browser.
		addEventHandler("onClientRender", root, webBrowserRender)
	end
)
end
addCommandHandler("test.browser",test_Browser)

function webBrowserRender()
	dxDrawImage(0, 0, screenWidth, screenHeight, webBrowser, 0, 0, 0, tocolor(255,255,255,50), true)
end
 
--The event onClientBrowserCreated will be triggered, after the browser has been initialized.
--After this event has been triggered, we will be able to load our URL and start drawing.



function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
 
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
 
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
 
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
 
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.floor(math.cos( math.rad( i ) ) * ( radius - width ))
		local startY = math.floor(math.sin( math.rad( i ) ) * ( radius - width ))
		local endX = math.floor(math.cos( math.rad( i ) ) * ( radius + width ))
		local endY = math.floor(math.sin( math.rad( i ) ) * ( radius + width ))
 
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
 
	return true
end

local screenWidth, screenHeight = guiGetScreenSize( )
local stopAngle = 0

addEventHandler( "onClientRender", root, 
	function( )
		-- We're starting to draw the circle at 0° which means that the first point of the arc is ( 200+50 | 200 )
		-- Therefore the last point is ( 200 | 200+50 ). > Our arc is the "lower right" quarter of the circle.
		dxDrawCircle( screenWidth / 2, screenHeight / 2, 20, 20, 1, 0, 360 )
	end
)]]
