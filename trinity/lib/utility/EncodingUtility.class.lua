--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local EncodingUtility = {}

function EncodingUtility:__GenerateSalt ( len )
	local _GenerateSalt = {}
	
	if ( len ) then
		_GenerateSalt["Salt"] = ""
		for i = 1, len do 
			_GenerateSalt["Salt"] = _GenerateSalt["Salt"]..string.char(math.random(1,128))
		end
		return _GenerateSalt["Salt"]
	end
	return nil
end

function EncodingUtility:__MD5 ( string )
	if ( string ) then
		return md5(string)
	end
end

function EncodingUtility:__Encrypt ( string, key )
	if ( string and key ) then
		_Encrypt = {}
		_Encrypt["String"] = teaEncode(string,key)
		return _Encrypt["String"]
	end
end

function EncodingUtility:__Decrypt ( string, key ) 
	local _Decrypt = {}
	if ( string and key ) then
		_Decrypt["String"] = teaDecode(string,key)
		return _Decrypt["String"]
	end
end

Class:__New("Lib","EncodingUtility",EncodingUtility)
