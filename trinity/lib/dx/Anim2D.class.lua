--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Anim2D = {}

function Anim2D:__New ( x, y, endx, endy, easing, time, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["EndX"], self.data["EndY"] = x, y, endx, endy
	self.data["Easing"] = easing
	self.data["Time"] = time
	--*******************************************************************************************************************************--
	self.data["S_Time"] = getTickCount()
	self.data["E_Time"] = self.data["S_Time"] + self.data["Time"]
	--*******************************************************************************************************************************--
	return self
end

function Anim2D:__getElement()
	return self.data["Element"]
end

function Anim2D:__getPosition()
	self.data["Now"] = getTickCount()
	self.data["Progress"] = ( self.data["Now"] - self.data["S_Time"] ) / (self.data["E_Time"] - self.data["S_Time"])
	self.data["EX"], self.data["EY"] = interpolateBetween(
		self.data["X"], self.data["Y"], 0,
		self.data["EndX"], self.data["EndY"], 0,
		self.data["Progress"], self.data["Easing"]
	)
	return self.data["EX"], self.data["EY"]
end

function Anim2D:__Refresh ( x, y, endx, endy, easing, time, gpx, gpy )
	if ( x ) then
		self.data["X"], self.data["Y"], self.data["EndX"], self.data["EndY"] = x, y, endx, endy
		self.data["Easing"] = easing
		self.data["Time"] = time
	end
	self.data["S_Time"] = getTickCount()
	self.data["E_Time"] = self.data["S_Time"] + self.data["Time"]
end

function Anim2D:__Destroy ()
	if ( not self ) then return false end
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	self = nil
end

Class:__Get("Lib","DX"):__Add ( "Anim2D", Anim2D )

