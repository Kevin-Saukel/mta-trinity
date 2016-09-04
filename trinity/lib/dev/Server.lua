--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 03.08.2016 *********--
--*****************************--

local function test_Register ( element, cmd, username, password )
	if ( isElement(element) ) then
		local register = Class:__Get("Lib","Register"):__onElement(element, username, password)
		if ( register ) then
			outputChatBox("Register was sucessfull.",element)
		end
	end
end
addCommandHandler("test.register",test_Register)

local function test_Login ( element, cmd, username, password )
	if ( isElement(element) ) then
		local login = Class:__Get("Lib","Login"):__onElement(element, username, password)
		if ( login ) then
			outputChatBox("Login was sucessfull.",element)
		end
	end
end
addCommandHandler("test.login",test_Login)

local function test_Guest( element )
	if ( isElement(element) ) then
		local guest = Class:__Get("Lib","Guest"):__onElement(element)
		if ( guest ) then
			outputChatBox("Guest-Login was sucessfull.",element)
		end
	end
end
addCommandHandler("test.guest",test_Guest)

local function test_dataget ( element, cmd, datastring )
	if ( isElement(element) ) then
		outputChatBox("Data '"..datastring.."' returned '"..tostring(element:__Get(datastring)).."'",element)
	end
end
addCommandHandler("test.dataget",test_dataget)

local function test_dataset ( element, cmd, datastring, value )
	if ( isElement(element) ) then
		local dataset = element:__Set(datastring,value)
		if ( dataset ) then
			outputChatBox("Dataset was sucessfull.",element)
		end
	end
end
addCommandHandler("test.dataset",test_dataset)

local function test_playerspawn ( element, cmd, x, y, z )
	if ( isElement(element) ) then
		local spawn = element:__Spawn(x,y,z,0,1,0,0,nil,2,255,0,0)
		if ( spawn ) then
			outputChatBox("Spawn was sucessfull.",element)
		end
	end
end
addCommandHandler("test.playerspawn",test_playerspawn)