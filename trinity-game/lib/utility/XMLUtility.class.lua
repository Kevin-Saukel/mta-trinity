--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local XMLUtility = {}

function XMLUtility:__Exists ( xmlfilepath ) 
	if ( Class:__Get("Lib","FileUtility"):__Exists( xmlfilepath ) ) then
		return true
	end	
	return false
end

function XMLUtility:__findChild ( xmlfilepath, child )
	if ( self:__Exists(xmlfilepath) ) then
		local _findChild = {}
		_findChild["Node"] = xmlLoadFile(xmlfilepath)
		if ( _findChild["Node"] ) then
			_findChild["Children"] = _findChild["Node"]:getChildren()
			for k, v in pairs(_findChild["Children"]) do 
				if ( v:getName() == child ) then
					_findChild["Node"] = v
					break
				end
			end
			return _findChild["Node"]
		end
	end
	return nil
end

function XMLUtility:__findChildren ( xmlfilepath, child ) 
	if ( self:__Exists( xmlfilepath ) ) then
		local _findChildren = {}
		_findChildren["Node"] = xmlLoadFile(xmlfilepath)
		if ( _findChildren["Node"] ) then
			_findChildren["Children"] = _findChildren["Node"]:getChildren()
			_findChildren["NewChildren"] = {}
			for k, v in pairs(_findChildren["Children"]) do 
				if ( v:getName() == child ) then
					_findChildren["NewChildren"][#_findChildren["NewChildren"]+1] = v
				end
			end
			return _findChildren["NewChildren"]
		end
	end
	return nil
end

function XMLUtility:__getChildren ( xmlnode, child )
	if ( xmlnode ) then
		local _getChildren = {}
		_getChildren["Node"] = xmlnode
		if ( _getChildren["Node"] ) then
			_getChildren["Children"] = _getChildren["Node"]:getChildren()
			_getChildren["NewChildren"] = {}
			for k, v in pairs(_getChildren["Children"]) do 
				if ( v:getName() == child ) then
					_getChildren["NewChildren"][#_getChildren["NewChildren"]+1] = v
				end
			end
			return _getChildren["NewChildren"]
		end
	end
	return nil
end

function XMLUtility:__getChildrenAttributes ( xmlfilepath, child, string, ... )
	if ( self:__Exists(xmlfilepath) ) then
		local _gCA = {}
		_gCA["Node"] = xmlLoadFile(xmlfilepath)
		if ( _gCA["Node"] ) then
			_gCA["Parameters"] = {...}
			_gCA["Children"] = _gCA["Node"]:getChildren()
			_gCA["Valid_Childs"] = {}
			_gCA["Attributes"] = {}
			for i, node in pairs(_gCA["Children"]) do 
				if ( node:getName() == child ) then
					_gCA["Valid_Childs"][#_gCA["Valid_Childs"]+1] = node
					_gCA["Attributes"][#_gCA["Attributes"]+1] = node:getAttribute(string)
				end
			end
			_gCA["New_Valid_Childs"] = {}
			if ( #_gCA["Parameters"] >= 1 ) then
				_gCA["Attributes"] = {}
				for k, node in pairs(_gCA["Valid_Childs"]) do 
					if ( node:getAttribute("type") == _gCA["Parameters"][1] ) then
						_gCA["Attributes"][#_gCA["Attributes"]+1] = node:getAttribute(string)
					end
				end
				_gCA["Node"]:unload()
				return _gCA["Attributes"]
			end
			_gCA["Node"]:unload()
			return _gCA["Attributes"]
		end
	end
	return nil
end

Class:__New("Lib","XMLUtility",XMLUtility)
