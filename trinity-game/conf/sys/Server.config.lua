--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 02.08.2016 *********--
--*****************************--

local Server = {}

Server["Name"] = getServerName()
Server["Version"] = getVersion()
Server["Gametype"] = "Multigamemode"
Server["Mapname"] = "Trinity"
Server["Password"] = ""
Server["IP"] = "127.0.0.1"
Server["HTTP"] = "http://192.168.1.2:22003/" 
Server["FPS_Limit"] = 0
Server["Max_Players"] = getMaxPlayers()

--********************************************************************************************************************************************************************************************************--


Class:__newConfig("System","Server",Server)