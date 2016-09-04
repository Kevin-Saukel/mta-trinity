--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 02.08.2016 *********--
--*****************************--

local Mysql = {}

Mysql["Connections"] = {}
Mysql["Connections"][1] = { "Multigamemode", "mysql", 
							"host=127.0.0.1;dbname=multigamemode",
							"root","",
							"share=0;batch=1;autoreconnect=1;log=0"}
		
Mysql["Databases"] = {}

Mysql["Databases"]["Multigamemode"] = {}
Mysql["Databases"]["Multigamemode"]["Name"] = "Multigamemode"

Mysql["Databases"]["Multigamemode"]["Tables"] = {}
Mysql["Databases"]["Multigamemode"]["Tables"][1] = "user.accounts"
Mysql["Databases"]["Multigamemode"]["Tables"][2] = "user.admin"

Mysql["Databases"]["Multigamemode"]["Datastrings"] = {}
Mysql["Databases"]["Multigamemode"]["Datastrings"][Mysql["Databases"]["Multigamemode"]["Tables"][1]] = { "ID", "Username", "Password", "Serial", "IP", "Authcode", "Authkey", "Autologin" }
Mysql["Databases"]["Multigamemode"]["Datastrings"][Mysql["Databases"]["Multigamemode"]["Tables"][2]] = { "ID", "Username", "Adminlevel", "Authorization", "Multiaccount" }

Mysql["Databases"]["Multigamemode"]["Standards"] = {}
Mysql["Databases"]["Multigamemode"]["Standards"][Mysql["Databases"]["Multigamemode"]["Tables"][1]] = { false, "Username", "Password", "Serial", "IP", "Authcode", "Authkey", 0 }
Mysql["Databases"]["Multigamemode"]["Standards"][Mysql["Databases"]["Multigamemode"]["Tables"][2]] = { false, "Username", 0, "none", 0 }

Mysql["Databases"]["Multigamemode"]["Manual"] = {}
Mysql["Databases"]["Multigamemode"]["Manual"][Mysql["Databases"]["Multigamemode"]["Tables"][1]] = { nil, nil, nil, "Serial", "IP", nil, nil, nil }
Mysql["Databases"]["Multigamemode"]["Manual"][Mysql["Databases"]["Multigamemode"]["Tables"][2]] = { nil, nil, nil, nil, nil }


Class:__newConfig ("System","Mysql",Mysql)