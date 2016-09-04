--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Text = {}

function Text:__New ( text, x, y, w, h, parent, postGUI, gpx, gpy )
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
	self.data["Text"] = text
	self.data["Align"] = { [1]="left", [2]="center" }
	self.data["Color"] = tocolor(0,0,0,150)
	self.data["Font"] = "default-bold"
	self.data["Size"] = 1
	self.data["Clip"] = false
	self.data["Break"] = false
	self.data["CCoded"] = false
	self.data["Pixel"] = false
	self.data["Animation"] = { nil, nil }
	--*******************************************************************************************************************************--
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__setParent(self)
	end
	--*******************************************************************************************************************************--
	self.method = {}
	self.method["OnRender"] = function() self:__onRender() end
	addEventHandler("onClientRender",root,self.method["OnRender"])
	--*******************************************************************************************************************************--
	return self
end

function Text:__setAnimation ( endX, endY, endW, endH, easing, time, gpx, gpy )
	if ( easing and time ) then
		if ( endX ) then
			self.data["Animation"][1] = Class:__Get("Lib","DX"):__Call("Anim2D"):__New(self.data["X"],self.data["Y"],endX,endY,easing,time,gpx,gpy)
		end
		if ( endW ) then
			self.data["Animation"][2] = Class:__Get("Lib","DX"):__Call("Anim2D"):__New(self.data["W"],self.data["H"],endW,endH,easing,time,gpx,gpy)
		end
		return true
	end
	return false
end

function Text:__setAlign ( alignX, alignY )
	if ( alignX ) then
		self.data["Align"][1] = alignX
		if ( alignY ) then
			self.data["Align"][2] = alignY
		end
		return true
	end
	return false
end

function Text:__setColor ( r, g, b, a )
	if ( r and g and b and a ) then
		self.data["Color"] = tocolor(r,g,b,a)
		return true
	end
	return false
end

function Text:__setFont ( font )
	if ( font ) then
		self.data["Font"] = font
	end
	return false
end

function Text:__setPosition ( x, y, w, h, gpx, gpy ) 
	if ( x and y and w and h ) then
		self.data["X"], self.data["Y"], self.data["W"], self.data["H"] = Class:__Get("Lib","DX"):__Transform(x,y,w,h,gpx,gpy)
		return true
	end
	return false
end

function Text:__setPostGUI ( bool )
	self.data["PostGUI"] = bool
end

function Text:__setSize ( size )
	if ( size ) then
		self.data["Size"] = size
		return true
	end	
	return false
end

function Text:__setText ( text )
	if ( text ) then
		self.data["Text"] = text
		return true
	end
	return false
end

function Text:__setVisible ( bool )
	self.data["Visible"] = bool
end

--*******************************************************************************************************************************--

function Text:__getAlign()
	return self.data["Align"]
end

function Text:__getElement ()
	return self.data["Element"]
end

function Text:__getFont ()
	return self.data["Font"]
end

function Text:__getPosition ()
	return self.data["X"], self.data["Y"], self.data["W"], self.data["H"]
end

function Text:__getSize ()
	return self.data["Size"]
end

function Text:__getText ()
	return self.data["Text"]
end

function Text:__getVisible ()
	return self.data["Visible"]
end

--*******************************************************************************************************************************--

function Text:__onRender()
	if ( self.data["Activ"] ) then
		if ( self.data["Visible"] ) then
			dxDrawText(self.data["Text"],self.data["X"],self.data["Y"],self.data["X"]+self.data["W"],self.data["Y"]+self.data["H"],
					self.data["Color"],self.data["Size"],self.data["Font"],self.data["Align"][1],self.data["Align"][2],
					self.data["Clip"],self.data["Break"],self.data["PostGUI"],self.data["CCoded"],self.data["Pixel"])
			if ( not self.data["Animation"][1] and not self.data["Animation"][2] ) then
				return false
			else
				if ( self.data["Animation"][1] and self.data["Animation"][2] ) then
					local ex, ey = self.data["Animation"][1]:__getPosition()
					local ew, eh = self.data["Animation"][2]:__getPosition()
					self:__setPosition(ex,ey,ew,eh)
				else
					if ( self.data["Animation"][1] ) then
						local ex, ey = self.data["Animation"][1]:__getPosition()
						local ew, eh = self.data["W"], self.data["H"]
						self:__setPosition(ex,ey,ew,eh)
					else
						local ex, ey = self.data["X"],self.data["Y"]
						local ew, eh = self.data["Animation"][1]:__getPosition()
						self:__setPosition(ex,ey,ew,eh)
					end
				end
			end
		end
	end
end

--*******************************************************************************************************************************--

function Text:__Destroy ()
	if ( not self ) then return false end
	if ( self.data["Element"] ) then
		self.data["Element"]:destroy()
	end
	if ( self.data["Parent"] ) then
		self.data["Parent"]:__removeParent( self )
	end
	if ( self.data["Animation"] ) then
		if ( self.data["Animation"][1] ) then
			self.data["Animation"][1]:__Destroy()
		end
		if ( self.data["Animation"][2] ) then
			self.data["Animation"][2]:__Destroy()
		end	
	end
	removeEventHandler("onClientRender",root,self.method["OnRender"])
	self = nil
	return true
end

Class:__Get("Lib","DX"):__Add("Text",Text)