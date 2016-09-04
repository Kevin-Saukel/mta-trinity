--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Resource = {}

function Resource:__Constructor ()
	self.resources = {}
end

function Resource:__Add ( resourcename )
	if ( resourcename ) then
		if ( not self.resources[resourcename] ) then
			if ( getResourceFromName(resourcename) ) then
				self.resources[resourcename] = getResourceFromName(resourcename)
				self:__Run ( resourcename )
			end
		end
	end
end

function Resource:__Run ( resourcename )
	if ( resourcename ) then
		if ( self.resources[resourcename] ) then
			if ( self.resources[resourcename]:getState() == "loaded" ) then
				self.resources[resourcename]:start()
			end
		end
	end
end

function Resource:__Destroy ( resourcename )
	if ( resourcename ) then
		if ( self.resources[resourcename] ) then
			if ( getResourceFromName(resourcename) ) then
				self.resources[resourcename]:stop()
				self.resources[resourcename] = nil
			end
		end
	end
end

--************************************************************************************************************************************************--

function Resource:__getSetting ( resourcename, settingname )
	if ( resourcename ) then
		if ( getResourceFromName(resourcename) ) then
			local _getSetting = {}
			_getSetting["Node"] = nil
			_getSetting["Child"] = Class:__Get("Lib","XMLUtility"):__findChild(":"..resourcename.."/meta.xml","settings")
			_getSetting["Children"] = Class:__Get("Lib","XMLUtility"):__getChildren(_getSetting["Child"],"setting")
			for k, v in pairs(_getSetting["Children"]) do 
				if ( v:getAttribute("name") == settingname ) then
					_getSetting["Node"] = v
					break
				end
			end
			return _getSetting["Node"]
		end
	end
	return nil
end

function Resource:__getResourcesInDirectory ( directory )
	if ( directory ) then
		local _getResourcesInDirectory = { } 
		_getResourcesInDirectory[1] = getResources()
		_getResourcesInDirectory[2] = {}
		for i, resource in pairs(_getResourcesInDirectory[1]) do 
			if ( resource:getInfo("dir") == directory ) then
				_getResourcesInDirectory[2][#_getResourcesInDirectory[2]+1] = resource
			end
		end
		return _getResourcesInDirectory[2]
	end
	return false
end

function Resource:__getResourcesFromInitial ( initial )
	if ( initial ) then
		local _getResourceFromInitial = {}
		_getResourceFromInitial[1] = getResources()
		_getResourceFromInitial[2] = {}
		for i, resource in pairs(_getResourceFromInitial[1]) do 
			if ( resource:getName():find(initial) ) then
				_getResourceFromInitial[2][#_getResourceFromInitial[2]+1] = resource
			end
		end
		return _getResourceFromInitial[2]
	end
	return false
end

Class:__New("Lib","Resource",Resource)
