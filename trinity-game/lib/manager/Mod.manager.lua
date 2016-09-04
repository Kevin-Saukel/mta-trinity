--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--
local Mod = {}

function Mod:__Constructor ( )
	self.mods = {}
	self.mods["Priority"] = {}
	self.mods["Selection"] = {}
	--************************************************************************************************************************************************--
	self.methods = {}
	self.methods["onDownloadFinish"] = function( responseData, errno, modelid, type ) self:__onDownloadFinish ( responseData, errno, modelid, type ) end
end

function Mod:__Add ( type, modelid, txd, dff )
	if ( type == "Priority" ) then
		self.mods["Priority"][modelid] = { ["ID"]=modelid, ["TXD_Path"]=txd, ["TXD"]=nil, ["DFF_Path"]=dff, ["DFF"]=nil }
		self:__Replace( modelid )
		return true
	elseif ( type == "Selection" ) then
		if ( self:__isValidModelID(modelid) ) then
			self.mods["Selection"][modelid] = { ["ID"]=modelid, ["TXD_Path"]=txd, ["TXD"]=nil, ["DFF_Path"]=dff, ["DFF"]=nil }
		end
	end
	return false
end

function Mod:__isValidModelID ( modelid ) 
	if ( not self.mods["Priority"][modelid] ) then
		return true
	end
	return false
end

function Mod:__Replace ( modelid )
	if ( modelid ) then
		if ( self.mods["Priority"][modelid] ) then
			local txd, dff = true, true
			if ( not Class:__Get("Lib","FileUtility"):__Exists(self.mods["Priority"][modelid]["TXD_Path"]) ) then
				txd = false
				fetchRemote(Class:__getConfig("System","Server")["HTTP"]..getThisResource():getName().."/"..self.mods["Priority"][modelid]["TXD_Path"],self.methods["onDownloadFinish"], "", true, modelid, "TXD")
			else
				self.mods["Priority"][modelid]["TXD"] = EngineTXD(self.mods["Priority"][modelid]["TXD_Path"])
				self.mods["Priority"][modelid]["TXD"]:import(modelid)
			end
			if ( not Class:__Get("Lib","FileUtility"):__Exists(self.mods["Priority"][modelid]["DFF_Path"]) ) then
				dff = false
				fetchRemote(Class:__getConfig("System","Server")["HTTP"]..getThisResource():getName().."/"..self.mods["Priority"][modelid]["DFF_Path"],self.methods["onDownloadFinish"], "", true, modelid, "DFF")
			else
				self.mods["Priority"][modelid]["DFF"] = EngineDFF(self.mods["Priority"][modelid]["DFF_Path"])
				self.mods["Priority"][modelid]["DFF"]:replace(modelid)
			end
			--************************************************************************************************************************************************--
		elseif ( self.mods["Selection"][modelid] ) then
		
		end
	end
end

function Mod:__onDownloadFinish ( responseData, errno, modelid, type )
	if ( responseData and not errno or errno == 0 ) then
		if ( type == "TXD" ) then
			Class:__Get("Lib","FileUtility"):__New(":"..getThisResource():getName().."/"..self.mods["Priority"][modelid]["TXD_Path"], responseData)
			self.mods["Priority"][modelid]["TXD"] = EngineTXD(self.mods["Priority"][modelid]["TXD_Path"])
			self.mods["Priority"][modelid]["TXD"]:import(modelid)
		elseif ( type == "DFF" ) then
			Class:__Get("Lib","FileUtility"):__New(":"..getThisResource():getName().."/"..self.mods["Priority"][modelid]["DFF_Path"], responseData)
			self.mods["Priority"][modelid]["DFF"] = EngineDFF(self.mods["Priority"][modelid]["DFF_Path"])
			self.mods["Priority"][modelid]["DFF"]:replace(modelid)
		end
	end
end
 
Class:__New("Lib","Mod",Mod)

