if not _G.pdth_hud then
	_G.pdth_hud = {}
	pdth_hud.newversion = {}
	pdth_hud.loaded_options = {}
	pdth_hud.show_thing = true
	pdth_hud.log = {}
	pdth_hud.log_no = 1
	pdth_hud.menu_name = "pdth_hud_menu"
	pdth_hud.challenges_menu = "pdth_hud_challenges"
	pdth_hud.active_challenges_menu = "pdth_hud_active_challenges"
	pdth_hud.completed_challenges_menu = "pdth_hud_completed_challenges"
	pdth_hud.portrait_menu = "pdth_hud_portrait_menu"
	pdth_hud.heist_cgrade_name = "pdth_hud_heist_cgrade"
	pdth_hud.write_options = pdth_hud.write_options or {}
	if not pdth_hud._first_boot then
		pdth_hud._first_boot = 0
	end
	pdth_hud.mod_path = ModPath
	pdth_hud.addon_path = ModPath .. "addons/"
	pdth_hud.lua_path = ModPath .. "lua/"
	pdth_hud.hook_path = ModPath .. "Hooks/"
	pdth_hud.save_path = SavePath
end

pdth_hud.dofiles = {
	"PDTHTextures.lua",
	"Options.lua",
	--"WriteOptions.lua",
	"challengesmanager.lua",
	"PDTHEquipment.lua",
	"challengestweakdata.lua",
    "BetterLightFX.lua"
}

pdth_hud.writeoptions = "WriteOptions.lua"

pdth_hud.hook_files = {
	["lib/units/weapons/newraycastweaponbase"] = "GadgetState.lua",
	["lib/managers/hud/hudhint"] = "HUDHint.lua",
	["lib/managers/menu/items/menuitemchallenge"] = "CoreItemChallenges.lua",
	["lib/managers/hud/hudtemp"] = "Hudtemp.lua",
	["lib/managers/experiencemanager"] = "ExperienceManager.lua",
	["lib/units/props/securitycamera"] = "Camera.lua",
	["lib/units/equipment/sentry_gun/sentrygunbase"] = "SentryGunBase.lua",
	["lib/units/weapons/trip_mine/tripminebase"] = "TripMineBase.lua",
	["lib/managers/hud/hudassaultcorner"] = "Assaultindicator.lua",
	["lib/managers/hud/hudinteraction"] = "Interaction.lua",
	["lib/managers/hudmanager"] = "Hudmanager.lua",
	["lib/managers/statisticsmanager"] = "StatsManager.lua",
	["lib/managers/hudmanagerpd2"] = "Hudmanagerpd2.lua",
	["lib/managers/blackmarketmanager"] = "BlackMarketManager.lua",
	["lib/managers/hud/hudteammate"] = "HudTM.lua",
	["lib/managers/hud/hudpresenter"] = "HudPRESENTER.lua",
	["lib/managers/menu/menuscenemanager"] = "MenuScene.lua",
	["core/lib/managers/coreenvironmentcontrollermanager"] = "EnvController.lua",
	["lib/tweak_data/tweakdata"] = "TweakData.lua",
    ["lib/network/matchmaking/networkaccountsteam"] = "NetworkAccountSteam.lua",
    ["lib/managers/group_ai_states/groupaistatebase"] = "GroupAIStateBase.lua",
    ["lib/managers/hud/hudsuspicion"] = "HudSuspicion.lua",
    ["lib/units/beings/player/playerdamage"] = "PlayerDamage.lua",
    ["lib/states/missionendstate"] = "MissionEndState.lua"
}

pdth_hud.colour_gradings = {
	[1] = "color_payday",
	[2] = "color_heat",
	[3] = "color_nice",
	[4] = "color_sin",
	[5] = "color_bhd",
	[6] = "color_xgen",
	[7] = "color_xxxgen",
	[8] = "color_matrix",
}
pdth_hud.heist_colour_gradings = {
	[1] = "color_main",
	[2] = "color_payday",
	[3] = "color_heat",
	[4] = "color_nice",
	[5] = "color_sin",
	[6] = "color_bhd",
	[7] = "color_xgen",
	[8] = "color_xxxgen",
	[9] = "color_matrix",
}

pdth_hud.portrait_options = pdth_hud.portrait_options or {
	[1] = "default",
	[2] = "white",
	[3] = "pdth",
	[4] = "foster"
}

pdth_hud.bullet_style_options = {
	[1] = "off",
	[2] = "normal",
	[3] = "coloured"
}

function pdth_hud:LoadAddons()
    local addons = file.GetFiles(self.addon_path)
    for _, path in pairs(addons) do
        if string.ends(path, "json") then
            log(path)
            local file = io.open(self.addon_path .. path, "r")
            local file_contents = file:read("*all")
            local data = json.decode( file_contents )
            pdth_hud.textures:ProcessAddon(data)
            file:close()
        end
    end
    
    pdth_hud.portrait_value_options = pdth_hud.portrait_value_options or {}
    for i, portait in pairs(pdth_hud.portrait_options) do
        pdth_hud.portrait_value_options[i] = "portrait_value_" .. i
    end
end

if not pdth_hud.setup then
	for p, d in pairs(pdth_hud.dofiles) do
		dofile(pdth_hud.lua_path .. d)
	end
	pdth_hud:Load_options()
    pdth_hud:LoadAddons()
	dofile(pdth_hud.lua_path .. pdth_hud.writeoptions)
	pdth_hud.setup = true
end

if RequiredScript then
	local requiredScript = RequiredScript:lower()
	if pdth_hud.hook_files[requiredScript] then
		dofile( pdth_hud.hook_path .. pdth_hud.hook_files[requiredScript] )
	end
end

function pdth_hud:log(string)
	log("PDTH Hud: " .. string)
end

if Hooks then
	if Setup then
		Hooks:PostHook(Setup, "init_managers", "pdth_hud_define_challenges", function(ply)
			tweak_data.challenges = ChallengesTweakData:new()
			managers.challenges = ChallengesManager:new()
		end)
	end
	if HUDAssaultCorner then
		Hooks:PostHook(HUDAssaultCorner, "_start_assault", "pdth_hud_hide_suspicion", function(ply)
			if alive(managers.hud._hud_suspicion._suspicion_panel) then
				managers.hud._hud_suspicion._suspicion_panel:set_visible(false)
			end
		end)
	end
	if MenuSetup then
		Hooks:PostHook(MenuSetup, "init_managers", "pdth_hud_define_challenges_menu", function(ply)
			tweak_data.challenges = ChallengesTweakData:new()
			managers.challenges = ChallengesManager:new()
		end)
	end
	if CriminalsManager then
		Hooks:PostHook(CriminalsManager, "add_character", "pdth_hud_ai_portrait", function(ply)
			if pdth_hud.loaded_options.Ingame.MainHud then
				for i = 1, 4 do
					if managers.hud then
						managers.hud._teammate_panels[i]:set_ai_portrait()
					end
				end
			end
		end)
	end
	if MenuManager then
		Hooks:PostHook(MenuManager, "do_clear_progress", "pdth_hud_reset_challenges", function(ply)
			managers.challenges:reset_challenges()
		end)
	end

	
	
	Hooks:Add("BeardLibSequencePostInit", "PDTHHudCallBeardLibSequenceFuncs", function()
		for name, mod_data in pairs(pdth_hud.PDTHEquipment) do
			BeardLib.ScriptData.Sequence:CreateMod("PDTH Hud", name, mod_data)
		end
	end)
	
	Hooks:Add("BeardLibSequencePostInit", "PDTHHudEnvironmentTest", function()
		-- EnvironmentFile, MOD ID, Initial Data
		--[[BeardLib:CreateEnvMod("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", {})
		
		-- EnvironmentFile, MOD ID, EnvGroupMeta, Param Mod Table (This is for multiple param mods in the same EnvGroup, structure is ParamKey = NewParamValue)
		BeardLib:AddEnvParamMods("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", "cloud_overlay", { color_sun_scale = 0 })
		
		-- EnvironmentFile, MOD ID, EnvGroupMeta, Param Key, New Param Value (For a singular mod)
		BeardLib:AddEnvParamMod("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", "cloud_overlay", "color_sun", Vector3(0, 0, 0))
		BeardLib:AddEnvParamMod("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", "others", "sun_ray_color", Vector3(0, 0, 0))
		
		-- EnvironmentFile, MOD ID, EnvGroupMeta, New Param Key, New Param Value
		BeardLib:AddEnvNewParam("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", "cloud_overlay", "test_value", 69)
		
		-- EnvironmentFile, MOD ID, EnvGroupMeta, NewGroupTable(Probably want to look how they are made in the json decode)
		BeardLib:AddEnvNewGroup("environments/pd2_env_mid_day/pd2_env_mid_day", "PDTH Hud", "underlay_effect", { _meta = "test_group"})]]--
		--[[if not managers.dyn_resource:has_resource(Idstring("scene"), Idstring("core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds"), managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
			log("not loaded")
			managers.dyn_resource:load(Idstring("scene"), Idstring("core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds"), managers.dyn_resource.DYN_RESOURCES_PACKAGE, nil)
		end]]--

		BeardLib.ScriptData.Environment:CreateMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", {})
		BeardLib.ScriptData.Environment:AddParamMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others/underlay", "core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds")
        BeardLib.ScriptData.Environment:AddParamMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others/sun_ray_color", Vector3(0.7, 0.5, 0.5))
        BeardLib.ScriptData.Environment:AddNewParam("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others", "this_is_a_faking_test", Vector3(0.7, 0.5, 0.5))

	end)
	
	Hooks:Add("BeardLibPreProcessScriptData", "PDTHHudEnvironmentTest", function(PackManager, path, raw_data)
		if managers.dyn_resource then
			if not managers.dyn_resource:has_resource(Idstring("scene"), Idstring("core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds"), managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
				log("not loaded")
				managers.dyn_resource:load(Idstring("scene"), Idstring("core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds"), managers.dyn_resource.DYN_RESOURCES_PACKAGE, nil)
			end
		end
	end)
	
	Hooks:Add("LocalizationManagerPostInit", "PDTH_Localization", function(loc)
		if Idstring("russian"):key() == SystemInfo:language():key() then
			LocalizationManager:load_localization_file(pdth_hud.mod_path ..  "/Localization/russian.txt" )
		elseif Idstring("german"):key() == SystemInfo:language():key() then
			LocalizationManager:load_localization_file(pdth_hud.mod_path ..  "/Localization/german.txt" )
		elseif Idstring("french"):key() == SystemInfo:language():key() then
			LocalizationManager:load_localization_file(pdth_hud.mod_path ..  "/Localization/french.txt" )
		elseif Idstring("dutch"):key() == SystemInfo:language():key() then
			LocalizationManager:load_localization_file(pdth_hud.mod_path ..  "/Localization/dutch.txt" )
		else
			LocalizationManager:load_localization_file(pdth_hud.mod_path ..  "/Localization/english.txt" )
		end
		LocalizationManager:add_localized_strings({
			["portrait_value_1"] = "1",
			["portrait_value_2"] = "2",
			["portrait_value_3"] = "3",
			["portrait_value_4"] = "4",
			["portrait_value_5"] = "5",
			["portrait_value_6"] = "6",
			["portrait_value_7"] = "7",
			["portrait_value_8"] = "8",
			["portrait_value_9"] = "9",
		})
	end)
	
	Hooks:Add("StatisticsManagerKilledByAnyone", "PDTHHudStatisticsManagerKilledByAnyone", function( self, data )
		local by_explosion = data.variant == "explosion"
		local name_id = data.weapon_unit and data.weapon_unit:base() and data.weapon_unit:base():get_name_id()
		if by_explosion and data.name == "patrol" and name_id ~= "m79" then
			self._patrol_bombed = self._patrol_bombed and self._patrol_bombed + 1 or 1
			if self._patrol_bombed >= 12 and Global.level_data.level_id == "diamond_heist" then
				managers.challenges:set_flag( "bomb_man" )
			end
		end
	end)
	
	Hooks:Add("MenuManagerSetupCustomMenus", "Base_SetupPDTHHudMenu", function( menu_manager, nodes )
		MenuHelper:NewMenu( pdth_hud.menu_name )
		MenuHelper:NewMenu( pdth_hud.heist_cgrade_name )
		MenuHelper:NewMenu( pdth_hud.portrait_menu )
		MenuHelper:NewMenu( pdth_hud.challenges_menu )
		MenuHelper:NewMenu( pdth_hud.active_challenges_menu )
		MenuHelper:NewMenu( pdth_hud.completed_challenges_menu )
	end)

	Hooks:Add("MenuManagerPopulateCustomMenus", "Base_PopulatePDTHHudMenu", function( menu_manager, nodes )
		MenuCallbackHandler.pdth_toggle_pcolor = function(this, item)
			pdth_hud.loaded_options.Ingame.Coloured = item:value() == "on" and true or false
			pdth_hud:Save()
			for i = 1, 4 do 
				if managers.hud then
					local tm = managers.hud._teammate_panels[i]
					local colour = pdth_hud.colour_amount < 0.33 and Color(1, 0, 0) or Color(0.5, 0.8, 0.4)
					tm._player_panel:child("radial_health_panel"):child("radial_health"):set_color(item:value() == "on" and colour or Color(1, 1, 1))
				end
			end
		end
		MenuCallbackHandler.pdth_toggle_camera = function(this, item)
			pdth_hud.loaded_options.Ingame.Cameras = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_assault = function(this, item)
			pdth_hud.loaded_options.Ingame.Assault = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_interaction = function(this, item)
			pdth_hud.loaded_options.Ingame.Interaction = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_objective = function(this, item)
			pdth_hud.loaded_options.Ingame.Objectives = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_gadget = function(this, item)
			pdth_hud.loaded_options.Ingame.Gadget = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_swansong = function(this, item)
			pdth_hud.loaded_options.Ingame.Swansong = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_camgrading = function(this, item)
			pdth_hud.loaded_options.Ingame.CameraGrading = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		MenuCallbackHandler.pdth_toggle_cgrading = function(this, item)
			pdth_hud.loaded_options.Menu.Grading = item:value()
			pdth_hud:Save()
			local selected_grading = pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading]
			managers.environment_controller:set_default_color_grading(selected_grading)
			managers.environment_controller:refresh_render_settings()
		end
		
		MenuCallbackHandler.pdth_toggle_bullet = function(this, item)
			pdth_hud.loaded_options.Ingame.Bullet = item:value()
			pdth_hud:Save()
			if managers.hud then
				local tm = managers.hud._teammate_panels[4]
				tm:bullet_changed()
			end
		end
		
		MenuHelper:AddToggle({
			id = "pdthpcoloured",
			title = "pdth_toggle_pcolor_title",
			desc = "pdth_toggle_pcolor_help",
			callback = "pdth_toggle_pcolor",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Coloured,
			priority = 1006
		})
		
		MenuHelper:AddToggle({
			id = "pdthcamera",
			title = "pdth_toggle_camera_title",
			desc = "pdth_toggle_camera_help",
			callback = "pdth_toggle_camera",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Cameras,
			priority = 1001
		})
		MenuHelper:AddToggle({
			id = "pdthassault",
			title = "pdth_toggle_assault_title",
			desc = "pdth_toggle_assault_help",
			callback = "pdth_toggle_assault",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Assault,
			--priority = 0
		})
		MenuHelper:AddToggle({
			id = "pdthinteraction",
			title = "pdth_toggle_interaction_title",
			desc = "pdth_toggle_interaction_help",
			callback = "pdth_toggle_interaction",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Interaction,
			--priority = 0
		})
		MenuHelper:AddToggle({
			id = "pdthobjective",
			title = "pdth_toggle_objective_title",
			desc = "pdth_toggle_objective_help",
			callback = "pdth_toggle_objective",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Objectives,
			--priority = 0
		})
		MenuHelper:AddToggle({
			id = "pdthgadget",
			title = "pdth_toggle_gadget_title",
			desc = "pdth_toggle_gadget_help",
			callback = "pdth_toggle_gadget",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Gadget,
			priority = 1002
		})
		MenuHelper:AddToggle({
			id = "pdthswansong",
			title = "pdth_toggle_swansong_title",
			desc = "pdth_toggle_swansong_help",
			callback = "pdth_toggle_swansong",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Swansong,
			priority = 1003
		})
		--[[MenuHelper:AddMultipleChoice({
			id = "pdthportrait",
			title = "pdth_toggle_portrait_title",
			desc = "pdth_toggle_portrait_help",
			callback = "pdth_toggle_portrait",
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Portrait,
			items = pdth_hud.portrait_options,
			priority = 1005
		})]]--
		MenuHelper:AddMultipleChoice({
			id = "pdthcgrading",
			title = "pdth_toggle_cgrading_title",
			desc = "pdth_toggle_cgrading_help",
			callback = "pdth_toggle_cgrading",
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Menu.Grading,
			items = pdth_hud.colour_gradings,
			priority = 1007
		})
		MenuHelper:AddMultipleChoice({
			id = "pdthbullet",
			title = "pdth_toggle_bullet_title",
			desc = "pdth_toggle_bullet_help",
			callback = "pdth_toggle_bullet",
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Bullet,
			items = pdth_hud.bullet_style_options,
			priority = 1004
		})
		
		MenuHelper:AddToggle({
			id = "pdthcameragrade",
			title = "pdth_toggle_camgrading_title",
			desc = "pdth_toggle_camgrading_help",
			callback = "pdth_toggle_camgrading",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.CameraGrading,
			priority = 1009
		})
		MenuCallbackHandler.pdth_toggle_mainhud = function(this, item)
			pdth_hud.loaded_options.Ingame.MainHud = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		
		MenuHelper:AddToggle({
			id = "pdthmainhud",
			title = "pdth_toggle_mainhud_title",
			desc = "pdth_toggle_mainhud_help",
			callback = "pdth_toggle_mainhud",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.MainHud,
			--priority = 0
		})
		
		MenuCallbackHandler.pdth_heist_cgrade_change = function(this, item)
			pdth_hud.loaded_options.Grading[item:name()] = item:value()
			--tweak_data.levels[item:name()].env_params = tweak_data.levels[item:name()].env_params or {}
			--[[if item:value() == 2 then
				tweak_data.levels[item:name()].env_params.color_grading = pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading]
			else
				tweak_data.levels[item:name()].env_params.color_grading = pdth_hud.heist_colour_gradings[item:value()]
			end]]--
			if managers.job:current_level_id() == item:name() then
				managers.environment_controller:set_default_color_grading(tweak_data.levels[item:name()].env_params.color_grading)
				managers.environment_controller:refresh_render_settings()
			end
			pdth_hud:Save()
		end
		local level_index = deep_clone(tweak_data.levels._level_index)
		--table.remove(level_index, "mia2_new")
		for p, k in pairs(level_index) do
			if k == "mia2_new" then
				table.remove(level_index, p)
			end
		
		end
		for i = 1, #level_index do
			local is_night = false
			local is_day = false
			if string.find(level_index[i], "_night") then
				is_night = true
			end
			if string.find(level_index[i], "_day") then
				is_day = true
			end
			MenuHelper:AddMultipleChoice({
				id = level_index[i],
				title = managers.localization:exists(tweak_data.levels[level_index[i]].name_id) and managers.localization:text(tweak_data.levels[level_index[i]].name_id) .. (is_night and " Night" or "") .. (is_day and " Day" or "") or managers.localization:text("pdth_cgrade_title_" .. level_index[i]),
				--desc = "pdth_cgrade_help_" .. tweak_data.levels._level_index[i],
				callback = "pdth_heist_cgrade_change",
				menu_id = pdth_hud.heist_cgrade_name,
				value = pdth_hud.loaded_options.Grading[level_index[i]] or 2,
				items = pdth_hud.heist_colour_gradings,
				localized = "false",
				priority = 0
			})
		end
		if tweak_data then
			for i = 1, #tweak_data.levels._level_index do
				tweak_data.levels[tweak_data.levels._level_index[i]].env_params = tweak_data.levels[tweak_data.levels._level_index[i]].env_params or {}
				if pdth_hud.loaded_options.Grading[tweak_data.levels._level_index[i]] == 2 then
					tweak_data.levels[tweak_data.levels._level_index[i]].env_params.color_grading = pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading]
				else
					tweak_data.levels[tweak_data.levels._level_index[i]].env_params.color_grading = pdth_hud.heist_colour_gradings[pdth_hud.loaded_options.Grading[tweak_data.levels._level_index[i]]]
				end
			end
		end
		
		MenuCallbackHandler.pdth_toggle_firemode = function(this, item)
			pdth_hud.loaded_options.Ingame.Fireselector = item:value() == "on" and true or false
			pdth_hud:Save()
			if managers.hud then
				local tm = managers.hud._teammate_panels[4]
				tm:recreate_weapon_firemode()
			end
		end
		
		MenuHelper:AddToggle({
			id = "pdthfiremode",
			title = "pdth_toggle_firemode_title",
			desc = "pdth_toggle_firemode_help",
			callback = "pdth_toggle_firemode",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Fireselector,
			priority = 1001
		})
		MenuCallbackHandler.active_Challenges_callback = function(this, item)
			pdth_hud:refresh_active_challenges(pdth_hud.active_challenges_node)
		end
		MenuHelper:AddButton({
			id = "active_challenges",
			title = "pdth_hud_active_challenges",
			desc = "pdth_hud_active_challenges_hint",
			callback = "active_Challenges_callback",
			--back_callback = ,
			next_node = pdth_hud.active_challenges_menu,
			menu_id = pdth_hud.challenges_menu,
			priority = 1
		})
		
		MenuCallbackHandler.completed_Challenges_callback = function(this, item)
			pdth_hud:refresh_completed_challenges(pdth_hud.completed_challenges_node)
		end
		MenuHelper:AddButton({
			id = "completed_challenges",
			title = "pdth_hud_completed_challenges",
			desc = "pdth_hud_completed_challenges_hint",
			callback = "completed_Challenges_callback",
			--back_callback = ,
			next_node = pdth_hud.completed_challenges_menu,
			menu_id = pdth_hud.challenges_menu,
			--priority = 2
		})

		MenuCallbackHandler.pdth_hud_scale = function(this, item)
			pdth_hud.loaded_options.Ingame.Hud_scale = item:value()
			pdth_hud:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 2,
			step = 0.05,
			show_value = true,
			id = "PDTHHUDScale",
			title = "pdth_hud_scale_title",
			desc = "pdth_hud_scale_help",
			callback = "pdth_hud_scale",
			--disabled_color = ,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.Hud_scale or 1
			--priority = 
		})
		
		MenuCallbackHandler.pdth_toggle_spooky_ammo = function(this, item)
			pdth_hud.loaded_options.Ingame.spooky_ammo = item:value() == "on" and true or false
			pdth_hud:Save()
		end
		
		MenuHelper:AddToggle({
			id = "pdthspookyammo",
			title = "pdth_toggle_spookyammo_title",
			desc = "pdth_toggle_spookyammo_help",
			callback = "pdth_toggle_spooky_ammo",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.loaded_options.Ingame.spooky_ammo,
			priority = 1001
		})
		
		MenuCallbackHandler.pdth_toggle_portrait = function(this, item)
			pdth_hud.loaded_options.portraits[item:name()] = item:value()
			pdth_hud:Save()
			for i = 1, 4 do 
				if managers.hud then
					local tm = managers.hud._teammate_panels[i]
					tm:portrait_changed()
				end
			end
		end
		
		for i, portrait in pairs(pdth_hud.portrait_options) do
			MenuHelper:AddMultipleChoice({
				id = portrait,
				title = "pdth_" .. portrait,
				desc = "pdth_toggle_portrait_global_help",
				callback = "pdth_toggle_portrait",
				menu_id = pdth_hud.portrait_menu,
				value = pdth_hud.loaded_options.portraits[portrait] or i,
				items = pdth_hud.portrait_value_options,
				--priority = 0
			})
		end
	end)
	 
	Hooks:Add("MenuManagerBuildCustomMenus", "Base_BuildPDTHHudMenu", function(menu_manager, nodes)
		nodes[pdth_hud.menu_name] = MenuHelper:BuildMenu(pdth_hud.menu_name)
		MenuHelper:AddMenuItem(MenuHelper.menus.lua_mod_options_menu, pdth_hud.menu_name, "pdth_hud_button", "pdth_hud_hint", 1)
		
		nodes[pdth_hud.heist_cgrade_name] = MenuHelper:BuildMenu(pdth_hud.heist_cgrade_name)
		MenuHelper:AddMenuItem(MenuHelper.menus[pdth_hud.menu_name], pdth_hud.heist_cgrade_name, "pdth_hud_heist_cgrade_button", "pdth_hud_heist_cgrade_hint", 3)
		
		nodes[pdth_hud.portrait_menu] = MenuHelper:BuildMenu(pdth_hud.portrait_menu)
		MenuHelper:AddMenuItem(MenuHelper.menus[pdth_hud.menu_name], pdth_hud.portrait_menu, "pdth_hud_portait_button", "pdth_hud_portait_button_hint", 4)
		
		nodes[pdth_hud.challenges_menu] = MenuHelper:BuildMenu(pdth_hud.challenges_menu)
		MenuHelper:AddMenuItem(nodes.main or nodes.pause, pdth_hud.challenges_menu, "pdth_hud_challenges", "pdth_hud_challenges_hint", "fbi_files", "after")
		if nodes.lobby then
			MenuHelper:AddMenuItem(nodes.lobby, pdth_hud.challenges_menu, "pdth_hud_challenges", "pdth_hud_challenges_hint", "fbi_files", "after")
		end
		
		nodes[pdth_hud.active_challenges_menu] = MenuHelper:BuildMenu(pdth_hud.active_challenges_menu)
		pdth_hud.active_challenges_node = nodes[pdth_hud.active_challenges_menu]
		
		nodes[pdth_hud.completed_challenges_menu] = MenuHelper:BuildMenu(pdth_hud.completed_challenges_menu)
		pdth_hud.completed_challenges_node = nodes[pdth_hud.completed_challenges_menu]	
	end)
end

function pdth_hud:refresh_active_challenges(node)
	if node == nil then
		return
	end
	node:clean_items()
	for _,data in pairs(managers.challenges:get_near_completion()) do
		--if data.count > 1 then
		local title_text = managers.challenges:get_title_text(data.id)
		local description_text = managers.challenges:get_description_text(data.id)
		local params = {
			name = data.id,
			text_id	= string.upper(title_text),
			description_text = string.upper(description_text),
			localize = "false",
			challenge = data.id,
			--count = data.count,
			--callback = "debug_modify_challenge",
		}
		local new_item = node:create_item({type = "MenuItemChallenge"}, params)
		node:add_item(new_item)
		--end
	end
	managers.menu:add_back_button(node)
end

function pdth_hud:refresh_completed_challenges(node)
	if node == nil then
		return
	end
	node:clean_items()
	for _,data in pairs(managers.challenges:get_completed()) do
		local params = {
				name = data.id,
				text_id	= string.upper(data.name),
				description_text = string.upper(data.description),
				localize = "false",
				challenge = data.id,
				awarded	= true
			}
		local new_item = node:create_item({type = "MenuItemChallenge"}, params)
		node:add_item(new_item)
	end
	managers.menu:add_back_button(node)
end