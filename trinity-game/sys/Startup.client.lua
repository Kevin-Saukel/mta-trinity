--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 01.08.2016 *********--
--*****************************--

local config = Class:__getConfig("System","Startup_C")

local function Startup ()
	for k, v in pairs(config["Constructors"]) do
		if ( Class:__Get(v[1],v[2]) ) then
			Class:__Get(v[1],v[2]):__Constructor()
		end
	end
	if ( localPlayer ) then
		local shader_config = Class:__getConfig("Lib","Shader")
		for k, v in pairs(shader_config) do 
			if ( v[1] and v[2] ) then
				Class:__Get("Lib","Shader"):__addShader(v[1],Class:__Get("Lib","Shader"):__getMethod(v[2]))
			end
		end
		--**--
		Class:__Get("Multigamemode","Registerlogin"):__New({ [1]={["Username"]="Elendio", ["Password"]="thehopelesshope", ["Permission"]="r"} },1)
	end
end
Startup()
