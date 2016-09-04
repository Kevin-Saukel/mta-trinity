--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Download = {}

function Download:__Constructor ( )
	self.method = {}
	self.method["onDownloadFinish"] = function( ... ) self:__onDownloadFinish( ... ) end
	--************************************************************************************************************************************************--
	self.temp = {}
end

function Download:__downloadFile ( resource, filepath, cache, func, ... )
	if ( resource and filepath ) then
		local fileTable = { true }
		self.temp[#self.temp+1] = function(...) func(...) end
		fetchRemote(Class:__getConfig("System","Server")["HTTP"]..resource:getName().."/"..filepath, self.method["onDownloadFinish"], "", true, filepath, cache, resource, fileTable, #self.temp, ...) 
	end
end

function Download:__downloadFiles ( resource, filepaths, cache, func, ... )
	if ( resource and filepaths ) then
		local fileTable = {}
		self.temp[#self.temp+1] = function(...) func(...) end
		for k, v in pairs(filepaths) do 
			if ( v ) then
				fileTable[v] = false
				fetchRemote(Class:__getConfig("System","Server")["HTTP"]..resource:getName().."/"..v, self.method["onDownloadFinish"], "", true, v, cache, resource, fileTable, #self.temp, ...) 
			end
		end
	end
end

function Download:__onDownloadFinish ( responseData, errno, filepath, cache, resource, fileTable, func, ... )
	if ( responseData ) then
		if ( not cache ) then
			if ( Class:__Get("Lib","FileUtility"):__Exists(":"..resource:getName().."/"..filepath) ) then
				if ( md5(responseData) ~= md5(Class:__Get("Lib","FileUtility"):__Read(":"..resource:getName().."/"..filepath)) ) then
					Class:__Get("Lib","FileUtility"):__Rewrite(":"..resource:getName().."/"..filepath, responseData)
				end
			else
				Class:__Get("Lib","FileUtility"):__New(":"..resource:getName().."/"..filepath, responseData)
			end
		end
		fileTable[filepath] = true
		if ( table.check(fileTable,true) ) then
			if ( self.temp[func] ) then
				self.temp[func](table.switchNew(fileTable),...)
			end
		end
	end
end 

Class:__New("Lib","Download",Download)
