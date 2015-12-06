
local Options = pdth_hud.loaded_options
function pdth_hud:Save()
	local fileName = pdth_hud.save_path .. "PDTHHudoptions.txt"
	local file = io.open(fileName, "w+")
	file:write(json.encode(Options))
	file:close()
end

function pdth_hud:Load_options()
	local file = io.open(pdth_hud.save_path .. "PDTHHudoptions.txt", 'r')
	if file == nil then
		local file = io.open(pdth_hud.save_path .. "PDTHHudoptions.ini", 'r')
		if file then
			pdth_hud:Load_options_old()
		end
		dofile(pdth_hud.mod_path .. pdth_hud.writeoptions)
		pdth_hud:Save()
		return
	end
	local file_contents = file:read("*all")
	local data = json.decode( file_contents )
	file:close()
	if data then
		for p, d in pairs(data) do
			Options[p] = d
		end
	end
end

function pdth_hud:Load_options_old()
	local file = io.open(pdth_hud.save_path .. "PDTHHudoptions.ini", 'r')
	if file == nil then
		pdth_hud:Save()
		return
	end
	local key
	for line in file:lines() do
		local loadKey = line:match('^%[([^%[%]]+)%]$')
		if loadKey then
			key = tonumber(loadKey) and tonumber(loadKey) or loadKey
			Options[key] = Options[key] or {}
		end
		local param, val = line:match('^([%w|_]+)%s-=%s-(.+)$')
		if param and val ~= nil then
			if tonumber(val) then
				val = tonumber(val)
			elseif val == "true" then
				val = true
			elseif val == "false" then
				val = false
			end
			if tonumber(param) then
				param = tonumber(param)
			end
			Options[key][param] = val
		end
	end
	file:close()
end