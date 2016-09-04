--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Window = {}

function Window:__New ( x, y, w, h, title, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["Title"] = title 
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Client:__Get("Lib"):__Get("DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Color"] = tocolor(0,0,0,175)
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["Image"] = nil
	self.data["Parents"] = {}
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["OnRender"] = function() self:__onRender() end
	addEventHandler("onClientRender",root,self.method["OnRender"])
	--*******************************************************************************************************************************--
	return self
end

function Window:__setParent ( init )
	if ( init ) then
		self.data["Parents"][#self.data["Parents"]+1] = init
	end
end

function Window:__removeParent ( init ) 
	if ( init ) then
		for i, class in pairs(self.data["Parents"]) do 
			if ( class == init ) then
				self.data["Parents"][i] = nil
			end
		end
	end
end

function Window:__setColor ( r, g, b, a ) 
	if ( r and g and b and a ) then
		self.data["Color"] = tocolor(r,g,b,a)
	end
end

function Window:__setVisible ( bool )
	self.data["Visible"] = bool
end

function Window:__setPosition ( x, y, w, h, gpx, gpy )
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Client:__Get("Lib"):__Get("DX"):__Transform(x,y,w,h,gpx,gpy)
	end
end

function Window:__setImage ( src )
	if ( src ) then
		self.data["Image"] = src
	end
end

function Window:__getElement ()
	return self.data["Element"]
end

function Window:__getPosition ()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function Window:__getVisible ()
	return self.data["Visible"]
end

function Window:__onRender ()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( not self.data["Image"] ) then
				dxDrawRectangle(self.data["X"], self.data["Y"], self.data["W"], self.data["H"], self.data["Color"], self.data["PostGUI"] )
			else
				dxDrawImage(self.data["X"], self.data["Y"], self.data["W"], self.data["H"], self.data["Image"], 0, 0, 0, tocolor(255,255,255,255), self.data["PostGUI"] )
			end
		end
	end
end

function Window:__Destroy ()
	if ( not self ) then return false end
	for i, init in pairs(self.data["Parents"]) do 
		if ( init ) then
			init:__Destroy()
		end
	end
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	removeEventHandler("onClientRender",root,self.method["OnRender"])
	self = nil
end

Class:__Get("Lib","DX"):__Add ( "Window", Window )