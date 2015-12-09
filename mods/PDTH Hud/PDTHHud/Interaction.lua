if pdth_hud.loaded_options.Ingame.Interaction then

HUDInteraction = HUDInteraction or class()
function HUDInteraction:init(hud, child_name)
	self._hud_panel = hud.panel
	self._circle_radius = 64
	self._sides = 64
	self._child_name_text = (child_name or "interact") .. "_text"
	self._child_ivalid_name_text = (child_name or "interact") .. "_invalid_text"
	if self._hud_panel:child(self._child_name_text) then
		self._hud_panel:remove(self._hud_panel:child(self._child_name_text))
	end
	if self._hud_panel:child(self._child_ivalid_name_text) then
		self._hud_panel:remove(self._hud_panel:child(self._child_ivalid_name_text))
	end
	local interact_text = self._hud_panel:text({
		name = self._child_name_text,
		visible = false,
		text = "",
		valign = "center",
		align = "left",
		blend_mode = "normal",
		layer = 25,
		--color = Color.white,
		font = tweak_data.menu.small_font,
		font_size = tweak_data.hud_present.text_size * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 64 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	local invalid_text = self._hud_panel:text({
		name = self._child_ivalid_name_text,
		visible = false,
		text = "",
		valign = "center",
		align = "center",
		layer = 24,
		color = Color(1, 0.3, 0.3),
		blend_mode = "normal",
		font = tweak_data.menu.small_font,
		font_size = (tweak_data.hud_present.text_size - 2) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 64 * pdth_hud.loaded_options.Ingame.Hud_scale
	})

	local interact_bar = self._hud_panel:bitmap({
		name = "interact_bar",
		visible = false,
		--blend_mode = "add",
		layer = 23,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			1,
			393,
			358,
			20
		},
		--valign = "center",
		--align = "center",
		x = 0,
		y = 0,
		w = 252 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 20 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	
	local interact_bar_invalid = self._hud_panel:bitmap({
		name = "interact_bar_invalid",
		visible = false,
		blend_mode = "normal",
		layer = 22,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			0,
			437,
			360,
			20
		},
		x = 0,
		y = 0,
		w = 252 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 20 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	
	local interact_background = self._hud_panel:bitmap({
		name = "interact_background",
		visible = false,
		blend_mode = "normal",
		layer = 21,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			0,
			414,
			360,
			22
		},
		x = 0,
		y = 0,
		w = 254 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 22 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	local safe_rect_pixels = managers.viewport:get_safe_rect_pixels()
	local interact_bitmap = self._hud_panel:bitmap({
		name = "interact_bitmap",
		layer = 22,
		visible = false,
		blend_mode = "normal",
		--texture = "guis/textures/pd2/hud_stealth_exclam",
		x = 0,
		y = 0,
		w = 38 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 38 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	
	local test_text = self._hud_panel:text({
		name = "test_text",
		visible = false,
		text = "",
		valign = "center",
		align = "center",
		layer = 24,
		color = Color(1, 0.3, 0.3),
		blend_mode = "normal",
		font = tweak_data.menu.small_font,
		font_size = (tweak_data.hud_present.text_size - 2) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 64 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data("develop")
	interact_bitmap:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	interact_bitmap:set_center_y(interact_bitmap:parent():center_y() / 1.65)
	--interact_bitmap:set_right(470  pdth_hud.loaded_options.Ingame.Hud_scale)
	interact_background:set_h((22 * 0.86) * pdth_hud.loaded_options.Ingame.Hud_scale)
	interact_background:set_w((300 * 0.9) * pdth_hud.loaded_options.Ingame.Hud_scale)
	interact_background:set_center_x(self._hud_panel:center_x() + (interact_bitmap:w() / 2))
	interact_background:set_center_y(interact_bitmap:center_y())
	interact_bitmap:set_right(interact_background:left() - 5)
	interact_bar:set_h(interact_background:h() - (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
	interact_bar:set_w(interact_background:w() - (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
	
	interact_bar:set_left(interact_background:left() + 1)
	interact_bar:set_center_y(interact_bitmap:center_y())
	
	interact_text:set_font_size(15 * pdth_hud.loaded_options.Ingame.Hud_scale)
	interact_text:set_center_y(interact_bitmap:center_y() + (24.5 * pdth_hud.loaded_options.Ingame.Hud_scale))
	interact_text:set_left(interact_background:left() + 5)
	
	test_text:set_center_y(interact_bitmap:center_y() - (24 * pdth_hud.loaded_options.Ingame.Hud_scale))
	test_text:set_left(interact_bitmap:right())

	invalid_text:set_center_y(interact_text:center_y() + (20 * pdth_hud.loaded_options.Ingame.Hud_scale))
	invalid_text:set_center_x(interact_background:center_x())
	self._interact_circle = {}
	self._interact_circle._circle = interact_bar
end

function HUDInteraction:show_interact(data)
	local interact_bar = self._hud_panel:child("interact_bar")
	local interact_text = self._hud_panel:child("interact_text")
	local test_text = self._hud_panel:child("test_text")
	local interact_bitmap = self._hud_panel:child("interact_bitmap")
	local interact_background = self._hud_panel:child("interact_background")
	self:remove_interact()
	--self._hud_panel:child(self._child_name_text):set_visible(true)
	--self._hud_panel:child(self._child_name_text):set_text(text)
	local text = string.upper(data.text or "Press 'F' to interact")

	interact_text:set_visible(true)
	interact_background:set_visible(true)
	
	interact_text:set_text(text)
	test_text:set_text(data.icon)
	if data.icon then
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
		interact_bitmap:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	end
	interact_bitmap:set_visible(true)
end

function HUDInteraction:remove_interact()
	local interact_bar = self._hud_panel:child("interact_bar")
	local interact_text = self._hud_panel:child("interact_text")
	local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
	local interact_bitmap = self._hud_panel:child("interact_bitmap")
	local interact_background = self._hud_panel:child("interact_background")
	if not alive(self._hud_panel) then
		return
	end
	interact_text:set_visible(false)
	invalid_text:set_visible(false)
	interact_background:set_visible(false)
	interact_bitmap:set_visible(false)
	--interact_bitmap:set_image("guis/textures/pd2/hud_stealth_exclam")
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data("develop")
	interact_bitmap:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
end

function HUDInteraction:show_interaction_bar(current, total)
	local interact_background = self._hud_panel:child("interact_background")
	local interact_bar = self._hud_panel:child("interact_bar")
	local interact_bitmap = self._hud_panel:child("interact_bitmap")
	local interact_text = self._hud_panel:child("interact_text")
	interact_bar:set_w(current)
	interact_bar:set_visible(true)
	interact_bitmap:set_visible(true)
	interact_text:set_visible(true)
	interact_background:set_visible(true)
	--interact_bar_stop:set_visible(true)
	interact_bar:set_image("guis/textures/hud_icons", 1, 393, 358, 20)
end

function HUDInteraction:set_interaction_bar_width(current, total)
	local interact_background = self._hud_panel:child("interact_background")
	local interact_bar = self._hud_panel:child("interact_bar")
	local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
	local interact_bitmap = self._hud_panel:child("interact_bitmap")
	local interact_text = self._hud_panel:child("interact_text")
	local mul = current / total
	local width = mul * (interact_background:width() - 2)
	interact_bar:set_w(width)
	if invalid_text then
		if invalid_text:visible() == true then
			interact_bar:set_texture_rect(1, 437, 358 * mul, 20)
		end
	else
		interact_bar:set_texture_rect(1, 393, 358 * mul, 20)
	end
	if  current > 0 then
		interact_bitmap:set_visible(true)
		interact_text:set_visible(true)
		interact_background:set_visible(true)
	end
end

function HUDInteraction:hide_interaction_bar(complete)
	local interact_bar = self._hud_panel:child("interact_bar")
	local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
	local interact_background = self._hud_panel:child("interact_background")
	if complete then
			interact_bar:set_image("guis/textures/hud_icons", 1, 393, 358, 20)
			--interact_background:set_visible(false)
	end
	interact_bar:set_visible(false)
	invalid_text:set_visible(false)
	--interact_bar_stop:set_visible(false)
end

function HUDInteraction:set_bar_valid(valid, text_id)
	local interact_bar = self._hud_panel:child("interact_bar")
	local texture2 = valid and 393 or 437
	interact_bar:set_image("guis/textures/hud_icons", 1, texture2, 358, 20)
	self._hud_panel:child(self._child_name_text):set_visible(valid)
	local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
	if text_id then
		invalid_text:set_text(managers.localization:to_upper_text(text_id))
	end
	invalid_text:set_visible(not valid)
end

function HUDInteraction:destroy()
	local interact_bar = self._hud_panel:child("interact_bar")
	local interact_background = self._hud_panel:child("interact_background")
	local interact_bitmap = self._hud_panel:child("interact_bitmap")
	self._hud_panel:remove(self._hud_panel:child(self._child_name_text))
	self._hud_panel:remove(self._hud_panel:child(self._child_ivalid_name_text))
	if interact_bar then
		self._hud_panel:remove(self._hud_panel:child("interact_bar"))
		interact_bar = nil
	end
	if interact_bitmap then
		self._hud_panel:remove(self._hud_panel:child("interact_bitmap"))
		interact_bitmap = nil
	end
	if interact_background then
		self._hud_panel:remove(self._hud_panel:child("interact_background"))
		interact_background = nil
	end
end

function HUDInteraction:_animate_interaction_complete(bitmap, circle)
	bitmap:parent():remove(bitmap)
	circle:remove()
end

end