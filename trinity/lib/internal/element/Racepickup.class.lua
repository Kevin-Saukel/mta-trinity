--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 04.08.2016 *********--
--*****************************--

local Racepickup = {}

function Racepickup:__New ( modelid, vector )
	local self = setmetatable({},{__index = self})
	--************************************************************************************************************************************************--
	self.data = {}
	self.data["Element"] = Element("Racepickup")
	self.data["ModelID"] = modelid
	self.data["Vector3"] = vector
	--************************************************************************************************************************************************--
	self.data["Dimension"] = 0
	self.data["Interior"] = 0
	self.data["HitEvent"] = nil
	self.data["HitEventParameters"] = nil
	self.data["HitRadius"] = 3.5
	--************************************************************************************************************************************************--
	self.data["Rotation"] = true
	self.data["Rotation_Timer"] = nil
	--************************************************************************************************************************************************--
	self.data["Pickup"] = Object(modelid,vector,Vector3(0,0,0),false)
	self.data["ColShape"] = ColShape.Sphere(self.data["Vector3"],self.data["HitRadius"])
	--************************************************************************************************************************************************--
	self.methods = {}
	self.methods["executeRotation"] = function() self:executeRotation() end
	self.methods["executeRotation"]()
	self.methods["onHit"] = function ( ... ) self:onHit ( ... ) end
	--************************************************************************************************************************************************--
	self.data["Rotation_Timer"] = Timer(self.methods["executeRotation"],5000,0)
	--************************************************************************************************************************************************--
	addEventHandler("onColShapeHit",self.data["ColShape"],self.methods["onHit"])
	--************************************************************************************************************************************************--
	return self
end

--************************************************************************************************************************************************--

function Racepickup:getDimension ( )
	return self.data["Dimension"]
end

function Racepickup:getElement ( )
	return self.data["Element"]
end

function Racepickup:getInterior ( )
	return self.data["Interior"]
end

function Racepickup:getHitRadius ( )
	return self.data["HitRadius"]
end

function Racepickup:getModel ( )
	return self.data["ModelID"]
end

function Racepickup:getPickup ( )
	return self.data["Pickup"]
end

function Racepickup:getPosition ( )
	return self.data["Vector3"]
end

function Racepickup:getRotationAnimation ( )
	return self.data["Rotation"]
end

--************************************************************************************************************************************************--

function Racepickup:setDimension ( dim ) 
	if ( dim ) then
		self.data["Dimension"] = dim
		self.data["Pickup"]:setDimension(dim)
		self.data["ColShape"]:setDimension(dim)
		return true
	end
	return false
end

function Racepickup:setEvent ( func, ... ) 
	if ( func ) then
		self.data["HitEvent"] = func
		self.data["HitEventParameters"] = {...}
		return true
	end
	return false
end

function Racepickup:setInterior ( int )
	if ( int ) then
		self.data["Interior"] = int
		self.data["Pickup"]:setInterior(int)
		return true
	end
	return false
end

function Racepickup:setHitRadius ( radius ) 
	if ( radius ) then
		self.data["HitRadius"] = radius
		if ( isElement(self.data["ColShape"]) ) then
			removeEventHandler("onColShapeHit",self.data["ColShape"],self.methods["onHit"])
			self.data["ColShape"]:destroy()
		end
		self.data["ColShape"] = ColShape.Sphere(self.data["Vector3"],self.data["HitRadius"])
		self.data["ColShape"]:setDimension(self.data["Dimension"])
		if ( isElement(self.data["ColShape"]) ) then
			addEventHandler("onColShapeHit",self.data["ColShape"],self.methods["onHit"])
			return true
		end
	end
	return false
end

function Racepickup:setPosition ( vector )
	if ( vector ) then
		self.data["Vector3"] = vector
		self.data["Pickup"]:setPosition(vector)
		return true
	end
	return false
end

function Racepickup:setRotationAnimation ( state)
	self.data["Rotation"] = state
	return true
end

--************************************************************************************************************************************************--

function Racepickup:executeRotation ()
	if ( self.data["Rotation"] ) then
		local vector_1 = self.data["Pickup"]:getPosition()
		local vector_2 = Vector3(0,0,360)
		self.data["Pickup"]:move(5000,vector_1,vector_2)
	end
end

--************************************************************************************************************************************************--

function Racepickup:onHit ( hitElement, matchingDimension )
	if ( hitElement and matchingDimension ) then
		if ( self.data["HitEvent"] ) then
			self.data["HitEvent"](hitElement,self.data["HitEventParameters"])
		end
	end
end

--************************************************************************************************************************************************--

function Racepickup:destroy()
	if ( isElement(self.data["Element"]) ) then
		self.data["Element"]:destroy()
	end
	if ( isElement(self.data["Pickup"]) ) then
		self.data["Pickup"]:destroy()
	end
	if ( isElement(self.data["ColShape"]) ) then
		self.data["ColShape"]:destroy()
	end
	if ( self.data["Rotation_Timer"] ) then
		if ( self.data["Rotation_Timer"]:isValid() ) then
			self.data["Rotation_Timer"]:destroy()
		end
	end
	self = nil
	return true
end

Class:__newElementClass("Lib","Racepickup",Racepickup)