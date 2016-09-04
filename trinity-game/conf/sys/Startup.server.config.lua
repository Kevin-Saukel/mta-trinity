--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 01.08.2016 *********--
--*****************************--

local Startup = {}

Startup["Constructors"] = {}
Startup["Constructors"][#Startup["Constructors"]+1] = { [1]="Lib", [2]="Mysql"}
Startup["Constructors"][#Startup["Constructors"]+1] = { [1]="Lib", [2]="Data" }
Startup["Constructors"][#Startup["Constructors"]+1] = { [1]="Lib", [2]="Dimension" }
Startup["Constructors"][#Startup["Constructors"]+1] = { [1]="Lib", [2]="Resource" }

Class:__newConfig("System","Startup_S",Startup)