CloneClass(MenuSceneManager)

function MenuSceneManager.setup_camera(self)
	self.orig.setup_camera(self)
	managers.environment_controller:set_default_color_grading(pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading])
	managers.environment_controller:refresh_render_settings()
end

function MenuSceneManager._open_safe_sequence(self)
    
    self.orig._open_safe_sequence(self)
    
     if BetterLightFX then
        BetterLightFX:UpdateEvent("SafeDrilled", {["_color"] = tweak_data.economy.rarities[self._safe_result_content_data.item_data.rarity].color})
        BetterLightFX:StartEvent("SafeDrilled")
    end
end

function MenuSceneManager._destroy_economy_safe(self)

    if BetterLightFX then
        BetterLightFX:SetColor(0, 0, 0, 0, "SafeDrilled")
        BetterLightFX:EndEvent("SafeDrilled")
    end
    
    self.orig._destroy_economy_safe(self)
end



