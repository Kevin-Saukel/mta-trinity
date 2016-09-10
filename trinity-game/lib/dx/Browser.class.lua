--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 06.09.2016 *********--
--*****************************--

local Browser = {}

function Browser:__New( x, y, w, h, address, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["PostGUI"] = postGUI
	self.data["Focus"] = false
	self.data["Permission"] = "rw"
	--*******************************************************************************************************************************--
	self.data["Current_Address"] = address
	--*******************************************************************************************************************************--
	self.dx = {}
	self.dx["Address_Edit"] = Class:__Get("Lib","DX"):__Call("Editbox"):__New(self.data["X"]+(1/30)*self.data["W"],self.data["Y"]+(1/30)*self.data["H"],self.data["W"]/1.5,self.data["H"]-2*(1/30)*self.data["H"],nil,true,gpx,gpy)
	self.dx["Address_Edit"]:__setColor(255,255,255,255,255,255,255,255)
	self.dx["Address_Edit"]:__setTextAttribute(tocolor(0,0,0,255),"default-bold",1,"left","center")
	self.dx["Address_Edit"]:__setTextValids(false,true,true,true)
	
	self.dx["Address_Submit"] = Class:__Get("Lib","DX"):__Call("Button"):__New(self.data["X"],self.data["Y"]+(1/30)*self.data["H"],self.data["W"]*(1/10),self.data["H"]-2*(1/30)*self.data["H"],nil,true,gpx,gpy)
	self.dx["Address_Submit"]:__setColor()
	--*******************************************************************************************************************************--
	self.gui = {}
	self.gui["Browser"] = guiCreateBrowser(self.data["X"],self.data["Y"]+((1/10)*self.data["H"]),self.data["W"],self.data["H"]-((1/10)*self.data["H"]),false, false,false)
	self.gui["Browser_Element"] = guiGetBrowser(self.gui["Browser"])
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onClick"] = function(...) self:__onClick(...) end
	self.method["onAddressSubmit"] = function(...) self:__onAddressSubmit(...) end
		self.dx["Address_Submit"]:__setCallfunc(self.method["onAddressSubmit"])
	self.method["onBrowserCreated"] = function(...) self:__onBrowserCreated(...) end
	self.method["onWhitelistChange"] = function(...) self:__onWhitelistChange(...) end
	self.method["onRender"] = function(...) self:__onRender(...) end
	--*******************************************************************************************************************************--
	addEventHandler("onClientRender",root,self.method["onRender"])
	addEventHandler("onClientClick",root,self.method["onClick"])
	addEventHandler("onClientBrowserCreated",self.gui["Browser_Element"],self.method["onBrowserCreated"])
	addEventHandler("onClientBrowserWhitelistChange",root,self.method["onWhitelistChange"])
	--*******************************************************************************************************************************--	
	return self
end

function Browser:__setFocus ( bool ) 
	self.data["Focus"] = bool
	guiSetInputEnabled(self.data["Focus"])
end 

function Browser:__setPermission ( permission ) 
	if ( permission ) then
		self.data["Permission"] = permission
		self.dx["Address_Submit"]:__setPermission(self.data["Permission"])
	end
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

function Browser:__getElement ()
	return self.data["Element"]
end

function Browser:__getFocus ()
	return self.data["Focus"]
end

function Browser:__getPermission()
	return self.data["Permission"]
end

function Browser:__getPosition ()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function Browser:__getVisible ()
	return self.data["Visible"]
end

function Browser:__onClick ( button, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( button == "left" and state == "down" ) then
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					self:__setFocus(true)
				else
					self:__setFocus(false)
				end
			end
		end
	end
end

function Browser:__onAddressSubmit ( element )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( element == self.dx["Address_Submit"]:__getElement() ) then
				if ( isBrowserDomainBlocked(self.dx["Address_Edit"]:__getText()) ) then
					requestBrowserDomains({self.dx["Address_Edit"]:__getText()})
				else
					loadBrowserURL(self.gui["Browser_Element"],"http://"..self.dx["Address_Edit"]:__getText())
				end
			end
		end
	end
end

function Browser:__onBrowserCreated()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( isBrowserDomainBlocked(self.data["Current_Address"]) ) then
				requestBrowserDomains({self.data["Current_Address"]})
			else
				loadBrowserURL(self.gui["Browser_Element"],"http://"..self.data["Current_Address"])
			end
		end
	end
end

function Browser:__onWhitelistChange ( changedDomains ) 
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( table.find(changedDomains,self.data["Current_Address"]) ) then
				loadBrowserURL(self.gui["Browser_Element"],"http://"..self.data["Current_Address"])
			end
		end
	end
end

function Browser:__onRender()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			dxDrawRectangle(self.data["X"], self.data["Y"], self.data["W"], self.data["H"]-((9/10)*self.data["H"]), tocolor(0,0,0,175), self.data["PostGUI"]) 
		end
	end
end

function Browser:__Destroy()

end

Class:__Get("Lib","DX"):__Add ( "Browser", Browser )