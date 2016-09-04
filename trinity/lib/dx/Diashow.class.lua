--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Diashow = {}

function Diashow:__New ( x, y, w, h, parent, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = false
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Parent"] = parent
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["Pictures"] = {}
	self.data["CurrentPicture"] = nil
	self.data["CurrentPictureIndex"] = nil
	self.data["Loop"] = nil
	self.data["Delay"] = nil
	self.data["Destruction"] = nil
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.timer = {}
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onNext"] = function() self:__onNext() end
	self.method["onRender"] = function() self:__onRender() end
	--*******************************************************************************************************************************--
	addEventHandler("onClientRender",root,self.method["onRender"])
	--*******************************************************************************************************************************--
	return self
end

--*******************************************************************************************************************************--
	
function Diashow:__Add ( ... )
	local par = {...}
	if ( #par >= 1 ) then
		for k, v in pairs(par) do 
			self.data["Pictures"][#self.data["Pictures"]+1] = v
		end
	end
end

function Diashow:__Del ( picture )
	if ( picture ) then
		for k, v in pairs(self.data["Pictures"]) do 
			if ( picture == v ) then
				self.data["Pictures"][k] = nil
			end
		end
		self.data["Pictures"] = table.new(self.data["Pictures"])
	end
end

function Diashow:__Start ( delay, loop, destruction )
	if ( delay ) then
		if ( not self.data["Activ"] ) then
			self.data["Activ"] = true
			self.data["CurrentPicture"] = nil
			self.data["CurrentPictureIndex"] = nil
			self.data["Delay"] = delay
			self.data["Loop"] = loop
			self.data["Destruction"] = destruction
			self:__onNext()
			self.timer["Next"] = Timer(self.method["onNext"],self.data["Delay"],0)
		end
	end
end

function Diashow:__Stop ( )
	if ( self.data["Activ"] ) then
		self.data["Activ"] = false
		self.data["CurrentPicture"] = nil
		self.data["CurrentPictureIndex"] = nil
		self.data["Delay"] = nil
		self.data["Loop"] = nil
		if ( self.timer["Next"] ) then
			if ( self.timer["Next"]:isValid() ) then
				self.timer["Next"]:destroy()
			end
		end
	end	
end

--*******************************************************************************************************************************--

function Diashow:__getElement ( )
	if ( self.data["Element"] ) then
		return self.data["Element"]
	end
	return nil
end

function Diashow:__getVisibility ( )
	return self.data["Visible"]
end	

function Diashow:__isRunning ( )
	return self.data["Activ"]
end

function Diashow:__setPosition ( x, y, w, h, gpx, gpy )
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
		return true
	end
	return false
end

function Diashow:__setPostGUI ( postGUI ) 
	self.data["PostGUI"] = postGUI
	return true
end

function Diashow:__setVisible ( visibility )
	self.data["Visible"] = visibility
	return true
end

--*******************************************************************************************************************************--

function Diashow:__onNext ( )
	if ( self.data["Activ"] ) then
		if ( #self.data["Pictures"] >= 1 ) then
			if ( not self.data["CurrentPicture"] ) then
				self.data["CurrentPicture"] = self.data["Pictures"][1]
				self.data["CurrentPictureIndex"] = 1
			else
				if ( self.data["Pictures"][self.data["CurrentPictureIndex"]+1] ) then
					self.data["CurrentPicture"] = self.data["Pictures"][self.data["CurrentPictureIndex"]+1]
					self.data["CurrentPictureIndex"] = self.data["CurrentPictureIndex"]+1
				else
					if ( self.data["Loop"] ) then
						self.data["CurrentPicture"] = self.data["Pictures"][1]
						self.data["CurrentPictureIndex"] = 1
					else
						self:__Stop()
						if ( self.data["Destruction"] ) then
							self:__Destroy()
						end
					end
				end
			end
		end
	end
end

function Diashow:__onRender ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["CurrentPicture"] ) then
				dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["CurrentPicture"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
			end
		end
	end
end

--*******************************************************************************************************************************--

function Diashow:__Destroy()
	if ( not self ) then return false end
	if ( self.data["Element"] ) then
		self.data["Element"]:destroy()
	end
	if ( self.timer["Next"] ) then
		if ( self.timer["Next"]:isValid() ) then
			self.timer["Next"]:destroy()
		end
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent( self )
	end
	removeEventHandler("onClientRender",root,self.method["onRender"])
	self = nil
	return true
end

--*******************************************************************************************************************************--

Class:__Get("Lib","DX"):__Add ( "Diashow", Diashow )