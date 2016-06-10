local NetworkAccountSTEAMinventory_outfit_refresh = NetworkAccountSTEAM.inventory_outfit_refresh

function NetworkAccountSTEAM:inventory_outfit_refresh()
	NetworkAccountSTEAMinventory_outfit_refresh(self)
    if managers.hud then
        managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:get_weapon_info()
    end
end
