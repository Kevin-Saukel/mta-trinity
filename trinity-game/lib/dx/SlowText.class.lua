--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local SlowText = {}

function SlowText:__New ( text, x, y, w, h, position, font, size, tempo, postGUI, parent, gpx, gpy )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["Text"] = text
	self.data["CurText"] = ""
	self.data["Length"] = #text
	self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
	self.data["Position"] = position
	self.data["Font"] = font
	self.data["Size"] = size
	self.data["Tempo"] = tempo
	self.data["PostGUI"] = postGUI
	self.data["Parent"] = parent
	--*******************************************************************************************************************************--
	self.data["Alpha"] = 255
	self.data["Color"] = tocolor(255,255,255,255)
	self.data["Shadow"] = false
	self.data["Clip"] = false
	self.data["Break"] = false
	self.data["ColorCoded"] = false
	self.data["Delay"] = nil
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["OnRender"] = function() self:__onRender() end
	self.method["OnNextLetter"] = function() self:__onNextLetter() end
	self.method["Destroy"] = function() self:__Destroy() end
	addEventHandler("onClientRender",root,self.method["OnRender"])
	--*******************************************************************************************************************************--
	self.data["Timer"] = Timer(self.method["OnNextLetter"],tempo,self.data["Length"])
	self.data["DelTimer"] = nil
	--*******************************************************************************************************************************--
	return self
end

function SlowText:__getElement()
	return self.data["Element"]
end

function SlowText:__getText ()
	return self.data["Text"]
end

function SlowText:__getPosition()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function SlowText:__getVisible()
	return self.data["Visible"]
end

function SlowText:__setDelay ( time )
	if ( time ) then
		if ( self.data["Delay"] ) then
			self.data["Delay"] = nil
			if ( self.data["DelTimer"] ) then
				if ( self.data["DelTimer"]:isValid() ) then
					self.data["DelTimer"]:destroy()
				end
			end
		end
		self.data["Delay"] = time
		self.data["DelTimer"] = Timer(self.method["Destroy"],self.data["Delay"],1)
		return true
	end
	return false
end

function SlowText:__setShadow ( bool )
	self.data["Shadow"] = bool
	return true
end

function SlowText:__setClip ( bool ) 
	self.data["Clip"] = bool
	return true
end

function SlowText:__setWordBreak ( bool )
	self.data["Break"] = bool
	return true
end

function SlowText:__setColorCoded ( bool )
	self.data["ColorCoded"] = bool
	return true
end

function SlowText:__setColor ( r, g, b, a )
	if ( r and g and b and a ) then
		self.data["Alpha"] = a
		self.data["Color"] = tocolor(r,g,b,a)
		return true
	end
	return false
end

function SlowText:__setVisible ( bool ) 
	self.data["Visible"] = bool
	return true
end

function SlowText:__setPosition ( x, y, w, h, gpx, gpy)
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
		return true
	end
	return false
end

function SlowText:__setFont ( font ) 
	if ( font ) then
		self.data["Font"] = font
		return true
	end
	return false
end

function SlowText:__setFontSize ( size ) 
	if ( size ) then
		self.data["Size"] = size
		return true
	end
	return false
end

function SlowText:__onRender ()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Shadow"] ) then
				dxDrawText(self.data["CurText"], self.data["X"], self.data["Y"], self.data["W"], self.data["H"], 
						tocolor(0,0,0,self.data["Alpha"]), self.data["Size"], self.data["Font"], self.data["Position"], "center",
						self.data["Clip"], self.data["Break"], self.data["PostGUI"], self.data["ColorCoded"], false)
			end
			dxDrawText(self.data["CurText"], self.data["X"], self.data["Y"], self.data["W"], self.data["H"], 
						self.data["Color"], self.data["Size"], self.data["Font"], self.data["Position"], "center",
						self.data["Clip"], self.data["Break"], self.data["PostGUI"], self.data["ColorCoded"], false)
		end
	end
end

function SlowText:__onNextLetter ()
	if ( self.data["Activ"] ) then
		if ( self.data["CurText"] ~= self.data["Text"] ) then
			self.data["CurText"] = self.data["Text"]:sub(1,#self.data["CurText"]+1)
		end
	end
end

function SlowText:__Destroy()
	if ( not self ) then return false end
	if ( self.data["Element"] ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Timer"] ) then
		if ( self.data["Timer"]:isValid() ) then
			self.data["Timer"]:destroy()
		end
	end
	if ( self.data["DelTimer"] ) then
		if ( self.data["DelTimer"]:isValid() ) then
			self.data["Timer"]:destroy()
		end
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent(self)
	end
	removeEventHandler("onClientRender",root,self.method["OnRender"])
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add ( "SlowText", SlowText )