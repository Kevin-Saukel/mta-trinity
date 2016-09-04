--*****************************--
--***** © by Kevin Saukel *****--
--******** 02.08.2016 *********--
--*****************************--

local Register = {}

function Register:__onElement ( element, username, password )
	if ( element and password ) then
		local _Element = {}
		_Element["Mysql"] = Class:__Get("Lib","Mysql")
		_Element["Accounttable"] = {}
		element:__Set("Username",username)
		for index, database in pairs(Class:__getConfig("System","Mysql")["Databases"]) do
			_Element["Accounttable"][index] = {}
			if ( database["Tables"] ) then
				for i, tbl in pairs(database["Tables"]) do 
					_Element["Accounttable"][index]["Values"] = {}
					_Element["Accounttable"][index]["Values"][1] = {}
					_Element["Accounttable"][index]["Values"][2] = {}
					_Element["Accounttable"][index]["Whole"] = {}
					if ( database["Datastrings"][tbl] ) then
						for k, v in pairs ( database["Datastrings"][tbl] ) do 
							if ( v ~= database["Standards"][tbl][k] ) then
								_Element["Accounttable"][index]["Values"][1][#_Element["Accounttable"][index]["Values"][1]+1] = v
								_Element["Accounttable"][index]["Values"][2][#_Element["Accounttable"][index]["Values"][2]+1] = database["Standards"][tbl][k]
								element:__Set(v, database["Standards"][tbl][k])
							else
								_Element["Accounttable"][index]["Values"][1][#_Element["Accounttable"][index]["Values"][1]+1] = v
								if ( v ~= "Password") then
									_Element["Accounttable"][index]["Values"][2][#_Element["Accounttable"][index]["Values"][2]+1] = Class:__Get("Lib","Methodloader"):__Execute(
									"return function(parameter) return Class:__Get('Lib','R_Method'):get"..tostring(v).."(parameter) end",element)
								else
									_Element["Accounttable"][index]["Values"][2][#_Element["Accounttable"][index]["Values"][2]+1] = Class:__Get("Lib","Methodloader"):__Execute(
									"return function(parameter) return Class:__Get('Lib','R_Method'):get"..tostring(v).."(parameter) end",password)
								end
								element:__Set(v, _Element["Accounttable"][index]["Values"][2][#_Element["Accounttable"][index]["Values"][2]], database["Name"])
							end
						end
						_Element["Accounttable"][index]["Whole"] = table.con(_Element["Accounttable"][index]["Values"][1],_Element["Accounttable"][index]["Values"][2])
						_Element["Mysql"]:__Insert( database["Name"] , tbl, 
								unpack(_Element["Accounttable"][index]["Whole"]) )
					end
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
	return false
end

Class:__New("Lib","Register",Register)
