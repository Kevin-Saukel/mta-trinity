--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--*** Designs by DarkIrata ****--
--******** 28.03.2016 *********--
--*****************************--

function Racepickup ( ... )
	return Server:__Get("Lib"):__Get("Class"):__Call("Dynamic", "Racepickup", ...)
end

function infobox_func ( element, text, time )
	if ( isElement(element) ) then
		triggerClientEvent(element,"lib.infobox",element,text,time)
	end
end