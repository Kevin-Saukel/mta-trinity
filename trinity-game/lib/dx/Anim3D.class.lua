--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Anim3D = {}

function Anim3D:__New ( x, y, z, endx, endy, endz, easing, time )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	--*******************************************************************************************************************************--
	self.data["X"] = x
	self.data["Y"] = Y
	self.data["Z"] = z
	self.data["EndX"] = endx
	self.data["EndY"] = endy
	self.data["EndZ"] = endz
	self.data["Easing"] = easing
	self.data["Time"] = time
	--*******************************************************************************************************************************--
	self.data["S_Time"] = getTickCount()
	self.data["E_Time"] = self.data["Time"] + self.data["S_Time"]
	--*******************************************************************************************************************************--
	return self
end

function Anim3D:__getElement()
	return self.data["Element"]
end

function Anim3D:__getPosition()
	self.data["Now"] = getTickCount()
	self.data["Progress"] = ( now - self.data["S_Time"] ) / ( self.data["E_Time"] - self.data["S_Time"] )
	self.data["EX"], self.data["EY"] = interpolateBetween(
		self.data["X"], self.data["Y"], self.data["Z"],
		self.data["EndX"], self.data["EndY"], self.data["EndZ"],
		self.data["Progress"], self.data["Easing"]
	)
	return self.data["EX"], self.data["EY"]
end

function Anim3D:__Refresh ( x, y, z, endx, endy, endz, easing, time )
	if ( x ) then
		self.data["X"] = x
		self.data["Y"] = Y
		self.data["Z"] = z
		self.data["EndX"] = endx
		self.data["EndY"] = endy
		self.data["EndZ"] = endz
		self.data["Easing"] = easing
		self.data["Time"] = time
	end
	self.data["S_Time"] = getTickCount()
	self.data["E_Time"] = self.data["Time"] + self.data["S_Time"]
end

function Anim3D:__Destroy() 
	if ( not self ) then return false end
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	self = nil
end

Class:__Get("Lib","DX"):__Add ( "Anim3D", Anim3D )