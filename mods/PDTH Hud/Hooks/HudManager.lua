if pdth_hud.Options:GetValue("HUD/MainHud") then
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
