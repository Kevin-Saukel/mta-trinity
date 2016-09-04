--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Mysql = {}

function Mysql:__Constructor()
	self.data = {}
	self.connection = {}
end

function Mysql:__addConnection ( field, type, host, username, password, options )
	if ( not self.connection[field] and not self.data[field] ) then
		self.data[field] = {}
		self.data[field]["Type"] = type
		self.data[field]["Host"] = host
		self.data[field]["Username"] = username
		self.data[field]["Password"] = password
		self.data[field]["Options"] = options
		self.connection[field] = Connection( self.data[field]["Type"], self.data[field]["Host"], self.data[field]["Username"], self.data[field]["Password"], self.data[field]["Options"])
		if ( self.connection[field] ) then
			return true
		end
	end
	return false
end

function Mysql:__getConnection ( field )
	if ( self.connection ) then
		if ( self.connection[field] ) then
			return self.connection[field]
		end
	end
end

function Mysql:__getTable ( connection, table, condition, ... )
	local _getTable = {}
	if ( connection and table ) then
		_getTable["Args"] = {...}
		_getTable["Query"] = "SELECT * FROM `??`"
		if ( #_getTable["Args"] >= 1 ) then
			_getTable["Parameters"] = Class:__Get("Lib","StringUtility"):__Multiply("`??` = ?", (#_getTable["Args"]/2), " AND ")
			_getTable["Query"] = string.format(_getTable["Query"].." %s %s", condition,_getTable["Parameters"] )
		end
		_getTable["Sql"] = Class:__Get("Lib","Mysql"):__getConnection(connection):query(_getTable["Query"],table,unpack(_getTable["Args"]) )
		_getTable["Callback"] = {}
		_getTable["Callback"][1], _getTable["Callback"][2], _getTable["Callback"][3] = _getTable["Sql"]:poll(-1)
		if ( _getTable["Callback"][1] and _getTable["Callback"][2] ) then
			--Server:__Output()
			return _getTable["Callback"][1][1], _getTable["Callback"][2], _getTable["Callback"][3], _getTable["Callback"][1]
		else
			--Server:__Output()
			return _getTable["Callback"][1], 0, _getTable["Callback"][3]
		end
	end
	return nil, nil, nil
end

function Mysql:__setTable ( connection, table, condition, ... )
	local _setTable = {}
	if ( connection and table ) then
		_setTable["Args"] = {...}
		_setTable["Query"] = "UPDATE `??` SET "
		if ( #_setTable["Args"] >= 1 ) then
			_setTable["Parameters"] = Class:__Get("Lib","StringUtility"):__Multiply("`??` = ?", ((#_setTable["Args"]-1)/2), ", ")
			_setTable["Query"] = string.format(_setTable["Query"].."%s %s", _setTable["Parameters"], condition )
		end
		_setTable["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_setTable["Query"],table,unpack(_setTable["Args"]))
		if ( _setTable["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end
	return false
end

function Mysql:__Get ( connection, table, field, condition, ... )
	local _Get = {}
	if ( connection and table and field ) then
		_Get["Args"] = {...}
		_Get["Query"] = "SELECT * FROM `??`"
		if ( #_Get["Args"] >= 1 ) then
			_Get["Parameters"] = Class:__Get("Lib","StringUtility"):__Multiply("`??` = ?", (#_Get["Args"]/2), " AND ")
			_Get["Query"] = string.format(_Get["Query"].." %s %s", condition,_Get["Parameters"] )
		end
		_Get["Sql"] = Class:__Get("Lib","Mysql"):__getConnection(connection):query(_Get["Query"],table,unpack(_Get["Args"]))
		_Get["Callback"] = {}
		_Get["Callback"][1], _Get["Callback"][2], _Get["Callback"][3] = _Get["Sql"]:poll(-1)
		if ( _Get["Callback"][1] and _Get["Callback"][2] >= 1 ) then
			--Server:__Output()
			return _Get["Callback"][1][1][field], _Get["Callback"][2], _Get["Callback"][3]
		else
			--Server:__Output()
			return _Get["Callback"][1], _Get["Callback"][2], _Get["Callback"][3]
		end
	end
	return nil,nil,nil
end

function Mysql:__Set ( connection, table, field, value, condition, ... )
	local _Set = {}
	if ( connection and table and field ) then
		_Set["Args"] = {...}
		_Set["Query"] = "UPDATE `??` SET "
		if ( #_Set["Args"] >= 1 ) then
			_Set["Parameters"] = Class:__Get("Lib","StringUtility"):__Multiply("`??` = ?", (#_Set["Args"]/2), " AND ")
			_Set["Query"] = string.format(_Set["Query"].."%s %s", condition,_Set["Parameters"] )
		end
		_Set["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_Set["Query"],table,field,value,unpack(_Set["Args"]))
		if ( _Set["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end
	return false
end 

function Mysql:__Insert ( connection, table, ... ) 
	local _Insert = {}
	if ( connection and table ) then
		_Insert["Args"] = {...}
		_Insert["Query"] = "INSERT INTO `??`"
		if ( #_Insert["Args"] >= 1 ) then
			_Insert["Parameters"] = {}
			_Insert["Parameters"][1] = Class:__Get("Lib","StringUtility"):__Multiply("`??`",(#_Insert["Args"]/2),",")
			_Insert["Parameters"][2] = Class:__Get("Lib","StringUtility"):__Multiply("?",(#_Insert["Args"]/2),",")
			_Insert["Query"] = string.format(_Insert["Query"].." (%s) VALUES (%s)",_Insert["Parameters"][1],_Insert["Parameters"][2])
		end
		_Insert["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_Insert["Query"],table,unpack(_Insert["Args"]))
		if ( _Insert["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end
	return false
end

function Mysql:__Delete ( connection, table, condition, ... )
	local _Delete = {}
	if ( connection and table ) then
		_Delete["Args"] = {...}
		_Delete["Query"] = "DELETE FROM `??`"
		if ( #_Delete["Args"] >= 1 ) then
			_Delete["Parameters"] = Class:__Get("Lib","StringUtility"):__Multiply("`??`=?",(#_Delete["Args"]/2), " AND ")
			_Delete["Query"] = string.format(_Delete["Query"].." %s %s",condition,_Delete["Parameters"])
		end
		_Delete["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_Delete["Query"],table,unpack(_Delete["Args"]))
		if ( _Delete["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end	
	return false
end

function Mysql:__createTable ( connection, table, ... ) 
	local _createTable = {}
	if ( connection and table ) then
		_createTable["Args"] = {...}
		_createTable["Query"] = "CREATE TABLE IF NOT EXISTS '"..table.."'"
		_createTable["Parameters"] = Class:__Get("Lib","StringUtility"):__Concat(_createTable["Args"],",")
		_createTable["Query"] = string.format(_createTable["Query"].." ( %s )",_createTable["Parameters"])
		_createTable["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_createTable["Query"])
		if ( _createTable["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end
	return false
end

function Mysql:__deleteTable ( connection, table )
	local _deleteTable = {}
	if ( connection and table ) then
		_deleteTable["Query"] = "DROP TABLE '"..table.."'"
		_deleteTable["Exec"] = Class:__Get("Lib","Mysql"):__getConnection(connection):exec(_deleteTable["Query"])
		if ( _deleteTable["Exec"] ) then
			--Server:__Output()
			return true
		else
			--Server:__Output()
			return false
		end
	end
	return false
end

Class:__New("Lib","Mysql",Mysql)

