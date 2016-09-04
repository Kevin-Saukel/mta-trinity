--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--

function Player:__Set ( datastring, value, ... )
	if ( datastring ) then
		if ( Class:__Get("Lib","Data"):__Set(self,datastring,value,...) ) then
			return true
		end
	end
	return false
end

function Player:__Get ( datastring )
	if ( datastring ) then
		return Class:__Get("Lib","Data"):__Get(self,datastring)
	end
	return nil
end

function Player:__Spawn ( x, y, z, rot, skin, int, dim, team, fade, r, g, b )
	if ( x and y and z and rot and skin and int and dim ) then
		if ( self:spawn(x,y,z,rot,skin,int,dim,team) ) then
			self:setHealth(100)
			if ( not r ) then
				r = 0
				g = 0
				b = 0
			end
			if ( fade ) then
				self:fadeCamera(true,fade,r,g,b)
				self:setCameraTarget(self)
			end
			return true
		end
	end
	return false
end
