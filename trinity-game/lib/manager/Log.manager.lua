--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 04.09.2016 *********--
--*****************************--

local Log = {}

function Log:__Create ( logname )
	if ( logname ) then
		local logpath = Class:__getConfig("System","Server")["Logpath"]
		local timestamp = Class:__Get("Lib","TimeUtility"):__getTimestamp()
		if ( Class:__Get("Lib","FileUtility"):__New(logpath..logname..".log","["..timestamp.."] Setup of new logfile by System: Sucessfull!\n") ) then
			self:__Write("File","Created new logfile: '"..logpath..logname..".log'")
			return true
		else
			self:__Write("File","Creation failed of new logfile: '"..logpath..logname..".log'")
			return false
		end
	end
end

function Log:__Write ( logname, text )
	if ( logname and #text >= 1 ) then
		local logpath = Class:__getConfig("System","Server")["Logpath"] 
		local timestamp = Class:__Get("Lib","TimeUtility"):__getTimestamp()
		if ( Class:__Get("Lib","FileUtility"):__Write(logpath..logname..".log","["..timestamp.."] "..text.."\n") ) then
			return true
		else
			if ( not logname == "File" ) then
				self:__Write("File","Unable to write to logfile: '"..logpath..logname..".log'")
			end
			return false
		end
	end
end

Class:__New("Lib","Log",Log)