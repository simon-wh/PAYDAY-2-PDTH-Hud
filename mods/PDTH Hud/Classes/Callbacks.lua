pdth_hud.callbacks = pdth_hud.callbacks or {}

function pdth_hud.callbacks:ColourGradingChanged(key, value)
    if not managers.job:current_level_id() or pdth_hud.Options:GetValue("Gradings/" .. managers.job:current_level_id()) == 1 then
        managers.environment_controller:set_default_color_grading(pdth_hud.Options:GetValue("Grading", true))
        managers.environment_controller:refresh_render_settings()
    end
end

function pdth_hud.callbacks:HeistColourGradingChanged(key, value)
    if managers.job:current_level_id() == table.remove(string.split(key, "/")) then
        local colour_grading = value == 1 and pdth_hud.Options:GetValue("Grading", true) or pdth_hud.Options:GetValue(key, true)
        managers.environment_controller:set_default_color_grading(colour_grading)
        managers.environment_controller:refresh_render_settings()
    end
end

function pdth_hud.callbacks:PortraitColourChanged(key, value)
    if managers.hud then
        local tm = managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]
        tm._player_panel:child("radial_health_panel"):child("radial_health"):set_color(value and tm.health_colour or Color.white)
        --Implement colour change of the teammate portraits when teammate icon style is disabled
    end
end

function pdth_hud.callbacks:BulletStyleChanged(key, value)
    if managers.player and managers.hud then
        local player = managers.player:local_player()
        if player then
            local inventory = player:inventory()
            if inventory then
                managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:refresh_ammo_icons()
            end
        end
    end
end

function pdth_hud.callbacks:WeaponIconStyleChanged(key, value)
    pdth_hud.textures:apply_tweak_data_icons()
    if managers.hud then
        for i = 1, HUDManager.PLAYER_PANEL do
            local tm = managers.hud._teammate_panels[i]
            if not tm._ai then
                tm:refresh_special_equipment()
            end
        end
    end
end

function pdth_hud.callbacks:FiremodeEnabledChanged(key, value)
    if managers.hud then
        managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:recreate_weapon_firemode()
    end
end

function pdth_hud.callbacks:PortraitSelectionChanged(key, value)
    pdth_hud.textures:refresh_portrait_order()

    if managers.hud then
        for i = 1, HUDManager.PLAYER_PANEL do
            local tm = managers.hud._teammate_panels[i]
            tm:RefreshPortraits()
        end
    end
    managers.menu_component:refresh_portrait_gui()
end

function pdth_hud.callbacks:HeistGradingChanged(key, value)
    if managers.job:current_level_id() == key then
        managers.environment_controller:set_default_color_grading(pdth_hud.Options:GetValue(key, true))
        managers.environment_controller:refresh_render_settings()
    end
end

function pdth_hud.callbacks:UseEquipment()
    if LuaNetworking:IsHost() and Network:multiplayer() and not Global.game_settings.single_player then
        return false
    end

	return pdth_hud.Options:GetValue("Equipment")
end
