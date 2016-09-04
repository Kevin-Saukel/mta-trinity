--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 31.07.2016 *********--
--*****************************--
local Shader = {}

function Shader:__Constructor ()
	self.shader = {}
	self.method = {}
	self.method["ReplaceTex"] = function(...) self:__replaceTex (...) end
	self.method["BlurTex"] = function(...) self:__blurTex (...) end
end

function Shader:__addShader ( shader, func_link )
	if ( shader ) then
		if ( Class:__Get("Lib","FileUtility"):__Exists(":"..getThisResource():getName().."/client/shader/"..shader) ) then
			self.shader[#self.shader+1] = {}
			self.shader[#self.shader]["Name"] = shader
			self.shader[#self.shader]["Link"] = func_link
			self.shader[#self.shader]["Path"] = ":"..getThisResource():getName().."/client/shader/"..shader
			return true
		end
	end
	return false
end

function Shader:__getShader ( shader ) 
	if ( shader ) then
		local callback = nil
		for k, v in pairs(self.shader) do 
			if ( v["Name"] == shader ) then
				callback = v
				break;
			end
		end
		return callback
	end
	return false
end

function Shader:__applyShader ( shader, ... )
	if ( shader ) then
		local linkshader = self:__getShader(shader)
		if ( linkshader ) then
			if ( linkshader["Link"] ) then
				linkshader["Link"](linkshader,...)
				if ( linkshader["Shader"] ) then
					return linkshader["Shader"] or false
				end
			end
		end
	end
	return nil
end

function Shader:__getMethod ( method )
	if ( method ) then
		if ( self.method[method] ) then
			return self.method[method]
		end
	end
	return nil
end

function Shader:__Destroy ( shader )
	if ( shader ) then
		for k, v in pairs(self.shader) do 
			if ( self.shader[k]["Name"] == shader ) then
				if ( isElement(self.shader[k]["Shader"]) ) then
					self.shader[k]:destroy()
				end
				self.shader[k] = nil
				break;
			end
		end
		return true
	end
	return false
end

--***********************************************************************************************************************************************************************--

function Shader:__replaceTex ( s_link, state, worldModel, tex, targetElement )
	if ( s_link and worldModel ) then
		if ( state ) then
			if ( not s_link["Shader"] ) then
				s_link["Shader"] = DxShader(s_link["Path"])
				s_link["Shader"]:setValue("Tex0",tex)
			end
			s_link["Shader"]:applyToWorldTexture(worldModel,targetElement)
			return s_link["Shader"]
		else
			s_link["Shader"]:removeFromWorldTexture(worldModel,targetElement)
			if ( s_link["Shader"] ) then
				if ( isElement(s_link["Shader"]) ) then
					s_link["Shader"]:destroy()
				end
			end
			return nil
		end	
	end
end

function Shader:__blurTex ( s_link, state, tex, strength, sizea, sizeb )
	if ( s_link ) then
		if ( state ) then
			if ( not s_link["Shader"] ) then
				s_link["Shader"] = DxShader(s_link["Path"])
				s_link["Shader"]:setValue("Image",tex)
				s_link["Shader"]:setValue("Strength",strength)
				s_link["Shader"]:setValue("Size",sizea,sizeb)
			end
			return s_link["Shader"]
		else
			if ( s_link["Shader"] ) then
				if ( isElement(s_link["Shader"]) ) then
					s_link["Shader"]:destroy()
				end
			end
		end
	end
end

--***********************************************************************************************************************************************************************--

Class:__New("Lib","Shader",Shader)