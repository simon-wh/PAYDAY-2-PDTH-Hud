if not _G.pdth_hud then
	_G.pdth_hud = {}
    pdth_hud.name = "PDTHHudReborn"
	pdth_hud.Options = {}
	pdth_hud.menu_name = "pdth_hud_menu"
	pdth_hud.HUDOptionsMenu = "pdth_hud_hud_options_menu"
	pdth_hud.challenges_menu = "pdth_hud_challenges"
	pdth_hud.active_challenges_menu = "pdth_hud_active_challenges"
	pdth_hud.completed_challenges_menu = "pdth_hud_completed_challenges"
	pdth_hud.portrait_menu = "pdth_hud_portrait_menu"
	pdth_hud.heist_cgrade_name = "pdth_hud_heist_cgrade"
	pdth_hud.mod_path = ModPath
	pdth_hud.addon_path = ModPath .. "addons/"
	pdth_hud.lua_path = ModPath .. "lua/"
	pdth_hud.hook_path = ModPath .. "Hooks/"
	pdth_hud.SavePath = SavePath
    pdth_hud.dofiles = {
        "Constants.lua",
        "PDTHTextures.lua",	
        "PDTHEquipment.lua",
        "DefaultOptions.lua",
        "Options.lua",
        "challengesmanager.lua",
        "challengestweakdata.lua"
    }

    pdth_hud.hook_files = {
        ["lib/units/weapons/newraycastweaponbase"] = "GadgetState.lua",
        ["lib/managers/hud/hudhint"] = "HUDHint.lua",
        ["lib/managers/menu/items/menuitemchallenge"] = "CoreItemChallenges.lua",
        ["lib/managers/hud/hudtemp"] = "Hudtemp.lua",
        --["lib/managers/experiencemanager"] = "ExperienceManager.lua",
        --["lib/units/props/securitycamera"] = "Camera.lua",
        --["lib/units/equipment/sentry_gun/sentrygunbase"] = "SentryGunBase.lua",
        --["lib/units/weapons/trip_mine/tripminebase"] = "TripMineBase.lua",
        ["lib/managers/hud/hudassaultcorner"] = "Assaultindicator.lua",
        ["lib/managers/hud/hudinteraction"] = "Interaction.lua",
        ["lib/managers/hudmanager"] = "Hudmanager.lua",
        ["lib/managers/statisticsmanager"] = "StatsManager.lua",
        ["lib/managers/hudmanagerpd2"] = "Hudmanagerpd2.lua",
        --["lib/managers/blackmarketmanager"] = "BlackMarketManager.lua",
        ["lib/managers/hud/hudteammate"] = "HudTM.lua",
        ["lib/managers/hud/hudpresenter"] = "HudPRESENTER.lua",
        --["lib/managers/menu/menuscenemanager"] = "MenuScene.lua",
        --["core/lib/managers/coreenvironmentcontrollermanager"] = "EnvController.lua",
        ["lib/tweak_data/tweakdata"] = "TweakData.lua",
        --["lib/states/ingameaccesscamera"] = "IGAccessCam.lua"
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

    pdth_hud.portrait_options = {}

    pdth_hud.bullet_style_options = {
        [1] = "off",
        [2] = "normal",
        [3] = "coloured"
    }
end



function pdth_hud:LoadAddons()
    local addons = file.GetFiles(self.addon_path)
    for _, path in pairs(addons) do
        if string.ends(path, "json") then
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
	pdth_hud:LoadOptions()
    pdth_hud:InitConstants()
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
			if pdth_hud.Options.HUD.MainHud then
				for i = 1, 4 do
					if managers.hud then
						managers.hud._teammate_panels[i]:RefreshPortraits()
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
    if MenuSceneManager then
        Hooks:PostHook(MenuSceneManager, "_set_up_environments", "PDTHHudApplyMenuCGrade", function(self)
            for env, data in pairs(self._environments) do
                if data.color_grading then
                    data.color_grading = pdth_hud.colour_gradings[pdth_hud.Options.Menu.Grading]
                end
            end
        end)
    end
    if IngameAccessCamera then
        Hooks:PostHook(IngameAccessCamera, "at_enter", "PDTHHudApplyCameraGrade", function(self)
            if not pdth_hud.Options.HUD.CameraGrading then
                managers.environment_controller:set_default_color_grading(self._saved_default_color_grading)
                managers.environment_controller:refresh_render_settings()
            end
        end)
    end
	
    if HUDChat then
        Hooks:PostHook(HUDChat, "init", "PDTHHudReposChat", function(self)
            self._panel:set_bottom(self._hud_panel:h() - pdth_hud.constants.main_health_h)
        end)
    end
    
    if BlackMarketManager then
        Hooks:PostHook(BlackMarketManager, "save", "PDTHHudSaveChallenges", function(self, data)
            managers.challenges:save(data)
        end)
        Hooks:PostHook(BlackMarketManager, "load", "PDTHHudLoadChallenges", function(self, data)
            managers.challenges:load(data)
        end)
    end
    
    if SecurityCamera then
        Hooks:PostHook(SecurityCamera, "generate_cooldown", "PDTHHudDestroyedCamera", function(self, amount)
            if pdth_hud.Options.HUD.Cameras then
                if managers.job:current_level_id() ~= "safehouse" then
                    managers.hint:show_hint("destroyed_security_camera")
                end
            end
        end)
    end
    
    if ExperienceManager then
        Hooks:PostHook(ExperienceManager, "_level_up", "PDTHHudCheckChallenges", function(self)
            managers.challenges:check_active_challenges()
        end)
    end
    
    if HUDManager and pdth_hud.Options.HUD.MainHud then
        Hooks:PostHook(HUDManager, "set_mugshot_talk", "PDTHHudset_mugshot_talk", function(self, id, active)
            local data = self:_get_mugshot_data(id)
            if not data then
                return
            end
            local i = managers.criminals:character_data_by_name(data.character_name_id).panel_id
            managers.hud._teammate_panels[i]._panel:child("talk"):set_visible(active)
        end)
        
        Hooks:PostHook(HUDManager, "set_mugshot_voice", "PDTHHudset_mugshot_voice", function(self, id, active)
            local data = self:_get_mugshot_data(id)
            if not data then
                return
            end
            local i = managers.criminals:character_data_by_name(data.character_name_id).panel_id
            managers.hud._teammate_panels[i]._panel:child("talk"):set_visible(active)
        end)
        
        Hooks:PostHook(HUDManager, "add_waypoint", "PDTHHudset_mugshot_talk", function(self, id, data)
            self._hud.waypoints[id].arrow:set_color(Color.white)
        
            local distance = self._hud.waypoints[id].distance
            if distance then
                distance:set_color(Color(1, 1, 0.65882355, 0))
            end
        end)
    end
    
	Hooks:Add("BeardLibCreateScriptDataMods", "PDTHHudCallBeardLibSequenceFuncs", function()
		for name, mod_data in pairs(pdth_hud.PDTHEquipment) do
			BeardLib.ScriptData.Sequence:CreateMod(mod_data)
		end
	end)
	
	Hooks:Add("BeardLibCreateScriptDataMods", "PDTHHudEnvironmentTest", function()
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

		--[[BeardLib.ScriptData.Environment:CreateMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day")
		BeardLib.ScriptData.Environment:AddParamMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others/underlay", "core/environments/skies/sky_1846_low_sun_nice_clouds/sky_1846_low_sun_nice_clouds")
        BeardLib.ScriptData.Environment:AddParamMod("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others/sun_ray_color", Vector3(0.7, 0.5, 0.5))
        BeardLib.ScriptData.Environment:AddNewParam("Restoration", "environments/pd2_env_mid_day/pd2_env_mid_day", "others", "this_is_a_faking_test", Vector3(0.7, 0.5, 0.5))]]--

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
        for i = 1, #pdth_hud.portrait_options do
            LocalizationManager:add_localized_strings({
                ["portrait_value_" .. i] = i
            })
        end
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
	
    Hooks:Add("BetterLightFXCreateEvents", "PDTHHudCreateBLFXEvents", function(blfx)
        if blfx then
            blfx:RegisterEvent("AssaultIndicator", {
                priority = 20, 
                loop = false,
                options = {
                    {parameter = "enabled", typ = "bool", localization = "Enabled"},
                },
                run = function(self, ...)
                     coroutine.yield()
                     self._ran_once = true
                end
            }, true)
            
            blfx:RegisterEvent("Interaction", {
                priority = 35, 
                loop = true,
                blend = true,
                _color = Color(1, 1, 0.65882355, 0),
                _use_custom_color = false,
                _custom_color = Color(1, 1, 0.65882355, 0),
                _progress = 0,
                options = {
                    {parameter = "enabled", typ = "bool", localization = "Enabled"},
                    {parameter = "_use_custom_color", typ = "bool", localization = "Use Custom Color"},
                    {parameter = "_custom_color", typ = "color", localization = "Custom Color"},
                },
                run = function(self, ...)
                    if self._use_custom_color then
                        BetterLightFX:SetColor(self._custom_color.red, self._custom_color.green, self._custom_color.blue, self._progress, self.name)
                    else
                        BetterLightFX:SetColor(self._color.red, self._color.green, self._color.blue, self._progress, self.name)
                    end
                    
                     self._ran_once = true
                end
            }, true)
            
            
        end
    end)
    
	Hooks:Add("MenuManagerSetupCustomMenus", "Base_SetupPDTHHudMenu", function( menu_manager, nodes )
		MenuHelper:NewMenu( pdth_hud.menu_name )
		MenuHelper:NewMenu( pdth_hud.HUDOptionsMenu )
		MenuHelper:NewMenu( pdth_hud.heist_cgrade_name )
		MenuHelper:NewMenu( pdth_hud.portrait_menu )
		MenuHelper:NewMenu( pdth_hud.challenges_menu )
		MenuHelper:NewMenu( pdth_hud.active_challenges_menu )
		MenuHelper:NewMenu( pdth_hud.completed_challenges_menu )
	end)

	Hooks:Add("MenuManagerPopulateCustomMenus", "Base_PopulatePDTHHudMenu", function( menu_manager, nodes )
        --Main Menu Elements
        MenuCallbackHandler.PDTHHudToggleHUDOption = function(this, item)
            pdth_hud.Options.HUD[item:name()] = item:value() == "on" and true or false
			pdth_hud:Save()
        end
        
        MenuCallbackHandler.pdth_toggle_cgrading = function(this, item)
			pdth_hud.Options.Menu.Grading = item:value()
			pdth_hud:Save()
            if not managers.job:current_level_id() or (pdth_hud.Options.Grading and not pdth_hud.Options.Grading[managers.job:current_level_id()]) or (pdth_hud.Options.Grading and pdth_hud.Options.Grading[managers.job:current_level_id()] == 1) then
                local selected_grading = pdth_hud.colour_gradings[pdth_hud.Options.Menu.Grading]
                managers.environment_controller:set_default_color_grading(selected_grading)
                managers.environment_controller:refresh_render_settings()
            end
		end
        
        MenuHelper:AddButton({
			id = "hudOptions",
			title = "pdth_hud_hud_options",
			desc = "pdth_hud_hud_options_help",
			next_node = pdth_hud.HUDOptionsMenu,
			menu_id = pdth_hud.menu_name,
			priority = 1000
		})
        
        MenuHelper:AddDivider({
            name = "HUDOptionDiv",
            menu_id = pdth_hud.menu_name,
            size = 20,
            priority = 999
        })
        
        MenuHelper:AddMultipleChoice({
			id = "pdthcgrading",
			title = "pdth_toggle_cgrading_title",
			desc = "pdth_toggle_cgrading_help",
			callback = "pdth_toggle_cgrading",
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.Options.Menu.Grading,
			items = pdth_hud.colour_gradings,
			priority = 998
		})
        
        MenuHelper:AddButton({
			id = "heistCGrading",
			title = "pdth_hud_heist_cgrade_button",
			desc = "pdth_hud_heist_cgrade_hint",
			next_node = pdth_hud.heist_cgrade_name,
			menu_id = pdth_hud.menu_name,
			priority = 997
		})
        
        MenuHelper:AddToggle({
			id = "PDTHEquipment",
			title = "pdth_toggle_equipment_title",
			desc = "pdth_toggle_equipment_help",
			callback = "PDTHHudToggleHUDOption",
			menu_id = pdth_hud.menu_name,
			value = pdth_hud.Options.HUD.Equipment
		})
        
        -- HUD Menu elements
		MenuCallbackHandler.pdth_toggle_pcolor = function(this, item)
			pdth_hud.Options.HUD.Coloured = item:value() == "on" and true or false
			pdth_hud:Save()
			if managers.hud then
				local tm = managers.hud._teammate_panels[4]
				tm._player_panel:child("radial_health_panel"):child("radial_health"):set_color(item:value() == "on" and tm.health_colour or Color.white)
			end
		end
		
		MenuCallbackHandler.pdth_toggle_bullet = function(this, item)
			pdth_hud.Options.HUD.Bullet = item:value()
			pdth_hud:Save()
            if managers.player and managers.hud then
                managers.hud._teammate_panels[4].bulletChanged = true
                local player = managers.player:local_player()
                if player then
                    local inventory = player:inventory()
                    if inventory then
                        for id, weapon in pairs(inventory:available_selections()) do
                            managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
                        end
                    end
                end
            end
		end
        MenuHelper:AddToggle({
			id = "MainHud",
			title = "pdth_toggle_mainhud_title",
			desc = "pdth_toggle_mainhud_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.MainHud,
			priority = 1000
		})
		MenuHelper:AddToggle({
			id = "Assault",
			title = "pdth_toggle_assault_title",
			desc = "pdth_toggle_assault_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Assault,
			priority = 999
		})
		MenuHelper:AddToggle({
			id = "Interaction",
			title = "pdth_toggle_interaction_title",
			desc = "pdth_toggle_interaction_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Interaction,
			priority = 998
		})
		MenuHelper:AddToggle({
			id = "Objectives",
			title = "pdth_toggle_objective_title",
			desc = "pdth_toggle_objective_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Objectives,
			priority = 997
		})
        
        MenuHelper:AddToggle({
			id = "Swansong",
			title = "pdth_toggle_swansong_title",
			desc = "pdth_toggle_swansong_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Swansong,
			priority = 996
		})
        
        MenuHelper:AddDivider({
            name = "mainDivider",
            menu_id = pdth_hud.HUDOptionsMenu,
            size = 20,
            priority = 995
        })
		
        MenuHelper:AddToggle({
			id = "pdthpcoloured",
			title = "pdth_toggle_pcolor_title",
			desc = "pdth_toggle_pcolor_help",
			callback = "pdth_toggle_pcolor",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Coloured,
			priority = 994
		})
		
        
		MenuHelper:AddToggle({
			id = "OGTMHealth",
			title = "pdth_toggle_OGTMHealth_title",
			desc = "pdth_toggle_OGTMHealth_help",
			callback = "PDTHHudToggleHUDOption",
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.OGTMHealth,
            disabled = not nodes.main,
			priority = 993
		})
		
		MenuHelper:AddMultipleChoice({
			id = "pdthbullet",
			title = "pdth_toggle_bullet_title",
			desc = "pdth_toggle_bullet_help",
			callback = "pdth_toggle_bullet",
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Bullet,
			items = pdth_hud.bullet_style_options,
			priority = 992
		})
		
		
        MenuCallbackHandler.pdth_hud_scale = function(this, item)
			pdth_hud.Options.HUD.Scale = item:value()
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
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Scale or 1,
			priority = 991
		})
		
        MenuCallbackHandler.pdth_toggle_firemode = function(this, item)
			pdth_hud.Options.HUD.Fireselector = item:value() == "on" and true or false
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
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Fireselector,
			priority = 990
		})
        
        MenuHelper:AddButton({
			id = "portraitPri",
			title = "pdth_hud_portait_button",
			desc = "pdth_hud_portait_button_hint",
			next_node = pdth_hud.portrait_menu,
			menu_id = pdth_hud.HUDOptionsMenu,
            priority = 989
		})
        
		MenuCallbackHandler.pdth_toggle_portrait = function(this, item)
			pdth_hud.Options.portraits[item:name()] = item:value()
			pdth_hud:Save()
			for i = 1, 4 do 
				if managers.hud then
					local tm = managers.hud._teammate_panels[i]
					tm:RefreshPortraits()
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
				value = pdth_hud.Options.portraits[portrait] or i,
				items = pdth_hud.portrait_value_options,
			})
		end
        
        MenuHelper:AddDivider({
            name = "HUDDivider",
            menu_id = pdth_hud.HUDOptionsMenu,
            size = 20,
            priority = 988
        })
        
        MenuHelper:AddToggle({
			id = "spooky_ammo",
			title = "pdth_toggle_spookyammo_title",
			desc = "pdth_toggle_spookyammo_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.spooky_ammo,
			priority = 987
		})
        
        MenuHelper:AddToggle({
			id = "CameraGrading",
			title = "pdth_toggle_camgrading_title",
			desc = "pdth_toggle_camgrading_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.CameraGrading,
			priority = 986
		})
		
		MenuHelper:AddToggle({
			id = "Gadget",
			title = "pdth_toggle_gadget_title",
			desc = "pdth_toggle_gadget_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Gadget,
			priority = 985
		})
        
		MenuHelper:AddToggle({
			id = "Cameras",
			title = "pdth_toggle_camera_title",
			desc = "pdth_toggle_camera_help",
			callback = "PDTHHudToggleHUDOption",
			icon_by_text = false,
			menu_id = pdth_hud.HUDOptionsMenu,
			value = pdth_hud.Options.HUD.Cameras,
			priority = 984
		})
        
        --Heist Colour Grading
		MenuCallbackHandler.pdth_heist_cgrade_change = function(this, item)
            pdth_hud.Options.Grading = pdth_hud.Options.Grading or {}
			pdth_hud.Options.Grading[item:name()] = item:value()
			tweak_data.levels[item:name()].env_params = tweak_data.levels[item:name()].env_params or {}
			if item:value() == 1 then
				tweak_data.levels[item:name()].env_params.color_grading = pdth_hud.colour_gradings[pdth_hud.Options.Menu.Grading]
			else
				tweak_data.levels[item:name()].env_params.color_grading = pdth_hud.heist_colour_gradings[item:value()]
			end
			if managers.job:current_level_id() == item:name() then
				managers.environment_controller:set_default_color_grading(tweak_data.levels[item:name()].env_params.color_grading)
				managers.environment_controller:refresh_render_settings()
			end
			pdth_hud:Save()
		end
		local level_index = deep_clone(tweak_data.levels._level_index)
        local removeLevels = {"mia2_new"}
        for _, level in pairs(removeLevels) do
            table.delete(level_index, level)
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
				title = managers.localization:exists(tweak_data.levels[level_index[i]].name_id) and managers.localization:text(tweak_data.levels[level_index[i]].name_id) .. (is_night and " Night" or "") .. (is_day and " Day" or "") or level_index[i],
				callback = "pdth_heist_cgrade_change",
				menu_id = pdth_hud.heist_cgrade_name,
				value = pdth_hud.Options.Grading and pdth_hud.Options.Grading[level_index[i]] or 2,
				items = pdth_hud.heist_colour_gradings,
				localized = "false",
				priority = 0
			})
		end
		
        --Challenges stuff
        
		MenuCallbackHandler.active_Challenges_callback = function(this, item)
			pdth_hud:refresh_active_challenges(pdth_hud.active_challenges_node)
		end
		MenuHelper:AddButton({
			id = "active_challenges",
			title = "pdth_hud_active_challenges",
			desc = "pdth_hud_active_challenges_hint",
			callback = "active_Challenges_callback",
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
			next_node = pdth_hud.completed_challenges_menu,
			menu_id = pdth_hud.challenges_menu,
			--priority = 2
		})
	end)
	 
	Hooks:Add("MenuManagerBuildCustomMenus", "Base_BuildPDTHHudMenu", function(menu_manager, nodes)
		nodes[pdth_hud.menu_name] = MenuHelper:BuildMenu(pdth_hud.menu_name)
		MenuHelper:AddMenuItem(MenuHelper.menus.lua_mod_options_menu, pdth_hud.menu_name, "pdth_hud_button", "pdth_hud_hint", 1)
        
        nodes[pdth_hud.HUDOptionsMenu] = MenuHelper:BuildMenu(pdth_hud.HUDOptionsMenu)
		nodes[pdth_hud.heist_cgrade_name] = MenuHelper:BuildMenu(pdth_hud.heist_cgrade_name)
		nodes[pdth_hud.portrait_menu] = MenuHelper:BuildMenu(pdth_hud.portrait_menu)
		
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
		local title_text = managers.challenges:get_title_text(data.id)
		local description_text = managers.challenges:get_description_text(data.id)
		local params = {
			name = data.id,
			text_id	= string.upper(title_text),
			description_text = string.upper(description_text),
			localize = "false",
			challenge = data.id,
		}
		local new_item = node:create_item({type = "MenuItemChallenge"}, params)
		node:add_item(new_item)
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