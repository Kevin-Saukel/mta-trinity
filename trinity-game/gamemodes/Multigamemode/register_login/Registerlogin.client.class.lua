--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 04.08.2016 *********--
--*****************************--


local gx, gy = guiGetScreenSize()
local gpx, gpy = nil, nil

local Registerlogin = {}

function Registerlogin:__readProfiles ()
	if ( Class:__Get("Lib","FileUtility"):__Exists(":"..getThisResource():getName().."/client/crypt/Profiles.prof") ) then
	
	else
		return {}, 1
	end
end

function Registerlogin:__New ( profiles, last_profile )
	showCursor(true)
	gpx, gpy = Class:__Get("Lib","DX"):__getDevSize()

	self.data = {}
	self.data["Activ"] = true
	self.data["Profiles"] = profiles
	self.data["Profiles"][#self.data["Profiles"]+1] = { ["Username"]="", ["Password"]="", ["Permission"]="rw" }
	self.data["Current_Profile"] = last_profile
	
	self.methods = {}
	self.methods["onRender"] = function() self:__onRender() end
	self.methods["onSubmit"] = function(...) self:__onSubmit(...) end
	self.methods["onClick"] = function(...) self:__onClick(...) end
	
	self.dx = {}
	self.dx["Background"] = Class:__Get("Lib","Shader"):__applyShader("Blur.fx",true,dxCreateTexture(":"..getThisResource():getName().."/client/images/Registerlogin/background.png"),10,gx,gy)
	self.dx["NameEdit"] = Class:__Get("Lib","DX"):__Call("Editbox"):__New(533,300,300,30,nil,true,1366,768)
	self.dx["NameEdit"]:__setText(self.data["Profiles"][last_profile]["Username"])
	self.dx["NameEdit"]:__setColor(0,0,0,150,0,0,0,150)
	self.dx["NameEdit"]:__setPermission(self.data["Profiles"][1]["Permission"])
	self.dx["NameEdit"]:__setTextAttribute(tocolor(255,255,255,255),"default-bold",1,"center","center")
	
	self.dx["PasswordEdit"] = Class:__Get("Lib","DX"):__Call("Editbox"):__New(533,370,300,30,nil,true,1366,768)
	self.dx["PasswordEdit"]:__setColor(0,0,0,150,0,0,0,150)
	self.dx["PasswordEdit"]:__setTextValids(false,true,true,true)
	self.dx["PasswordEdit"]:__setTextAttribute(tocolor(255,255,255,255),"default-bold",1,"center","center")
	self.dx["PasswordEdit"]:__setHidden(true)
	self.dx["PasswordEdit"]:__setText(self.data["Profiles"][last_profile]["Password"])
	
	self.dx["SubmitButton"] = Class:__Get("Lib","DX"):__Call("Button"):__New(533,440,300,30,nil,true,1366,768)
	self.dx["SubmitButton"]:__setText("Submit",1,255,255,255,255)
	self.dx["SubmitButton"]:__setColor(0,0,0,150,0,0,0,200)	
	self.dx["SubmitButton"]:__setCallfunc(self.methods["onSubmit"])
	
	self.dx["CEFButton"] = Class:__Get("Lib","DX"):__Call("Button"):__New(1176, 596, 333, 30,nil,true)
	self.dx["CEFButton"]:__setText("Internet",1,255,255,255,255)
	self.dx["CEFButton"]:__setColor(0,0,255,150,0,0,255,250)
	self.dx["CEFButton"]:__setCallfunc(self.methods["onSubmit"])
	
	addEventHandler("onClientRender",root,self.methods["onRender"])
	addEventHandler("onClientClick",root,self.methods["onClick"])
end


function Registerlogin:__onRender ()
	if ( self.data["Activ"] ) then
		if ( self.dx["Background"] ) then 
			--dxDrawImage(0,0,gx,gy,self.dx["Background"])
			dxDrawText("Username:", gx*(657/gpx), gy*(388/gpy), gx*(1022/gpx), gy*(409/gpy), tocolor(255, 255, 255, 255), gx*(1.20/gpx), "default-bold", "center", "center", true, false, true, false, false)
			dxDrawText("Password:", gx*(657/gpx), gy*(484/gpy), gx*(1022/gpx), gy*(505/gpy), tocolor(255, 255, 255, 255), gx*(1.20/gpx), "default-bold", "center", "center", true, false, true, false, false)
			
			dxDrawRectangle(gx*(1166/gpx), gy*(411/gpy), gx*(353/gpx), gy*(232/gpy), tocolor(0, 0, 0, 111), true)
			dxDrawText("Information:\n\nIf you want to play on this server, you have to create an account on our website!\n\nWebsite Adress: example.de\n\nYou can enter the website through the CEF Web-Browser implemented by MTA. Please press the button below. You will be redirected to the website automatically.", gx*(1176/gpx), gy*(411/gpy), gx*(1509/gpx), gy*(563/gpy), tocolor(255, 255, 255, 255), gx*(1.00/gpx), "default-bold", "left", "top", false, true, true, false, false)
		
			if ( Class:__Get("Lib","DX"):__getCursorArea(gx*(631/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy)) ) then
				dxDrawImage(gx*(631/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy), ":"..getThisResource():getName().."/client/images/DX/arrow.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
			else
				dxDrawImage(gx*(631/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy), ":"..getThisResource():getName().."/client/images/DX/arrow.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
			end
			if ( Class:__Get("Lib","DX"):__getCursorArea(gx*(1025/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy)) ) then
				dxDrawImage(gx*(1025/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy), ":"..getThisResource():getName().."/client/images/DX/arrow.png", 180, 0, 0, tocolor(255, 255, 255, 200), true)
			else
				dxDrawImage(gx*(1025/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy), ":"..getThisResource():getName().."/client/images/DX/arrow.png", 180, 0, 0, tocolor(255, 255, 255, 100), true)
			end
		end
	end
end


function Registerlogin:__onClick ( button, state ) 
	if ( button == "left" and state == "down" ) then
		if ( self.data["Activ"] ) then
			if ( #self.data["Profiles"] >= 2 ) then
				if ( Class:__Get("Lib","DX"):__getCursorArea(gx*(631/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy)) ) then
					if ( self.data["Profiles"][self.data["Current_Profile"]-1]) then
						self.data["Current_Profile"] = self.data["Current_Profile"] - 1
					else
						if ( #self.data["Profiles"] >= 2 ) then
							self.data["Current_Profile"] = #self.data["Profiles"]
						end
					end
					self.dx["NameEdit"]:__setText(self.data["Profiles"][self.data["Current_Profile"]]["Username"])
					self.dx["NameEdit"]:__setPermission(self.data["Profiles"][self.data["Current_Profile"]]["Permission"])
					self.dx["PasswordEdit"]:__setText(self.data["Profiles"][self.data["Current_Profile"]]["Password"])
				elseif ( Class:__Get("Lib","DX"):__getCursorArea(gx*(1025/gpx), gy*(417/gpy), gx*(25/gpx), gy*(24/gpy)) ) then
					if ( self.data["Profiles"][self.data["Current_Profile"]+1] ) then
						self.data["Current_Profile"] = self.data["Current_Profile"] + 1
					else
						if ( #self.data["Profiles"] >= 2 ) then
							self.data["Current_Profile"] = 1
						end
					end
					self.dx["NameEdit"]:__setText(self.data["Profiles"][self.data["Current_Profile"]]["Username"])
					self.dx["NameEdit"]:__setPermission(self.data["Profiles"][self.data["Current_Profile"]]["Permission"])
					self.dx["PasswordEdit"]:__setText(self.data["Profiles"][self.data["Current_Profile"]]["Password"])
				end
			end
		end
	end
end

function Registerlogin:__onSubmit ( element )
	if ( element == self.dx["SubmitButton"]:__getElement() ) then
		if ( #self.dx["PasswordEdit"]:__getText() >= 4 ) then
			
		else
			--Message to Player
		end
	elseif ( element == self.dx["CEFButton"]:__getElement() ) then
		Class:__Get("Lib","DX"):__Call("Browser"):__New(gx/2-gx/4, gy/2-gy/4, gx/2, gy/2, true)
	end
end

function Registerlogin:__Destroy ()
	removeEventHandler("onClientRender",root,self.methods["onRender"])
	removeEventHandler("onClientClick",root,self.methods["onClick"])
	self.dx["Background"]:__applyShader("Blur.fx",false)
	self.dx["Background"] = nil
	for k, v in pairs(self.dx) do 
		if ( v ) then
			v:__Destroy()
		end
	end
	self.dx = nil
end

Class:__New("Multigamemode","Registerlogin",Registerlogin)
