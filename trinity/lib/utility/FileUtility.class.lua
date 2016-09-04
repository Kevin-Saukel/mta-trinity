--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local FileUtility = {}

function FileUtility:__New ( path, text ) 
	local _New = {}
	if ( not self:__Exists(path) ) then
		_New["FileHandle"] = fileCreate(path)
		if ( _New["FileHandle"] ) then
			fileWrite(_New["FileHandle"],text)
			fileClose(_New["FileHandle"])
			_New = nil
			return true
		end
	end
	_New = nil
	return false
end

function FileUtility:__Write ( path, text )
	local _Write = {}
	if ( self:__Exists(path) ) then
		_Write["FileHandle"] = fileOpen(path)
		if ( _Write["FileHandle"] ) then
			fileSetPos(_Write["FileHandle"],_Write["FileHandle"]:getSize())
			fileWrite(_Write["FileHandle"],text)
			fileClose(_Write["FileHandle"])
			_Write = nil
			return true
		end
	end
	_Write = nil
	return false
end

function FileUtility:__Read ( path )
	local _Read = {}
	if ( self:__Exists(path) ) then
		_Read["FileHandle"] = fileOpen(path)
		if ( _Read["FileHandle"] ) then
			_Read["Text"] = fileRead(_Read["FileHandle"],_Read["FileHandle"]:getSize()) 
			fileClose(_Read["FileHandle"])
			return _Read["Text"]
		end
	end
	_Read = nil
	return false
end

function FileUtility:__Rewrite ( path, text )
	local _Rewrite = {}
	if ( self:__Exists(path) ) then
		fileDelete(path)
		_Rewrite["FileHandle"] = fileCreate(path)
		if ( _Rewrite["FileHandle"] ) then
			fileWrite(_Rewrite["FileHandle"],text)
			fileClose(_Rewrite["FileHandle"])
			_Rewrite = nil
			return true
		end
	end
	_Rewrite = nil
	return false
end

function FileUtility:__Copy ( path, copypath )
	local _Copy = {}
	if ( self:__Exists(path) ) then
		_Copy["FileHandle"] = fileOpen(path)
		if ( _Copy["FileHandle"] ) then
			fileCopy(_Copy["FileHandle"],copypath)
			fileClose(_Copy["FileHandle"])
			_Copy = nil
			return true
		end
	end
	_Copy = nil
	return false
end

function FileUtility:__Delete ( path )
	local _Delete = {}
	if ( self:__Exists(path) ) then	
		fileDelete(path)
		_Delete = nil
		return true
	end
	_Delete = nil
	return false
end

function FileUtility:__Encrypt ( path, key )
	local _Encrypt = {}
	if ( self:__Exists(path) ) then
		_Encrypt["FileHandle"] = fileOpen(path)
		if ( _Encrypt["FileHandle"] ) then
			_Encrypt["Buffer"] = fileRead(_Encrypt["FileHandle"],_Encrypt["FileHandle"]:getSize())
			_Encrypt["Buffer"] = Class:__Get("Lib","EncodingUtility"):__Encrypt(_Encrypt["Buffer"],key)
			fileClose(_Encrypt["FileHandle"])
			self:__Rewrite(path,_Encrypt["Buffer"])
			_Encrypt = nil
			return true
		end
	end
	_Encrypt = nil
	return false
end

function FileUtility:__Decrypt ( path, key )
	local _Decrypt = {}
	if ( self:__Exists(path) ) then
		_Decrypt["FileHandle"] = fileOpen(path)
		if ( _Decrypt["FileHandle"] ) then
			_Decrypt["Buffer"] = fileRead(_Decrypt["FileHandle"],_Decrypt["FileHandle"]:getSize())
			_Decrypt["Buffer"] = Class:__Get("Lib","EncodingUtility"):__Decrypt(_Decrypt["Buffer"],key)
			fileClose(_Decrypt["FileHandle"])
			self:__Rewrite(path,_Decrypt["Buffer"])
			_Decrypt = nil
			return true
		end
	end
	_Decrypt = nil
	return false
end

function FileUtility:__getSize ( path )
	local _getSize = {}
	if ( self:__Exists(path) ) then
		_getSize["FileHandle"] = fileOpen(path)
		if ( _getSize["FileHandle"] ) then
			_getSize["Size"] = fileGetSize(_getSize["FileHandle"])
			fileClose(_getSize["FileHandle"])
			return _getSize["Size"]
		end
	end
	return nil
end

function FileUtility:__Exists ( path )
	if ( fileExists(path) ) then
		return true
	end
	return nil
end

Class:__New("Lib","FileUtility",FileUtility)
