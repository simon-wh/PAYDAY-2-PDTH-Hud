function NetworkAccountSTEAM:set_lightfx()
	if managers.user:get_setting("use_lightfx") then
		print("[NetworkAccountSTEAM:init] Initializing LightFX...")
		self._has_alienware = LightFX:initialize() and LightFX:has_lamps()
		if self._has_alienware then
            --Override LightFX
            getmetatable(LightFX).set_lamps_betterfx = getmetatable(LightFX).set_lamps
            getmetatable(LightFX).set_lamps = function()
                log("Original LightFX:set_lamps() was overridden.")
            end
            
			self._masks.alienware = true
			LightFX:set_lamps(0, 0, 0, 0)
		end
		print("[NetworkAccountSTEAM:init] Initializing LightFX done")
	else
		self._has_alienware = nil
		self._masks.alienware = nil
	end
end