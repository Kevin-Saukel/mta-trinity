--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Data = {}

function Data:__Constructor ()
	self.user = {}
	--************************************************************************************************************************************************--
	self.method = {}
	self.method["Save"] = function ( element, cmd ) self:__Save( element, cmd ) end
	self.method["OnResource"] = function ( resource ) self:__onResource ( resource ) end
	self.method["OnQuit"] = function ( ) self:__Save ( source ) end
	--************************************************************************************************************************************************--
	addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), self.method["OnResource"])
	addEventHandler("onResourcePreStart",getResourceRootElement(getThisResource()), self.method["OnResource"])
	addEventHandler("onPlayerQuit",getRootElement(),self.method["OnQuit"])
end

function Data:__Set ( element, datastring, value, gamemode )
	if ( not self.user[element] ) then
		self.user[element] = {}
	end
	if ( element and datastring ) then
		if ( gamemode and gamemode ~= "Multigamemode" ) then
			self.user[element][gamemode.."."..datastring] = value
		else
			self.user[element][datastring] = value
		end
		return true
	end
	return false
end

function Data:__Get ( element, datastring )
	if ( not self.user[element] ) then
		return nil
	end
	if ( datastring ) then
		return self.user[element][datastring]
	end
	return nil
end

function Data:__Save ( element )
	if ( not isElement(element) ) then return false end
	--[[local _Save = {}
	_Save["Gamemodes"] = Config:__Get("Mysql"):__Get()
	_Save["Mysql"] = Server:__Get("Lib"):__Get("Mysql")
	if ( element:__Get("Logged") ) then
		if ( not element:__Get("Guest") ) then
			for index, database in pairs(_Save["Gamemodes"]) do 
				if ( database["Databases"] ) then
					for i, tbl in pairs(database["Databases"]) do 
						_Save["Savetable"] = {}
						if ( database["Datastrings"][tbl] ) then
							for k, v in pairs(database["Datastrings"][tbl]) do 
								if ( v == database["Manual"][tbl][k] ) then
									_Save["Savetable"][#_Save["Savetable"]+1] = v
									_Save["Savetable"][#_Save["Savetable"]+1] = Server:__Get("Lib"):__Get("Methodloader"):__Execute ( v, element )
								else
									_Save["Savetable"][#_Save["Savetable"]+1] = v
									if ( database["Name"] ~= "Multigamemode" ) then
										_Save["Savetable"][#_Save["Savetable"]+1] = element:__Get(database["Name"].."."..v)
									else
										_Save["Savetable"][#_Save["Savetable"]+1] = element:__Get(v)
									end
								end
							end
							_Save["Savetable"][#_Save["Savetable"]+1] = tostring(element:__Get("Username"))
							_Save["Mysql"]:__setTable(database["Name"],tbl,"WHERE Username = ?",unpack(_Save["Savetable"]))
						end
					end
				end
			end
			return true
		end
	end]]
	return false
end

function Data:__onResource ( resource )
	if ( resource == getThisResource() ) then
		for i, pi in pairs(getElementsByType("player")) do 
			if ( pi:__Get("Logged") == true ) then
				self.method["Save"](pi)
			end
		end
	end
end

Class:__New("Lib","Data",Data)

