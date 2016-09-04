--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local StringUtility = {}

function StringUtility:__getRandomString ( len )
	local _getRandomString = {}
	_getRandomString["String"] = ""
	if ( len >= 1 ) then
		for i = 1, len do 
			_getRandomString["String"] = _getRandomString["String"]..string.char(math.random(48,122))
		end
		return _getRandomString["String"]
	end
	return ""
end

function StringUtility:__Concat ( table, char )
	local _Concat = {}
	_Concat["Counter"] = 1
	_Concat["String"] = ""
	if ( not char ) then
		char = ""
	end 
	for i, str in pairs(table) do 
		if ( _Concat["Counter"] == #table ) then
			_Concat["String"] = string.format(_Concat["String"].."%s",str)
			break
		end
		_Concat["String"] = string.format(_Concat["String"].."%s%s",str,char)
		_Concat["Counter"] = _Concat["Counter"] + 1
	end
	return _Concat["String"]
end

function StringUtility:__Multiply ( str, amount, char )
	local _Multiply = {}
	_Multiply["String"] = ""
	if ( not char ) then
		char = ""
	end
	for i = 1, amount do 
		if ( i == amount ) then
			_Multiply["String"] = string.format(_Multiply["String"].."%s",str)
			break
		end
		_Multiply["String"] = string.format(_Multiply["String"].."%s%s",str,char)
	end
	return _Multiply["String"]
end

Class:__New("Lib","StringUtility",StringUtility)