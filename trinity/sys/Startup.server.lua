--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

local config = Class:__getConfig("System","Startup_S")

local function Startup ()
	for k, v in pairs(config["Constructors"]) do 
		if ( Class:__Get(v[1],v[2]) ) then
			Class:__Get(v[1],v[2]):__Constructor()
		end
	end
	--Server
	local server_config = Class:__getConfig("System","Server")
	setGameType(server_config["Gametype"])
	setMapName(server_config["Mapname"])
	setServerPassword(server_config["Password"])
	setFPSLimit(server_config["FPS_Limit"])
	setMaxPlayers(server_config["Max_Players"])
	--Lib
	local lib_config = Class:__getConfig("Lib","Lib")
	--Mysql
	local mysql_config = Class:__getConfig("System","Mysql")
	local cons = {}
	for k, v in ipairs(mysql_config["Connections"]) do 
		cons[k] = Class:__Get("Lib","Mysql"):__addConnection(v[1],v[2],v[3],v[4],v[5], v[6])
	end
	--Another
	local canceled_events = Class:__Get("Lib","Event"):__getCanceledEvents()
	local resource_config = Class:__getConfig("System","Resource")
	for k, v in pairs(resource_config["Start"]) do 
		Class:__Get("Lib","Resource"):__Add(v)
	end
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString("----------------------------Startup-Server-----------------------------")
	outputDebugString("-----------------------------------------------------------------------")	
	outputDebugString(" ")
	--[[ Server-Startup ]]--
	outputDebugString("------------------------------- Server --------------------------------")
	outputDebugString("Servername: "..server_config["Name"])
	outputDebugString("Gametype: "..server_config["Gametype"])
	outputDebugString("Mapname: "..server_config["Mapname"])
	outputDebugString("Serverpassword: "..server_config["Password"])
	outputDebugString("IP: "..server_config["IP"])
	outputDebugString("HTTP: "..server_config["HTTP"])
	outputDebugString("FPS Limit: "..server_config["FPS_Limit"])
	outputDebugString("Max Players: "..server_config["Max_Players"])
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString("MTA-Numerical Version: "..server_config["Version"].number)
	outputDebugString("MTA-Version: "..server_config["Version"].mta)
	outputDebugString("MTA-Name: "..server_config["Version"].name)
	outputDebugString("MTA-Netcode: "..server_config["Version"].netcode)
	outputDebugString("MTA-OS: "..server_config["Version"].os)
	outputDebugString("MTA-Type: "..server_config["Version"].type)
	outputDebugString("MTA-Tag: "..server_config["Version"].tag)
	outputDebugString("MTA-Sortable: "..server_config["Version"].sortable)
	outputDebugString("---------------------------- Server - End -----------------------------")
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString(" ")
	--[[ Libary-Startup ]]--
	outputDebugString("------------------------------- Libary --------------------------------")
	outputDebugString("Loading Libary: "..lib_config["Informations"]["Name"])
	outputDebugString("Author: "..lib_config["Informations"]["Author"])
	outputDebugString("Version: "..lib_config["Informations"]["Version"])
	outputDebugString("License: "..lib_config["Informations"]["License"])
	outputDebugString("Description: "..lib_config["Informations"]["Description"])
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString("Loaded Classes: "..Class:__getClassesInModul("Lib"))
	outputDebugString("Loaded Configs: "..Class:__getConfigsInModul("Lib"))
	outputDebugString("To see a full list of which Configs and Classes are loaded, take a look at the logs.")
	outputDebugString("---------------------------- Libary - End -----------------------------")
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString(" ")
	--[[ Mysql- Startup ]]--
	outputDebugString("------------------------------- Mysql --------------------------------")
	for k, v in ipairs(cons) do
		if ( cons[k] ) then
			outputDebugString("Connection with identifier "..mysql_config["Connections"][k][1]..": Sucessfull")
		else
			outputDebugString("Connection with identifier "..mysql_config["Connections"][k][1]..": Failed")
		end
	end
	outputDebugString("----------------------------- Mysql - End -----------------------------")
	outputDebugString("-----------------------------------------------------------------------")
	outputDebugString(" ")
	--[[ Another-Startup ]]--
	outputDebugString("------------------------------- Another --------------------------------")
	outputDebugString("Canceled Events: "..canceled_events)
	for k, v in pairs(resource_config["Start"]) do 
		if ( Resource.getFromName(v) ) then 
			if ( Resource.getFromName(v):getState() == "running" or Resource.getFromName(v):getState() == "starting" ) then
				outputDebugString("Starting of Resource "..v..": Sucessfull!")
			else
				outputDebugString("Starting of Resource "..v..": Failed!")
			end
		else
			outputDebugString("Starting of Resource "..v..": Failed!")
		end
	end
	outputDebugString("---------------------------- Another - End -----------------------------")
end
Startup()