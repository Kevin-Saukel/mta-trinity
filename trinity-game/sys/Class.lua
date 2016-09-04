--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 29.07.2016 *********--
--*****************************--

Class = {}

function Class:__Constructor ( )
	local self = setmetatable({},{__index = self})
	--**************************************************************************************************************************--
	self["ID_Counter"] = 0
	self["Modules"] = {}
	self["Config"] = {}
	self["Elements"] = {}
	--**************************************************************************************************************************--
	return self
end

function Class:__New ( modul, name, class )
	if ( not self["Modules"][modul] ) then
		self["Modules"][modul] = {}
	end
	if ( name and class ) then
		if ( not self["Modules"][modul][name] ) then
			--**************************************************************************************************************************--
			self["ID_Counter"] = self["ID_Counter"] + 1
			self["Modules"][modul][name] = {}
			self["Modules"][modul][name]["ID"] = self["ID_Counter"]
			self["Modules"][modul][name]["Key"] = md5(modul..name)
			self["Modules"][modul][name]["Class"] = setmetatable(table.copy(class), {__index = self})
				self["Modules"][modul][name]["Class"]["C_Identifiers"] = {}
				self["Modules"][modul][name]["Class"]["C_Identifiers"]["Modul"] = modul
				self["Modules"][modul][name]["Class"]["C_Identifiers"]["Name"] = name
				self["Modules"][modul][name]["Class"]["C_Identifiers"]["ID"] = self["Modules"][modul][name]["ID"]
				self["Modules"][modul][name]["Class"]["C_Identifiers"]["Key"] = self["Modules"][modul][name]["Key"]
				
			function class:__getClassModul ()
				return self["C_Identifiers"]["Modul"]
			end
			
			function class:__getClassName ()
				return self["C_Identifiers"]["Name"]
			end
			
			function class:__getClassID ()
				return self["C_Identifiers"]["ID"]
			end
		
			function class:__getClassKey ()
				return self["C_Identifiers"]["Key"]
			end
			
			return self["Modules"][modul][name]["Class"]
		end
	end
	return false
end

function Class:__newConfig ( modul, name, conf )
	if ( not self["Config"][modul] ) then
		self["Config"][modul] = {}
	end
	if ( name and conf ) then
			if ( not self["Config"][modul][name] ) then
			self["Config"][modul][name] = conf
			return self["Config"][modul][name]
		end
	end
	return false
end

function Class:__newElementClass ( modul, name, class )
	if ( not self["Elements"][modul] ) then
		self["Elements"][modul] = {}
	end
	if ( name and class ) then
		if ( not self["Modules"][modul][name] ) then
			self["Modules"][modul][name] = class
			return true
		end
	end
	return false
end

function Class:__Get ( modul, name )
	if ( modul and name ) then
		if ( self["Modules"][modul] ) then
			if ( self["Modules"][modul][name] ) then
				return self["Modules"][modul][name]["Class"]
			end
		end
	end
	return nil
end

function Class:__getConfig ( modul, name )
	if ( modul and name ) then
		if ( self["Config"][modul] ) then
			if ( self["Config"][modul][name] ) then
				return self["Config"][modul][name]
			end
		end
	end
	return nil
end

function Class:__getElementClass ( modul, name )
	if ( modul and name ) then
		if ( self["Elements"][modul] ) then
			if ( self["Elements"][modul][name] ) then
				return self["Elements"][modul][name]
			end
		end
	end
	return nil
end

function Class:__Free ( modul, name )
	if ( modul and name ) then
		if ( self["Modules"][modul] ) then
			if ( self["Modules"][modul][name] ) then
				self["Modules"][modul][name] = nil
				return true
			end
		end
	end
	return false
end

function Class:__freeConfig ( modul, name )
	if ( modul and name ) then
		if ( self["Config"][modul] ) then
			if ( self["Config"][modul][name] ) then
				self["Config"][modul][name] = nil
				return true
			end
		end
	end
	return false
end

function Class:__freeElementClass ( modul, name )
	if ( modul and name ) then
		if ( self["Elements"][modul] ) then
			if ( self["Elements"][modul][name] ) then
				self["Elements"][modul][name] = nil
				return true
			end
		end
	end
	return false
end

--**************************************************************************************************************************--

function Class:__getClassID ( modul, name )
	if ( modul and name ) then
		if ( self["Modules"][modul] ) then
			if ( self["Modules"][modul][name] ) then
				return self["Modules"][modul][name]["ID"]
			end
		end
	end
	return nil
end

function Class:__getClassKey ( modul, name )
	if ( modul and name ) then
		if ( self["Modules"][modul] ) then
			if ( self["Modules"][modul][name] ) then
				return self["Modules"][modul][name]["Key"]
			end
		end
	end	
end

function Class:__getClassesInModul ( modul )
	if ( modul ) then
		if ( self["Modules"][modul] ) then
			return table.count(self["Modules"][modul])
		end
	end
end

function Class:__getConfigsInModul ( modul ) 
	if ( modul ) then
		if ( self["Config"][modul] ) then
			return table.count(self["Config"][modul])
		end
	end
end

--**************************************************************************************************************************--

Class = Class:__Constructor()
