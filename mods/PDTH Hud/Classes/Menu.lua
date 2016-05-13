
pdth_hud.menu_name = "pdth_hud_menu"
pdth_hud.HUDOptionsMenu = "pdth_hud_hud_options_menu"
pdth_hud.challenges_menu = "pdth_hud_challenges"
pdth_hud.active_challenges_menu = "pdth_hud_active_challenges"
pdth_hud.completed_challenges_menu = "pdth_hud_completed_challenges"
pdth_hud.portrait_menu = "pdth_hud_portrait_menu"
pdth_hud.heist_cgrade_name = "pdth_hud_heist_cgrade"

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

    local disabled = true
    if BeardLib then
        disabled = false
    end

    MenuHelper:AddToggle({
        id = "Equipment",
        title = "pdth_toggle_equipment_title",
        desc = "pdth_toggle_equipment_help",
        callback = "PDTHHudToggleHUDOption",
        menu_id = pdth_hud.menu_name,
        disabled = disabled,
        value = pdth_hud.Options.HUD.Equipment
    })

    -- HUD Menu elements
    MenuCallbackHandler.pdth_toggle_pcolor = function(this, item)
        pdth_hud.Options.HUD.Coloured = item:value() == "on" and true or false
        pdth_hud:Save()
        if managers.hud then
            local tm = managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]
            tm._player_panel:child("radial_health_panel"):child("radial_health"):set_color(item:value() == "on" and tm.health_colour or Color.white)
        end
    end

    MenuCallbackHandler.pdth_toggle_bullet = function(this, item)
        pdth_hud.Options.HUD.Bullet = item:value()
        pdth_hud:Save()
        if managers.player and managers.hud then
            managers.hud._teammate_panels[HUDManager.PLAYER_PANEL].bulletChanged = true
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
            local tm = managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]
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
        if managers.hud then
            for i = 1, HUDManager.PLAYER_PANEL do
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
        if tweak_data.levels[level_index[i]] then
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
