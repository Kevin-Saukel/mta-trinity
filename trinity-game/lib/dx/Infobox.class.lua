--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Infobox = {}

function Infobox:__New ( text, time, execution, postGUI )
	local self = setmetatable({},{__index = self})
	--*******************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Dump")
	self.data["Activ"] = true
	self.data["Visible"] = true
	--*******************************************************************************************************************************--
	self.data["Text"] = {}
	self.data["Text"]["Display"] = text
	self.data["Text"]["Color"] = tocolor(0,0,0,255)
	self.data["Text"]["Font"] = "default-bold"
	self.data["Text"]["Size"] = 1.25
	self.data["Text"]["HorizontalAlign"] = "center"
	self.data["Text"]["VerticalAlign"] = "top"
	
	self.data["Time"] = time
	self.data["Execution"] = execution
	self.data["PostGUI"] = postGUI
	--*******************************************************************************************************************************--
	self.data["X"],self.data["Y"],self.data["W"],self.data["H"] = Class:__Get("Lib","DX"):__Transform(421, 5, 543, 159,1366,768)
	self.data["TX"],self.data["TY"],self.data["TW"],self.data["TH"] = self.data["X"],self.data["Y"],self.data["W"],self.data["H"]
	self.data["Image"] = nil
	self.data["Color"] = tocolor(255,255,255,150)
	self.data["Timer"] = nil
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["onRender"] = function() self:__onRender() end
	self.method["onElapse"] = function() self:__onElapse () end
	--*******************************************************************************************************************************--
	if ( self.data["Execution"] ) then
		addEventHandler("onClientRender",root,self.method["onRender"])
	end
	--*******************************************************************************************************************************--
	return self
end

function Infobox:__setColor( r, g, b, a )
	if ( r and g and b and a ) then
		self.data["Color"] = tocolor(r,g,b,a)
		return true
	end
	return false
end

function Infobox:__setImage ( img ) 
	if ( img ) then
		self.data["Image"] = img
		return true
	end
	return false
end

function Infobox:__setPosition ( x, y, w, h, gpx, gpy )
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
		return true
	end
	return false
end

function Infobox:__setText( text )
	if ( text ) then
		self.data["Text"] = text
		return true
	end
	return false
end

function Infobox:__setTextPosition ( x, y, w, h, gpx, gpy )
	if ( x and y and w and h ) then
		self.data["TX"],self.data["TY"],self.data["TW"],self.data["TH"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h)
		return true
	end
	return false
end

function Infobox:__setVisible ( bool ) 
	self.data["Visible"] = bool
end

function Infobox:__getElement()
	return self.data["Element"]
end

function Infobox:__getPosition ()
	return self.data["X"],self.data["Y"],self.data["W"],self.data["H"]
end

function Infobox:__getText()
	return self.data["Text"]
end

function Infobox:__getVisible()
	return self.data["Visible"]
end

function Infobox:__Execute ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( not self.data["Execution"] ) then
				if ( not Class:__Get("Lib","DX"):__getInfoboxState() ) then
					self.data["Execution"] = true
					addEventHandler("onClientRender",root,self.method["onRender"])
					self.data["Timer"] = Timer(self.method["onElapse"],self.data["Time"],1)
					Class:__Get("Lib","DX"):__setInfoboxState(true,self)
				end
			end
		end
	end
end

function Infobox:__onElapse ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Execution"] ) then
				self:__Destroy()
			end
		end
	end
end

function Infobox:__onRender ( )
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			if ( self.data["Execution"] ) then
				if ( self.data["Image"] ) then
					dxDrawImage(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Image"],0,0,0,tocolor(255,255,255,255),self.data["PostGUI"])
				else
					dxDrawRectangle(self.data["X"],self.data["Y"],self.data["W"],self.data["H"],self.data["Color"],self.data["PostGUI"])
				end
				dxDrawText(self.data["Text"]["Display"],self.data["TX"],self.data["TY"],self.data["TX"]+self.data["TW"],self.data["TY"]+self.data["TH"],
						self.data["Text"]["Color"], self.data["Text"]["Size"], self.data["Text"]["Font"], self.data["Text"]["HorizontalAlign"], self.data["Text"]["VerticalAlign"], 
						true, true, self.data["PostGUI"], false, false)
			end
		end
	end
end


function Infobox:__Destroy ()
	if ( not self ) then return false end
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Execution"] ) then
		removeEventHandler("onClientRender",root,self.method["onRender"])
	end
	if ( self.data["Timer"] ) then
		if ( self.data["Timer"]:isValid() ) then
			self.data["Timer"]:destroy()
		end
	end
	Class:__Get("Lib","DX"):__resetInfoboxState(self)
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add("Infobox",Infobox)
