--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

--// return function(parameter) return Class:__Get('Lib','R_Methods'):get"..methodname.."(parameter) end \\--

local Methodloader = {}

function Methodloader:__Execute ( methodname, ... )
	if ( methodname ) then
		return loadstring(methodname)()(...)
	end
end

Class:__New("Lib","Methodloader",Methodloader)




