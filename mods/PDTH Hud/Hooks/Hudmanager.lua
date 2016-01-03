--[[if pdth_hud.Options.HUD.MainHud then
    CloneClass(HUDManager)

    function HUDManager.set_mugshot_talk(self, id, active)
        
        
        self.orig.set_mugshot_talk(self, id, active)
    end

    function HUDManager.set_mugshot_voice(self, id, active)
        
        self.orig.set_mugshot_voice(self, id, active)
    end

    function HUDManager.add_waypoint(self, id, data)
        self.orig.add_waypoint(self, id, data)
        
        
    end
end]]--