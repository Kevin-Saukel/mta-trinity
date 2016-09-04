--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--*** Designs by DarkIrata ****--
--******** 28.03.2016 *********--
--*****************************--

function getActionState ( actionHandler )
	if ( actionHandler == "DX" ) then
		return Client:__Get("Lib"):__Get("DX"):__getActionState()
	else
		return false 
	end
	return false
end

function getScreenSource ( )
	local gx, gy = guiGetScreenSize()
	local gpx, gpy = 1366,768
	return gx,gy,gpx,gpy
end

function infobox_func ( text, time )
	local state, lastInit = Client:__Get("Lib"):__Get("DX"):__getInfoboxState()
	if ( state ) then
		if ( lastInit ) then
			lastInit:__Destroy()
		end
	end
	local box = Client:__Get("Lib"):__Get("DX"):__Call("Infobox"):__New(text, time, false, true )
	box:__setImage(":"..getThisResource():getName().."/client/images/DX/Infobox.png")
	box:__setTextPosition(427, 32, 527, 128, 1366, 768)
	box:__Execute()
end
addEvent("lib.infobox",true)
addEventHandler("lib.infobox",root,infobox_func)

function DXButton ( text, x, y, w, h, parent, size )
	if ( not size ) then size = 1 end
	local object = Client:__Get("Lib"):__Get("DX"):__Call("Button"):__New(x, y, w, h, parent, false, 1366, 768 )
	object:__setImage(":"..getThisResource():getName().."/client/images/DX/Button.png",":"..getThisResource():getName().."/client/images/DX/Button_Hover.png" )
	object:__setText(text, size, 100, 100, 100, 255 )
	return object
end

function DXWindow ( x, y, w, h, title )
	local object = Client:__Get("Lib"):__Get("DX"):__Call("Window"):__New(x,y,w,h,title,false,1366,768)
	object:__setImage(":"..getThisResource():getName().."/client/images/DX/Infobox.png")
	return object
end