--*****************************--
--***** © by Kevin Saukel *****--
--**** All rights reserved ****--
--******** 30.07.2016 *********--
--*****************************--

function table.check ( table, condition )
	local val = true 
	for k, v in pairs(table) do 
		if ( v ~= condition ) then
			val = false
			break
		end
	end
	return val
end

function table.con ( table_1, table_2 )
	local tbl = {}
	if ( not table_1 ) then
		table_1 = {}
	end
	if ( not table_2 ) then
		table_2 = {}
	end
	for k, v in pairs(table_1) do 
		tbl[#tbl+1] = v
	end
	for k, v in pairs(table_2) do 
		tbl[#tbl+1] = v
	end
	return tbl
end

function table.count ( table )
	local counter = 0
	for k, v in pairs(table) do
		counter = counter + 1
	end
	return counter
end

function table.new ( table )
	local newTable = {}
	for k, v in pairs(table) do 
		newTable[#newTable+1] = v
	end
	return newTable
end

function table.switch ( table )
	local newTable = {}
	for k, v in pairs(table) do 
		newTable[v] = k
	end
	return newTable
end

function table.switchNew ( table )
	local newTable = {}
	for k, v in pairs(table) do 
		newTable[#newTable+1] = k
	end
	return newTable
end

--***********************************************--
--***** http://lua-users.org/wiki/CopyTable *****--
--**** All rights reserved **********************--
--******** 30.07.2016 ***************************--
--***********************************************--

function table.copy ( object )
	local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

