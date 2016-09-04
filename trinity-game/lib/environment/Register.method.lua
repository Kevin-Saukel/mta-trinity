--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local R_Method = {}

function R_Method:getSerial ( element )
	if ( not isElement(element) ) then return false end
	return element:getSerial()
end

function R_Method:getIP ( element )
	if ( not isElement(element) ) then return false end
	return element:getIP()
end

function R_Method:getPassword( password )
	if ( not password ) then return false end
	return Class:__Get("Lib","EncodingUtility"):__MD5(password)
end

function R_Method:getUsername ( element )
	if ( not isElement(element) ) then return false end
	return element:__Get("Username")
end

function R_Method:getAuthcode ( element ) 
	if ( not isElement(element) ) then return false end
	return Class:__Get("Lib","EncodingUtility"):__GenerateSalt(32)
end

function R_Method:getAuthkey ( element )
	if ( not isElement(element) ) then return false end
	return Class:__Get("Lib","EncodingUtility"):__GenerateSalt(16)
end

--[[function R_Method:getID ( )
	if ( not isElement(element) ) then return false end
	return Class:__Get("Lib","Counter"):__Get()
end]]

Class:__New("Lib","R_Method",R_Method)