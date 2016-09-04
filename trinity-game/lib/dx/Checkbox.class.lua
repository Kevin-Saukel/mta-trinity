--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Checkbox = {}

function Checkbox:__New ( x, y, w, h, parent, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	self.data["Checkstate"] = false
	--*******************************************************************************************************************************--
	self.data["X"],self.data["Y"],self.data["W"],self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Parent"] = parent
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["U_Color"] = tocolor(0,0,0,150)
	self.data["C_Color"] = tocolor(0,0,0,225)
	self.data["U_Image"] = nil
	self.data["C_Image"] = nil
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onClick"] = function ( key, state ) self:__onClick( key, state ) end
	self.method["onRender"] = function ( ) self:__onRender() end
	addEventHandler("onClientClick",root,self.method["onClick"])
	addEventHandler("onClientRender",root,self.method["onRender"])
	--*******************************************************************************************************************************--
	return self
end

function Checkbox:__setCheckState ( bool )
	self.data["Checkstate"] = bool
end

function Checkbox:__setColor ( r, g, b, a, hr, hg, hb, ha )
	if ( r and g and b and a ) then
		self.data["U_Color"] = tocolor(r,g,b,a)
		if ( hr and hg and hb and ha ) then
			self.data["C_Color"] = tocolor(hr,hg,hb,ha)
		end
		return true
	end
	return false
end

function Checkbox:__setImage ( img, h_img)
	if ( img ) then
		self.data["U_Image"] = img
		if ( h_img ) then
			self.data["C_Image"] = h_img
		end
		return true
	end
	return false
end

function Checkbox:__setPosition ( x, y, w, h, gpx, gpy ) 
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
		return true
	end
	return false
end

function Checkbox:__setPostGUI ( bool )
	self.data["PostGUI"] = bool
end

function Checkbox:__setVisible ( bool )
	self.data["Visible"] = bool
end

function Checkbox:__getCheckState ( )
	return self.data["Checkstate"]
end

function Checkbox:__getElement ( )
	return self.data["Element"]
end

function Checkbox:__getPosition ( )
	return self.data["X"],self.data["Y"],self.data["W"],self.data["H"]
end

function Checkbox:__getVisible ( )
	return self.data["Visible"]
end

function Checkbox:__onClick ( key, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( key == "left" and state == "down" ) then
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					self.data["Checkstate"] = not self.data["Checkstate"]
				end
			end
		end
	end
end

function Checkbox:__onRender ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["U_Image"] and self.data["C_Image"] ) then
				--if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					--[[if ( self.data["Checkstate"] ) then
						dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["U_Image"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
					else
						dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["C_Image"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
					end]]
				--else
					if ( self.data["Checkstate"] ) then
						dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["C_Image"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
					else
						dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["U_Image"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
					end
				--end
			else
				if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
					if ( self.data["Checkstate"] ) then
						dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["U_Color"],self.data["PostGUI"])
					else
						dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["C_Color"],self.data["PostGUI"])
					end
				else
					if ( self.data["Checkstate"] ) then
						dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["C_Color"],self.data["PostGUI"])
					else
						dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["U_Color"],self.data["PostGUI"])
					end
				end
			end
		end
	end
end

function Checkbox:__Destroy ( )
	if ( not self ) then return false end
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent( self )
	end
	
	removeEventHandler("onClientClick",getRootElement(),self.method["onClick"])
	removeEventHandler("onClientRender",root,self.method["onRender"])
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add("Checkbox",Checkbox)


