CloneClass(MenuSceneManager)

function MenuSceneManager.setup_camera(self)
	self.orig.setup_camera(self)
	managers.environment_controller:set_default_color_grading(pdth_hud.colour_gradings[pdth_hud.loaded_options.Menu.Grading])
	managers.environment_controller:refresh_render_settings()
end