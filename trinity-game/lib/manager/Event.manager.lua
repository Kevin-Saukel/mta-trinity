--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

local Event = {}

function Event:__Constructor ()
	self.event = {}
	self.cancel = {}
end

function Event:__Add ( event, trigger )
	if ( event ) then
		if ( not self.event[event] ) then
			self.event[event] = addEvent(event,trigger)
			self.cancel[event] = false
			return true
		end
	end
	return false
end

function Event:__getCanceledEvent ( event )
	if ( self.event[event] ) then
		if ( self.cancel[event] ) then
			return true
		end
	end
	return false
end

function Event:__getCanceledEvents ()
	local counter = 0
	for k, v in pairs(self.cancel) do 
		if ( v ) then
			counter = counter + 1
		end
	end
	return counter
end

function Event:__Cancel ( event )
	if ( self.event[event] ) then
		if ( not self.cancel[event] ) then
			self.cancel[event] = true
			addEventHandler(event,getRootElement(),cancelEvent)
			return true
		end
	end
	return false
end

function Event:__Uncancel ( event )
	if ( self.event[event] ) then
		if ( self.cancel[event] ) then
			self.cancel[event] = false
			removeEventHandler(event,getRootElement(),cancelEvent)
			return true
		end
	end
	return false
end

Class:__New("Lib","Event",Event)
