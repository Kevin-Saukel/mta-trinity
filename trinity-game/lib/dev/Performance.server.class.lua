--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Performance = {}

function Performance:__getMysqlTime ( con, table )
	local _gMT = {}
	_gMT["Now"] = getTickCount()
	_gMT["Callback"] = Class:__Get("Lib","Mysql"):__getTable(con,table)
	if ( _gMT["Callback"] ) then
		_gMT["Progress"] = getTickCount() - _gMT["Now"]
		return _gMT["Progress"]
	end
	return false
end

Class:__New("Lib","Performance",Performance)
