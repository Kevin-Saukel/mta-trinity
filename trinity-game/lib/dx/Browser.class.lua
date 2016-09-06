--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 06.09.2016 *********--
--*****************************--
requestBrowserDomains({ "www.google.de" })

local Browser = {}

function Browser:__New( x, y, w, h, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.gui = {}
	self.gui["Browser"] = guiCreateBrowser(self.data["X"],self.data["Y"]+((1/10)*self.data["H"]),self.data["W"],self.data["H"]-((1/10)*self.data["H"]),false, false,false)
	self.gui["Browser_Element"] = guiGetBrowser(self.gui["Browser"])
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onRender"] = function(...) self:__onRender(...) end
	self.method["onBrowserCreated"] = function(...) self:__onBrowserCreated(...) end
	--*******************************************************************************************************************************--
	addEventHandler("onClientRender",root,self.method["onRender"])
	addEventHandler("onClientBrowserCreated",self.gui["Browser_Element"],self.method["onBrowserCreated"])
	--*******************************************************************************************************************************--	
	return self
end

function Browser:__setPosition ( x, y, w, h, gpx, gpy ) 
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	end
end

function Browser:__setPostGUI ( bool )
	self.data["PostGUI"] = bool
end

function Browser:__setVisible ( bool )
	self.data["Visible"] = bool
end

function Browser:__onRender()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			dxDrawRectangle(self.data["X"], self.data["Y"], self.data["W"], self.data["H"]-((9/10)*self.data["H"]), tocolor(0,0,0,175), self.data["PostGUI"]) 
		end
	end
end

function Browser:__onBrowserCreated()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			loadBrowserURL(self.gui["Browser_Element"],"http://www.google.de")
		end
	end
end

Class:__Get("Lib","DX"):__Add ( "Browser", Browser )