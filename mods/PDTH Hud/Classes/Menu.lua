pdth_hud.challenges_menu = "pdth_hud_challenges"
pdth_hud.active_challenges_menu = "pdth_hud_active_challenges"
pdth_hud.completed_challenges_menu = "pdth_hud_completed_challenges"


Hooks:Add("MenuManagerSetupCustomMenus", "Base_SetupPDTHHudMenu", function( menu_manager, nodes )
    MenuHelper:NewMenu( pdth_hud.challenges_menu )
    MenuHelper:NewMenu( pdth_hud.active_challenges_menu )
    MenuHelper:NewMenu( pdth_hud.completed_challenges_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "Base_PopulatePDTHHudMenu", function( menu_manager, nodes )
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
