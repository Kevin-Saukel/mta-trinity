--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Button = {}

function Button:__New ( x, y, w, h, parent, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Parent"] = parent
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["Callfunc"] = nil
	self.data["Color"] = tocolor(0,0,0,150)
	self.data["H_Color"] = tocolor(0,0,0,200)
	self.data["Image"] = nil
	self.data["H_Image"] = nil
	self.data["Text"] = nil
	self.data["Size"] = 1
	self.data["T_Color"] = tocolor(255,255,255,255)
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["OnClick"] = function( key, state ) self:__onClick( key, state ) end
	self.method["OnRender"] = function() self:__onRender() end
	addEventHandler("onClientClick",getRootElement(),self.method["OnClick"])
	addEventHandler("onClientRender",root,self.method["OnRender"])
	--*******************************************************************************************************************************--
	return self
end

function Button:__setCallfunc ( func ) 
	if ( func ) then
		self.data["Callfunc"] = func
	end
end

function Button:__setColor ( r, g, b, a, hr, hg, hb, ha )
	if ( r and g and b and a ) then
		self.data["Color"] = tocolor(r,g,b,a)
		if ( hr and hg and hb and ha ) then
			self.data["H_Color"] = tocolor(hr,hg,hb,ha)
		end
		return true
	end
	return false
end

function Button:__setImage ( image, himage )
	if ( image ) then
		self.data["Image"] = image
		if ( himage ) then
			self.data["H_Image"] = himage
		end
		return true
	end
	return false
end

function Button:__setPosition ( x, y, w, h, gpx, gpy ) 
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	end
end

function Button:__setPostGUI ( bool )
	self.data["PostGUI"] = bool
end

function Button:__setText ( text, size, r, g, b, a )
	if ( text ) then
		self.data["Text"] = text
	end
	if ( size ) then
		self.data["Size"] = size
	end
	if ( r and g and b and a ) then
		self.data["T_Color"] = tocolor(r,g,b,a)
	end
	return true
end

function Button:__setVisible ( bool )
	self.data["Visible"] = bool
end

function Button:__getCallfunc ()
	return self.data["Callfunc"]
end

function Button:__getElement ()
	return self.data["Element"]
end

function Button:__getPosition ()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function Button:__getVisible ()
	return self.data["Visible"]
end

function Button:__onClick ( key, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( key == "left" and state == "down" ) then
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					if ( self.data["Callfunc"] ) then
						self.data["Callfunc"]( self.data["Element"] )
					end
				end
			end
		end
	end
end

function Button:__onRender ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Image"] ) then
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					if ( self.data["H_Image"] ) then
						dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["H_Image"],0,0,0,tocolor(0,255,0,150),self.data["PostGUI"])
					end
				else
					dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Image"],0,0,0,tocolor(255,0,0,100),self.data["PostGUI"])
				end
			else
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["H_Color"],self.data["PostGUI"])
				else
					dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Color"],self.data["PostGUI"])
				end
			end
			if ( self.data["Text"] ) then
				dxDrawText(self.data["Text"],self.data["X"],self.data["Y"],self.data["X"]+self.data["W"],self.data["Y"]+self.data["H"],
							self.data["T_Color"], self.data["Size"], "default-bold", "center", "center", true, true, self.data["PostGUI"], false, false )
			end
		end
	end
end

function Button:__Destroy ()
	if ( not self ) then return false end
	if ( self.data["Element"] ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent( self )
	end
	removeEventHandler("onClientClick",getRootElement(),self.method["OnClick"])
	removeEventHandler("onClientRender",root,self.method["OnRender"])
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add ( "Button", Button )