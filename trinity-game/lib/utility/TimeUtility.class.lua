--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local TimeUtility = {}

function TimeUtility:__Constructor ()
	--**************************************************************************************************************************--
	self.data = {}
	self.data["S_Tickcount"] = getTickCount()
	self.data["C_Tickcount"] = getTickCount()
	--**************************************************************************************************************************--
end

function TimeUtility:__getTimestamp ()
	local _getTimestamp = {}
	_getTimestamp["Realtime"] = getRealTime()
	_getTimestamp["Realtime_Year"] = _getTimestamp["Realtime"].year+1900
	_getTimestamp["Realtime_Minute"] = _getTimestamp["Realtime"].minute
	if ( _getTimestamp["Realtime_Minute"] < 10 ) then
		_getTimestamp["Realtime_Minute"] = "0".._getTimestamp["Realtime_Minute"]
	end
	return _getTimestamp["Realtime"].monthday.."."..(_getTimestamp["Realtime"].month+1)..".".._getTimestamp["Realtime_Year"].." ".._getTimestamp["Realtime"].hour..":".._getTimestamp["Realtime_Minute"]
end

function TimeUtility:__getDaytime()
	local _getDaytime = {}
	_getDaytime["Realtime"] = getRealTime()
	_getDaytime["Realtime_Minute"] = _getDaytime["Realtime"].minute
	if ( _getDaytime["Realtime_Minute"] < 10 ) then
		_getDaytime["Realtime_Minute"] = "0".._getDaytime["Realtime_Minute"]
	end
	return _getDaytime["Realtime"].hour..":".._getDaytime["Realtime_Minute"]
end

function TimeUtility:__getDate ()
	local _getDate = {}
	_getDate["Realtime"] = getRealTime()
	_getDate["Realtime_Year"] = _getDate["Realtime"].year+1900
	return _getDate["Realtime"].monthday..".".._getDate["Realtime"].month..".".._getDate["Realtime_Year"]
end

function TimeUtility:__getSystemUpTime( format )
	local _gSUT = {}
	_gSUT["N_Tickcount"] = getTickCount ()
	_gSUT["SystemUpTime"] = _gSUT["N_Tickcount"] - self.data["S_Tickcount"]
	_gSUT["SystemUpTime"] = math.floor(_gSUT["SystemUpTime"]/1000)
	if ( format == "seconds" ) then
		return _gSUT["SystemUpTime"]
	elseif ( format == "minutes" ) then
		_gSUT["Realtime_Minute"] = math.floor(_gSUT["SystemUpTime"]/60)
		_gSUT["Realtime_Second"] = _gSUT["SystemUpTime"]-(math.floor(_gSUT["SystemUpTime"]/60)*60)
		if ( _gSUT["Realtime_Second"] < 10 ) then
			_gSUT["Realtime_Second"] = "0".._gSUT["Realtime_Second"]
		end
		if ( _gSUT["Realtime_Minute"] < 10 ) then
			_gSUT["Realtime_Minute"] = "0".._gSUT["Realtime_Minute"]
		end
		return _gSUT["Realtime_Minute"]..":".._gSUT["Realtime_Second"]
	elseif ( format == "hours" ) then
		_gSUT["Realtime_Hour"] = math.floor((_gSUT["SystemUpTime"]/60)/24)
		_gSUT["Realtime_Minute"] = _gSUT["Realtime_Minute"] - (math.floor(_gSUT["SystemUpTime"]/60)*60)
		_gSUT["Realtime_Second"] = _gSUT["SystemUpTime"]-(math.floor(_gSUT["SystemUpTime"]/60)*60)
		if ( _gSUT["Realtime_Hour"] < 10 ) then
			_gSUT["Realtime_Hour"] = "0".._gSUT["Realtime_Hour"]
		end
		if ( _gSUT["Realtime_Second"] < 10 ) then
			_gSUT["Realtime_Second"] = "0".._gSUT["Realtime_Second"]
		end
		if ( _gSUT["Realtime_Minute"] < 10 ) then
			_gSUT["Realtime_Minute"] = "0".._gSUT["Realtime_Minute"]
		end
		return _gSUT["Realtime_Hour"]..":".._gSUT["Realtime_Minute"]..":".._gSUT["Realtime_Second"]
	end
end

Class:__New("Lib","TimeUtility",TimeUtility)
