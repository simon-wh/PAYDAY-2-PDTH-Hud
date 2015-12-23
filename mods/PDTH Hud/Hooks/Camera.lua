local gen_cooldown = SecurityCamera.generate_cooldown
function SecurityCamera:generate_cooldown(amount)
	if pdth_hud.Options.HUD.Cameras then
		if managers.job:current_level_id() ~= "safehouse" then
			managers.hint:show_hint("destroyed_security_camera")
		end
	end
	return gen_cooldown(self, amount)
end