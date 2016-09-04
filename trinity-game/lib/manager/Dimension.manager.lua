--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Dimension = {}

function Dimension:__Constructor ( )
	self.data = {}
	self.data["Dimension"] = {}
	self.data["Dimension"]["Minimum"] = 5000
	self.data["Dimension"]["Maximum"] = 10000
	self.data["Dimension"]["Avaible"] = {}
	--************************************************************************************************************************************************--
	for i = self.data["Dimension"]["Minimum"], self.data["Dimension"]["Maximum"] do 
		self.data["Dimension"]["Avaible"][i] = false
	end
end

function Dimension:__setDimension ( dim, state )
	if ( dim ) then
		if ( tonumber(dim) >= self.data["Dimension"]["Minimum"] and tonumber(dim) <= self.data["Dimension"]["Maximum"] ) then
			self.data["Dimension"]["Avaible"][tonumber(dim)] = state
		end
	end
end

function Dimension:__getFreeDimension ( )
	for k, v in pairs(self.data["Dimension"]["Avaible"]) do 
		if ( not v ) then
			return k
		end
	end
end

Class:__New("Lib","Dimension",Dimension)