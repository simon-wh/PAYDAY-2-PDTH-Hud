if not GoonBase then
--NewRaycastWeaponBase = NewRaycastWeaponBase or class(RaycastWeaponBase)
local self = NewRaycastWeaponBase
self._original_equip = self.on_equip
self._toggle_original_gadget = self.toggle_gadget

function NewRaycastWeaponBase:toggle_gadget()
	local state = self._toggle_original_gadget(self)
	if pdth_hud.loaded_options.Ingame.Gadget then
		if state then
			self._stored_gadget_on = self._gadget_on 
		end
	end
	return state
end

function NewRaycastWeaponBase:on_equip()
	if pdth_hud.loaded_options.Ingame.Gadget then
		self:set_gadget_on(self._stored_gadget_on or 0, false)
	else
		self._stored_gadget_on = nil
	end
	return self._original_equip(self)
end
end