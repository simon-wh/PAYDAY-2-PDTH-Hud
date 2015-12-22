if pdth_hud.loaded_options.Ingame.MainHud then
    CloneClass(HUDManager)

    function HUDManager.set_mugshot_talk(self, id, active)
        local data = self:_get_mugshot_data(id)
        if not data then
            return
        end
        local i = managers.criminals:character_data_by_name(data.character_name_id).panel_id
        managers.hud._teammate_panels[i]._panel:child("talk"):set_visible(active)
        
        self.orig.set_mugshot_talk(self, id, active)
    end

    function HUDManager.set_mugshot_voice(self, id, active)
        local data = self:_get_mugshot_data(id)
        if not data then
            return
        end
        local i = managers.criminals:character_data_by_name(data.character_name_id).panel_id
        managers.hud._teammate_panels[i]._panel:child("talk"):set_visible(active)
        self.orig.set_mugshot_voice(self, id, active)
    end

    function HUDManager.add_waypoint(self, id, data)
        self.orig.add_waypoint(self, id, data)
        
        self._hud.waypoints[id].arrow:set_color(Color.white)
    end
end