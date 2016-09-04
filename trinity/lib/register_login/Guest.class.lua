--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 02.08.2016 *********--
--*****************************--

local Guest = {}

function Guest:__onElement ( element )
	if ( isElement(element) ) then
		for i, strtable in pairs(Class:__getConfig("System","Data")["ElementData"]["Datastrings"]) do 
			for k, v in pairs( strtable ) do 
				element:__Set( Class:__getConfig("System","Data")["ElementData"]["Datastrings"][i][k], Class:__getConfig("System","Data")["ElementData"]["Standards"][i][k] )
			end
		end
		element:__Set("Guest",true)
		return true
	end
	return false
end

Class:__New("Lib","Guest",Guest)