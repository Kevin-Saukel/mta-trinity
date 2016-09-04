--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local DX = {}
local gpsx, gpsy = 1680, 1050
local gx, gy = guiGetScreenSize()

function DX:__Constructor ()
	if ( not self.class ) then
		self.class = {}
	end
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["ActionState"] = false
	self.data["ActionFromLastInit"] = nil
	self.data["InfoboxState"] = false
	self.data["InfoboxLastInit"] = nil
	--*******************************************************************************************************************************--
	
	self.data["Keys"] = {}
	self.data["Keys"]["Alt"] = {}
	self.data["Keys"]["Alt"]["q"] = "@"
	self.data["Keys"]["Alt"]["e"] = "€"
	self.data["Keys"]["Alt"]["2"] = "²"
	self.data["Keys"]["Alt"]["3"] = "³"
	self.data["Keys"]["Alt"]["7"] = "{"
	self.data["Keys"]["Alt"]["8"] = "["
	self.data["Keys"]["Alt"]["9"] = "]"
	self.data["Keys"]["Alt"]["0"] = "}"
	self.data["Keys"]["Alt"]["+"] = "~"
	self.data["Keys"]["Alt"]["<"] = "|"
	
	self.data["Keys"]["Shift"] = {}
	self.data["Keys"]["Shift"]["^"] = "°"
	self.data["Keys"]["Shift"]["1"] = "!"
	self.data["Keys"]["Shift"]["3"] = "§"
	self.data["Keys"]["Shift"]["4"] = "$"
	self.data["Keys"]["Shift"]["5"] = "%"
	self.data["Keys"]["Shift"]["6"] = "&"
	self.data["Keys"]["Shift"]["7"] = "/"
	self.data["Keys"]["Shift"]["8"] = "("
	self.data["Keys"]["Shift"]["9"] = ")"
	self.data["Keys"]["Shift"]["0"] = "0"
	self.data["Keys"]["Shift"]["ß"] = "?"
	self.data["Keys"]["Shift"]["+"] = "*"
	self.data["Keys"]["Shift"]["."] = ":"
	self.data["Keys"]["Shift"][","] = ";"
	self.data["Keys"]["Shift"]["-"] = "_"
	self.data["Keys"]["Shift"]["<"] = ">"
	
	self.data["Keys"]["Arabic"] = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
	self.data["Keys"]["Numerical"] = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' }
	self.data["Keys"]["Symbol"] = { '[', ']', '!' }
end

function DX:__Add ( classname, class )
	if ( classname and class ) then
		if ( not self.class ) then
			self.class = {}
		end
		if ( not self.class[classname] ) then
			self.class[classname] = class
		end
	end
end

function DX:__Call ( init )
	if ( init ) then
		return self.class[init]
	end
end

function DX:__Transform ( x, y, w, h, gpx, gpy )
	if ( x and y and w and h ) then
		if ( not gpx and not gpy ) then
			gpx = gpsx
			gpy = gpsy
		end
		local x = gx*((x)/gpx)
		local y = gy*((y)/gpy)
		local w = gx*((w)/gpx)
		local h = gy*((h)/gpy)
		return x,y,w,h
	end
end

function DX:__setActionState ( bool, lastInit )
	self.data["ActionState"] = bool
	self.data["ActionFromLastInit"] = lastInit
end

function DX:__getActionState ( )
	return self.data["ActionState"]
end

function DX:__resetActionState ( lastInit )
	if ( self.data["ActionFromLastInit"] ) then
		if ( lastInit == self.data["ActionFromLastInit"] ) then
			self.data["ActionState"] = false
			self.data["ActionFromLastInit"] = nil
		end
	end	
end

function DX:__setInfoboxState ( bool, lastInit )
	self.data["InfoboxState"] = bool
	self.data["InfoboxLastInit"] = lastInit
end

function DX:__getInfoboxState ( )
	return self.data["InfoboxState"], self.data["InfoboxLastInit"]
end

function DX:__resetInfoboxState ( lastInit )
	if ( self.data["InfoboxLastInit"] ) then
		if ( lastInit == self.data["InfoboxLastInit"] ) then
			self.data["InfoboxState"] = false
			self.data["InfoboxLastInit"] = nil
		end
	end
end


function DX:__getAltKey ( key )
	if ( key ) then
		if ( self.data["Keys"]["Alt"][key] ) then
			return self.data["Keys"]["Alt"][key]
		else
			return key
		end
	end
end

function DX:__getShiftKey ( key )
	if ( key ) then
		if ( self.data["Keys"]["Shift"][key] ) then
			return self.data["Keys"]["Shift"][key]
		else
			return key:upper()
		end
	end
end

function DX:__getCursorArea( x, y, w, h )
	if ( x and y and w and h ) then
		if isCursorShowing() then
		local mx,my = getCursorPosition()
		cursorx,cursory = mx*gx,my*gy
			if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

function DX:__getDevSize ()
	if ( gpsx and gpsy ) then
		return gpsx, gpsy
	else
		return nil, nil
	end
end

function DX:__isKeyArabic ( key )
	local val = false
	for i, k in pairs(self.data["Keys"]["Arabic"]) do 
		if ( string.upper(key) == string.upper(k) ) then
			val = true
			break
		end
	end
	return val
end

function DX:__isKeyNumerical ( key )
	local val = false
	for i, k in pairs(self.data["Keys"]["Numerical"]) do 
		if ( key == k ) then
			val = true
			break
		end
	end
	return val
end

function DX:__isKeySymbol ( key ) 
	local val = false
	for i, k in pairs(self.data["Keys"]["Symbol"]) do 
		if ( key == k ) then
			val = true
			break
		end
	end
	return val
end
 

Class:__New("Lib","DX",DX)

