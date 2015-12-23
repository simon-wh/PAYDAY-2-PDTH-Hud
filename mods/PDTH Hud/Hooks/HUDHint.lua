if pdth_hud.Options.HUD.Interaction and not (Restoration and Restoration.options.restoration_hud_global) then
    CloneClass(HUDHint)
    function HUDHint.init(self, hud)
        self.orig.init(self, hud)
        self._hud_panel = hud.panel
        local y = self._hud_panel:h() / 3.8
        self._hint_panel:set_center_y(y)
    end
end