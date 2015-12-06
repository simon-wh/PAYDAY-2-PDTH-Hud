function CoreEnvironmentControllerManager:set_default_color_grading(color_grading)
	local selected_grading
	if pdth_hud.loaded_options.Grading[managers.job:current_level_id()] == 1 then
		selected_grading = pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading]
	elseif managers.job:current_level_id() and not managers.network:session():_local_peer_in_lobby() then
		selected_grading = pdth_hud.heist_colour_gradings[pdth_hud.loaded_options.Grading[managers.job:current_level_id()]]
	elseif not managers.job:current_level_id() or managers.network:session():_local_peer_in_lobby() then
		selected_grading = pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading]
	end
	if pdth_hud.loaded_options.Ingame.CameraGrading then
		self._default_color_grading = color_grading ~= "color_sin" and selected_grading or color_grading or self._GAME_DEFAULT_COLOR_GRADING
	else
		self._default_color_grading = selected_grading or color_grading or self._GAME_DEFAULT_COLOR_GRADING
	end
end