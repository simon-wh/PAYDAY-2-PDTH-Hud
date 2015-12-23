if not GoonBase then
    CloneClass(NewRaycastWeaponBase)

    function NewRaycastWeaponBase.toggle_gadget(self)
        local state = self.orig.toggle_gadget(self)
        if pdth_hud.Options.HUD.Gadget then
            if state then
                self._stored_gadget_on = self._gadget_on 
            end
        end
        return state
    end

    function NewRaycastWeaponBase.on_equip(self)
        if pdth_hud.Options.HUD.Gadget then
            self:set_gadget_on(self._stored_gadget_on or 0, false)
        else
            self._stored_gadget_on = nil
        end
        return self.orig.on_equip(self)
    end
end