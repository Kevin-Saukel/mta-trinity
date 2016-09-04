--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 02.08.2016 *********--
--*****************************--

local Login = {}

function Login:__onElement ( element, username, password )
	if ( element and password ) then
		local _Element = {}
		_Element["Mysql"] = Class:__Get("Lib","Mysql")
		_Element["EncodingUtility"] = Class:__Get("Lib","EncodingUtility")
		_Element["Password"] = _Element["EncodingUtility"]:__MD5(password)
		_Element["Serial"] = element:getSerial()
		_Element["Datatable"] = Class:__getConfig("System","Mysql")["Databases"]["Multigamemode"]
		_Element["Accounttable"] = {}
		_Element["Accounttable"][1] = _Element["Mysql"]:__getTable( "Multigamemode", _Element["Datatable"]["Tables"][1], "WHERE", "Username", username )
		_Element["PValid"] = false
		_Element["AValid"] = false
		if ( _Element["Password"] == _Element["Accounttable"][1]["Password"] ) then
			_Element["PValid"] = true
		end
		if ( tonumber(_Element["Accounttable"][1]["Autologin"]) == 1 ) then
			if ( _Element["Serial"] == _Element["Accounttable"][1]["Serial"] ) then
				_Element["AValid"] = true
			end
		end
		if ( _Element["AValid"] or _Element["PValid"] ) then
			_Element["EncodingUtility"] = nil
			_Element["Password"] = nil
			_Element["Serial"] = nil
			_Element["Datatable"] = nil
			_Element["PValid"] = nil
			_Element["AValid"] = nil
			_Element["Accounttable"] = {}
			for index, database in pairs(Class:__getConfig("System","Mysql")["Databases"]) do 
				_Element["Accounttable"][index] = {}
				for i, table in pairs(database["Tables"]) do 
					_Element["Accounttable"][index][i] = _Element["Mysql"]:__getTable( database["Name"] , table, "WHERE", "Username", username )
					for k, v in pairs ( _Element["Accounttable"][index][i] ) do 
						element:__Set( k, v, table["Name"] )
					end	
				end
			end
			for i, strtable in pairs(Class:__getConfig("System","Data")["ElementData"]["Datastrings"]) do 
				for k, v in pairs( strtable ) do 
					element:__Set( Class:__getConfig("System","Data")["ElementData"]["Datastrings"][i][k], Class:__getConfig("System","Data")["ElementData"]["Standards"][i][k] )
				end
			end
			return true
		end
	end
	return false
end

Class:__New("Lib","Login",Login)


