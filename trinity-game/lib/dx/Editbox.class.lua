--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.03.2016 *********--
--*****************************--

local Editbox = {}

function Editbox:__New ( x, y, w, h, parent, postGUI, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Parent"] = parent
	self.data["Color"] = tocolor(100,100,100,200)
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["Image"] = nil
	
	self.data["Textactiv"] = false
	self.data["Shiftactiv"] = false
	self.data["Altactiv"] = false
	
	self.data["StrActiv"] = false
	self.data["LAltActiv"] = false

	self.data["Text"] = {}
	self.data["Text"]["Display"] = ""
	self.data["Text"]["Hidden"] = ""
	self.data["Text"]["Encoded"] = false
	self.data["Text"]["Color"] = tocolor(0,0,0,255)
	self.data["Text"]["Font"] = "default-bold"
	self.data["Text"]["Size"] = 1
	self.data["Text"]["HorizontalAlign"] = "left"
	self.data["Text"]["VerticalAlign"] = "center"
	self.data["Text"]["Boxalpha"] = 0
	
	self.data["Text"]["Conditions"] = {}
	self.data["Text"]["Conditions"]["Key"] = {}
	self.data["Text"]["Conditions"]["Key"]["All"] = false
	self.data["Text"]["Conditions"]["Key"]["Arabic"] = true
	self.data["Text"]["Conditions"]["Key"]["Numerical"] = true
	self.data["Text"]["Conditions"]["Key"]["Symbol"] = false
	--*******************************************************************************************************************************--
	self.data["Permission"] = "rw"
	--Permission: r = readOnly
	--Permission: w = writeOnly
	--Permission: rw = read and Write
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onClick"] = function ( key, state ) self:__onClick ( key, state ) end
	self.method["onShift"] = function ( key, state ) self:__onShift ( key, state ) end
	self.method["onAlt"] = function ( key, state ) self:__onAlt ( key, state ) end
	self.method["onRender"] = function ( ) self:__onRender ( ) end
	self.method["onKey"] = function ( key, state ) self:__onKey ( key, state ) end
	bindKey("lshift","both",self.method["onShift"])
	bindKey("capslock","down",self.method["onShift"])
	bindKey("ralt","both",self.method["onAlt"])
	bindKey("lalt","both",self.method["onAlt"])
	bindKey("lctrl","both",self.method["onAlt"])
	addEventHandler("onClientClick",getRootElement(),self.method["onClick"])
	addEventHandler("onClientKey",getRootElement(),self.method["onKey"])
	addEventHandler("onClientRender",root,self.method["onRender"])
	--*******************************************************************************************************************************--
	return self
end

function Editbox:__setColor ( r, g, b, a ) 
	if ( r and g and b and a ) then
		self.data["Color"] = tocolor(r,g,b,a)
		return true
	end
	return false
end

function Editbox:__setHidden ( bool )
	self.data["Text"]["Encoded"] = bool
end

function Editbox:__setImage ( img )
	if ( img ) then
		self.data["Image"] = img
		return true
	end
	return false
end

function Editbox:__setPosition ( x, y, w, h, gpx, gpy ) 
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	end
end

function Editbox:__setPermission ( perm ) 
	self.data["Permission"] = perm
end	

function Editbox:__setPostGUI ( bool )
	self.data["PostGUI"] = bool
end

function Editbox:__setText ( text )
	if ( text ) then
		if ( self.data["Text"]["Encoded"] ) then
			self.data["Text"]["Display"] = ""
			self.data["Text"]["Hidden"] = text
			for i = 1, #text do 
				self.data["Text"]["Display"] = self.data["Text"]["Display"].."*"
			end
		else
			self.data["Text"]["Display"] = text
			self.data["Text"]["Hidden"] = text
		end
	end
end

function Editbox:__setTextAttribute ( color, font, size, alignX, alignY )
	if ( color ) then
		self.data["Text"]["Color"] = color
	end
	if ( font ) then
		self.data["Text"]["Font"] = font
	end
	if ( size ) then
		self.data["Text"]["Size"] = size
	end
	if ( alignX ) then
		self.data["Text"]["HorizontalAlign"] = alignX
	end
	if ( alignY ) then
		self.data["Text"]["VerticalAlign"] = alignY
	end
end

function Editbox:__setTextValids ( all, arabic, numerical, symbol )
	self.data["Text"]["Conditions"]["Key"]["All"] = all
	self.data["Text"]["Conditions"]["Key"]["Arabic"] = arabic
	self.data["Text"]["Conditions"]["Key"]["Numerical"] = numerical
	self.data["Text"]["Conditions"]["Key"]["Symbol"] = symbol
end

function Editbox:__setVisible ( bool )
	self.data["Visible"] = bool
end

function Editbox:__getElement ( )
	return self.data["Element"]
end

function Editbox:__getPosition ()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function Editbox:__getText ()
	return self.data["Text"]["Hidden"]
end

function Editbox:__getVisible ()
	return self.data["Visible"]
end

function Editbox:__isValidKey ( key )
	if ( self.data["Text"]["Conditions"]["Key"]["All"] ) then return true end
	local val = false
	if ( self.data["Text"]["Conditions"]["Key"]["Arabic"] ) then
		if ( Class:__Get("Lib","DX"):__isKeyArabic(key) ) then
			val = true
		end
	end
	if ( self.data["Text"]["Conditions"]["Key"]["Numerical"] ) then
		if ( Class:__Get("Lib","DX"):__isKeyNumerical(key) ) then
			val = true
		end
	end
	if ( self.data["Text"]["Conditions"]["Key"]["Symbol"] ) then
		if ( Class:__Get("Lib","DX"):__isKeySymbol(key) ) then
			val = true
		end	
	end
	return val
end

function Editbox:__onAlt ( key, state ) 
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			--if ( self.data["Textactiv"] ) then
				if ( key == "ralt" ) then
					if ( state == "down" ) then
						self.data["Altactiv"] = true
					elseif ( state == "up" ) then
						self.data["Altactiv"] = false
					end
				end
				if ( key == "lalt" ) then
					if ( state == "down" ) then
						self.data["LAltActiv"] = true
					elseif ( state == "up" ) then
						self.data["LAltActiv"] = false
					end
				end
				if ( key == "lctrl" ) then
					if ( state == "down" ) then
						self.data["StrActiv"] = true
					elseif ( state == "up" ) then
						self.data["StrActiv"] = false
					end
				end
			--end
		end
	end
end

function Editbox:__onClick ( key, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Permission"] ~= "r" ) then
				if ( key == "left" and state == "down" ) then
					if ( Class:__Get("Lib","DX"):__getCursorArea(self.data["X"],self.data["Y"],self.data["W"],self.data["H"]) ) then
						self.data["Textactiv"] = true
						Class:__Get("Lib","DX"):__setActionState(self.data["Textactiv"],element)
						guiSetInputEnabled(self.data["Textactiv"])
					else
						self.data["Textactiv"] = false
						Class:__Get("Lib","DX"):__setActionState(self.data["Textactiv"],element)
						guiSetInputEnabled(self.data["Textactiv"])
					end
				end
			end
		end
	end
end

function Editbox:__onShift ( key, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			--if ( self.data["Textactiv"] ) then
				if ( key == "lshift" ) then
					if ( state == "down" ) then
						self.data["Shiftactiv"] = not self.data["Shiftactiv"]
					elseif ( state == "up" ) then
						self.data["Shiftactiv"] = not self.data["Shiftactiv"]
					end
				elseif ( key == "capslock" ) then
					self.data["Shiftactiv"] = not self.data["Shiftactiv"]
				end
			--end
		end
	end
end

function Editbox:__onKey ( key, state )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Textactiv"] ) then
				if ( self.data["Permission"] ~= "r" ) then
					if ( state ) then
						local special = false
						if ( self.data["Altactiv"] or self.data["StrActiv"] and self.data["LAltActiv"] ) then
							if ( not special ) then
								key = Class:__Get("Lib","DX"):__getAltKey(key)
								special = true
							end
						end
						if ( self.data["Shiftactiv"] ) then
							if ( not special ) then
								key = Class:__Get("Lib","DX"):__getShiftKey(key)
								special = true
							end
						end
						if ( self.data["Text"]["Encoded"] ) then
							if ( key == "backspace" ) then
								if ( #self.data["Text"]["Display"] >= 1 ) then
									self.data["Text"]["Display"] = self.data["Text"]["Display"]:sub(0,#self.data["Text"]["Display"]-1)
									self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"]:sub(0,#self.data["Text"]["Hidden"]-1)
									return
								end
							end
							if ( key == "space" ) then
								if ( #self.data["Text"]["Display"] >= 1 ) then
									self.data["Text"]["Display"] = self.data["Text"]["Display"].."*"
									self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"].." "
									return
								end
							end
							if ( self:__isValidKey(key) ) then
								self.data["Text"]["Display"] = self.data["Text"]["Display"].."*"
								self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"]..key
								return
							end
						else
							if ( key == "backspace" ) then
								if ( #self.data["Text"]["Display"] >= 1 ) then
									self.data["Text"]["Display"] = self.data["Text"]["Display"]:sub(0,#self.data["Text"]["Display"]-1)
									self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"]:sub(0,#self.data["Text"]["Hidden"]-1)
									return
								end
							end
							if ( key == "space" ) then
								if ( #self.data["Text"]["Display"] >= 1 ) then
									self.data["Text"]["Display"] = self.data["Text"]["Display"].." "
									self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"].." "
									return
								end
							end
							if ( self:__isValidKey(key) ) then
								self.data["Text"]["Display"] = self.data["Text"]["Display"]..key
								self.data["Text"]["Hidden"] = self.data["Text"]["Hidden"]..key
								return
							end
						end
					end
				end
			end
		end
	end
end

function Editbox:__onRender ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Image"] ) then
				dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Image"],0,0,0,self.data["Color"],self.data["PostGUI"])
			else
				dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Color"],self.data["PostGUI"])
			end
			if ( self.data["Text"] ) then
				dxDrawText(self.data["Text"]["Display"],self.data["X"]+5,self.data["Y"],self.data["X"]+self.data["W"]-5,self.data["Y"]+self.data["H"],
						self.data["Text"]["Color"], self.data["Text"]["Size"], self.data["Text"]["Font"], self.data["Text"]["HorizontalAlign"], self.data["Text"]["VerticalAlign"], 
						true, false, self.data["PostGUI"], false, false)
			end
			if ( self.data["Textactiv"] ) then
				if ( self.data["Text"]["Boxalpha"] ) then
					if ( self.data["Text"]["Boxalpha"] >= 255 ) then
						self.data["Text"]["Boxalpha"] = 0
					else
						self.data["Text"]["Boxalpha"] = self.data["Text"]["Boxalpha"] + 10
					end
				end
				if ( self.data["Text"]["HorizontalAlign"] == "center" ) then
					dxDrawRectangle(self.data["X"]+((self.data["W"]+dxGetTextWidth(self.data["Text"]["Display"],self.data["Text"]["Size"],self.data["Text"]["Font"]))/2),self.data["Y"]+3,2,self.data["H"]-6,tocolor(0,0,0,self.data["Text"]["Boxalpha"]),self.data["PostGUI"])
				else
					dxDrawRectangle(self.data["X"]+3+dxGetTextWidth(self.data["Text"]["Display"],self.data["Text"]["Size"],self.data["Text"]["Font"]),self.data["Y"]+3,2,self.data["H"]-6,tocolor(0,0,0,self.data["Text"]["Boxalpha"]),self.data["PostGUI"])
				end
			end
		end
	end
end

function Editbox:__Destroy ()
	if ( not self ) then return false end
	Class:__Get("Lib","DX"):__resetActionState(self.data["Element"])
	if ( self.data["Element"] ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent( self )
	end
	if ( self.data["Textactiv"] ) then
		guiSetInputEnabled(false)
	end
	unbindKey("lshift","both",self.method["onShift"])
	unbindKey("capslock","both",self.method["onShift"])
	unbindKey("ralt","both",self.method["onAlt"])
	unbindKey("lalt","both",self.method["onAlt"])
	unbindKey("lctrl","both",self.method["onAlt"])
	removeEventHandler("onClientRender",root,self.method["onRender"])
	removeEventHandler("onClientKey",getRootElement(),self.method["onKey"])
	removeEventHandler("onClientClick",getRootElement(),self.method["onClick"])
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add ( "Editbox", Editbox )