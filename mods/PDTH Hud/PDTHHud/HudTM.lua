if pdth_hud.loaded_options.Ingame.MainHud then
HUDTeammate = HUDTeammate or class()

function HUDTeammate:init(i, teammates_panel, is_player, width)
	local teammates_panels = teammates_panel
	self._id = i
	local small_gap = 8
	local gap = 0
	local pad = 4
	local main_player = i == HUDManager.PLAYER_PANEL
	self._main_player = main_player
	self.health_h = 129 * pdth_hud.loaded_options.Ingame.Hud_scale
	self.health_w = 64 * pdth_hud.loaded_options.Ingame.Hud_scale
	local names = {
		"WWWWWWWWWWWWQWWW",
		"AI Teammate",
		"FutureCatCar",
		"WWWWWWWWWWWWQWWW"
	}
	local teammate_panel = teammates_panel:panel({
		visible = false,
		name = "" .. i,
		w = math.round(width + 3),
		x = 0,
		halign = "left"
	})
	if not main_player then
		teammate_panel:set_bottom(teammates_panel:h())
		teammate_panel:set_halign("left")
	end
	self._player_panel = teammate_panel:panel({name = "player"})
	self._panel = teammate_panel
	--if main_player then
		teammate_panel:set_w(teammate_panel:w() + 1000)
		teammate_panel:set_h(teammates_panel:h())
		self._player_panel:set_w(self._player_panel:w() + 1000)
	--end
	local name = teammate_panel:text({
		name = "name",
		text = " " .. utf8.to_upper(names[i]),
		layer = 1,
		color = Color.white,
		y = 0,
		vertical = "bottom",
		font_size = tweak_data.hud_players.name_size * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.menu.small_font
	})
	local _, _, name_w, name_h = name:text_rect()
	managers.hud:make_fine_text(name)
	name:set_rightbottom(name:w(), teammate_panel:bottom())
	if main_player then
		name:set_visible(false)
	else
		name:set_font_size((tweak_data.hud_players.name_size - 4) * pdth_hud.loaded_options.Ingame.Hud_scale)
	end
	local gradient
	if not main_player then
		gradient = teammate_panel:gradient({
			name = "gradient",
			x = 25 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 0,
			w = 200 * pdth_hud.loaded_options.Ingame.Hud_scale,
			h = teammates_panel:h(),
			layer = 0,
			gradient_points = {
				0,
				Color(0.4, 0, 0, 0),
				1,
				Color(0, 0, 0, 0)
			}
		})
		gradient:set_bottom(teammate_panel:bottom())
	end
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local cs_rect = {
		84,
		34,
		19,
		19
	}
	local csbg_rect = {
		105,
		34,
		19,
		19
	}
	local bg_color = Color.white / 3
	teammate_panel:bitmap({
		name = "name_bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = false,
		layer = 0,
		color = bg_color,
		x = name:x(),
		y = name:y() + 3,
		w = name_w + 4,
		h = name_h - 4,
		vertical = "bottom"
	})
	teammate_panel:bitmap({
		name = "callsign_bg",
		texture = tabs_texture,
		texture_rect = csbg_rect,
		visible = false,
		layer = 0,
		color = bg_color,
		blend_mode = "normal",
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})
	teammate_panel:bitmap({
		name = "callsign",
		texture = tabs_texture,
		texture_rect = cs_rect,
		layer = 1,
		visible = false,
		color = tweak_data.chat_colors[i]:with_alpha(1),
		blend_mode = "normal",
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})
	local box_ai_bg = teammate_panel:bitmap({
		visible = false,
		name = "box_ai_bg",
		texture = "guis/textures/pd2/box_ai_bg",
		color = Color.white,
		alpha = 0,
		y = 0,
		w = teammate_panel:w()
	})
	box_ai_bg:set_bottom(name:top())
	local box_bg = teammate_panel:bitmap({
		visible = false,
		name = "box_bg",
		texture = "guis/textures/pd2/box_bg",
		color = Color.white,
		y = 0,
		w = teammate_panel:w()
	})
	box_bg:set_bottom(name:top())
	local texture, rect = tweak_data.hud_icons:get_icon_data("pd2_mask_" .. i)
	local size = 64 * pdth_hud.loaded_options.Ingame.Hud_scale
	local mask_pad = 2 * pdth_hud.loaded_options.Ingame.Hud_scale
	local mask_pad_x = 3 * pdth_hud.loaded_options.Ingame.Hud_scale
	local y = teammate_panel:h() - name:h() - size + mask_pad
	local mask = teammate_panel:bitmap({
		visible = false,
		name = "mask",
		layer = 1,
		color = Color.white,
		texture = texture,
		texture_rect = rect,
		x = -mask_pad_x,
		w = size,
		h = size,
		y = -35
	})
	local radial_size = main_player and 64 or 64
	local radial_health_panel = self._player_panel:panel({
		name = "radial_health_panel",
		layer = 10,
		w = 64 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 129 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0,
		y = mask:y()
	})
	radial_health_panel:set_bottom(self._player_panel:h())
	if not main_player then
		radial_health_panel:set_x(32 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--radial_health_panel:set_center_y(gradient:center_y())
		--radial_health_panel:set_y(76 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_health_panel:set_w(16 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_health_panel:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_health_panel:set_bottom(gradient:bottom() - ((gradient:h() - radial_health_panel:h()) / 2))
		mask:set_bottom(radial_health_panel:bottom() - 4)
	end
	local radial_bg = radial_health_panel:bitmap({
		name = "radial_bg",
		texture = "guis/textures/pd2/masks",
		align = "bottom",
		blend_mode = "normal",
		w = self.health_w,
		h = self.health_h,
		x = 0,
		y = -60 * pdth_hud.loaded_options.Ingame.Hud_scale,
		layer = 0
	})

	local radial_health = radial_health_panel:bitmap({
		name = "radial_health",
		texture = "guis/textures/pd2/masks",
		--color = Color(0.5, 0.8, 0.4),
		blend_mode = "add",
		w = self.health_w,
		h = self.health_h,
		x = 0,
		y = -60 * pdth_hud.loaded_options.Ingame.Hud_scale,
		layer = 2
	})
	local radial_shield = radial_health_panel:bitmap({
		name = "radial_shield",
		texture = "guis/textures/pd2/masks",
		blend_mode = "add",
		w = self.health_w,
		h = self.health_h,
		x = 0,
		y = -60 * pdth_hud.loaded_options.Ingame.Hud_scale,
		layer = 1
	})
	if pdth_hud.loaded_options.Ingame.Coloured then
		radial_health:set_color(Color(0.5, 0.8, 0.4))
	end
	if not main_player then
		radial_bg:set_w(16 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_bg:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		
		radial_health:set_w(16 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_health:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		
		radial_shield:set_w(16 * pdth_hud.loaded_options.Ingame.Hud_scale)
		radial_shield:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		
		radial_bg:set_x(0)
		radial_bg:set_y(0)
		radial_bg:set_bottom(radial_health_panel:bottom())
		radial_health:set_x(0)
		radial_health:set_y(0)
		radial_health:set_bottom(radial_bg:bottom())
		radial_shield:set_x(0)
		radial_shield:set_y(0)
		radial_shield:set_bottom(radial_bg:bottom())
		self:teammate_fix()
	end
	radial_shield:set_bottom(radial_bg:bottom())
	radial_health:set_bottom(radial_health:parent():h())
	radial_bg:set_bottom(radial_health:parent():h())
	
	local talk_icon, talk_texture_rect = tweak_data.hud_icons:get_icon_data("mugshot_talk")
	local talk = teammate_panel:bitmap({
		name = "talk",
		texture = talk_icon,
		visible = false,
		layer = 11,
		texture_rect = talk_texture_rect,
		w = talk_texture_rect[3] * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = talk_texture_rect[4] * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	talk:set_righttop(radial_health_panel:right() + (5), radial_health_panel:top() - (5))
	
	local damage_indicator = radial_health_panel:bitmap({
		name = "damage_indicator",
		texture = "guis/textures/pd2/hud_radial_rim",
		blend_mode = "add",
		alpha = 0,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 1
	})
	damage_indicator:set_color(Color(1, 1, 1, 1))
	local radial_custom = radial_health_panel:bitmap({
		name = "radial_custom",
		texture = "guis/textures/trial_diamondheist",
		texture_rect = {
			0,
			0,
			64,
			130
		},
		blend_mode = "add",
		w = self.health_w,
		h = self.health_h,
		x = 0,
		y = -60* pdth_hud.loaded_options.Ingame.Hud_scale, 
		layer = 3
	})
	radial_custom:set_bottom(radial_bg:bottom())
	radial_custom:hide()
	if main_player then
		local character_text = radial_health_panel:text({
			name = "character_text",
			visible = true,
			text = "",
			layer = 12,
			color = Color.white,
			y = 0,
			x = 0,
			blend_mode = "normal",
			align = "center",
			vertical = "center",
			font_size = 15 * pdth_hud.loaded_options.Ingame.Hud_scale,
			font = tweak_data.menu.small_font
		})
	end
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
		radial_health:set_image(texture, rectanglehp[1], rectanglehp[2], rectanglehp[3], rectanglehp[4])
		radial_shield:set_image(texture, rectangleam[1], rectangleam[2], rectangleam[3], rectangleam[4])
		radial_bg:set_image(texture, rectanglebg[1], rectanglebg[2], rectanglebg[3], rectanglebg[4])
		--[[radial_health:set_texture(texture)
		radial_shield:set_texture(texture)
		radial_bg:set_texture(texture)]]--
	end
	local x, y, w, h = radial_health_panel:shape()
	if main_player then
		local character_text = radial_health_panel:child("character_text")
		character_text:set_bottom(radial_bg:bottom() * 1.4)
	end
	teammate_panel:bitmap({
		name = "condition_icon",
		layer = 30,
		visible = false,
		color = Color.white,
		blend_mode = "add",
		x = x,
		y = teammate_panel:bottom() - (h / 1.3),
		w = w,
		h = h / 2
	})
	
	if not main_player then
		local condition_icon = teammate_panel:child("condition_icon")
		condition_icon:set_y(teammate_panel:bottom() - (h / 1.15))
		--condition_icon:set_h(h / 2)
	end
	
	local condition_timer = teammate_panel:text({
		name = "condition_timer",
		visible = false,
		text = "000",
		layer = 31,
		color = Color.white,
		y = 0,
		blend_mode = "normal",
		align = "center",
		vertical = "center",
		font_size = tweak_data.hud_players.timer_size * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.hud_players.timer_font
	})
	condition_timer:set_shape(radial_health_panel:shape())
	if not main_player then
		condition_timer:set_font_size((tweak_data.hud_players.timer_size - 10) * pdth_hud.loaded_options.Ingame.Hud_scale)
	end
	local w_selection_w = 12
	local weapon_panel_w = 80
	local extra_clip_w = 4
	local ammo_text_w = (weapon_panel_w - w_selection_w) / 2
	local font_bottom_align_correction = 3
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		0,
		0,
		67,
		32
	}
	local weapon_selection_rect1 = {
		68,
		0,
		12,
		32
	}
	local weapon_selection_rect2 = {
		68,
		32,
		12,
		32
	}
	local weapons_panel = self._player_panel:panel({
		name = "weapons_panel",
		visible = true,
		layer = 0,
		w = weapon_panel_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = (radial_size + 4) * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = radial_health_panel:right() + 4 * (pdth_hud.loaded_options.Ingame.Hud_scale),
		y = mask:y()
	})
	if main_player then
		weapons_panel:set_x((teammate_panel:w() - (weapon_panel_w * 2) + 10) * pdth_hud.loaded_options.Ingame.Hud_scale)
		weapons_panel:set_y((mask:y() - 6) * pdth_hud.loaded_options.Ingame.Hud_scale)
	end
	local primary_weapon_panel = weapons_panel:panel({
		name = "primary_weapon_panel",
		visible = false,
		layer = 1,
		w = weapon_panel_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 32 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0,
		y = 0
	})
	primary_weapon_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = weapon_panel_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0
	})
	primary_weapon_panel:text({
		name = "ammo_clip",
		visible = main_player and true,
		text = "0" .. math.random(40),
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = (ammo_text_w + extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = primary_weapon_panel:h(),
		x = 0,
		y = 0 + font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale,
		vertical = "bottom",
		align = "center",
		font_size = 32 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.hud_players.ammo_font
	})
	primary_weapon_panel:text({
		name = "ammo_total",
		visible = true,
		text = "000",
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = (ammo_text_w - extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = primary_weapon_panel:h(),
		x = (ammo_text_w + extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 0 + font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale,
		vertical = "bottom",
		align = "center",
		font_size = 24 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.hud_players.ammo_font
	})
	local weapon_selection_panel = teammate_panel:panel({
		name = "weapon_selection_primary",
		layer = 1,
		visible = main_player and true,
		w = w_selection_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = teammate_panel:w() - (58 * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		texture = tabs_texture,
		visible = false,
		texture_rect = weapon_selection_rect1,
		color = Color.white,
		w = w_selection_w * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	self:_create_primary_weapon_firemode()
	if not main_player then
		local ammo_total = primary_weapon_panel:child("ammo_total")
		local _x, _y, _w, _h = ammo_total:text_rect()
		primary_weapon_panel:set_size(_w + (8 * pdth_hud.loaded_options.Ingame.Hud_scale), _h)
		ammo_total:set_shape(0, 0, primary_weapon_panel:size())
		ammo_total:set_font_size(22 * pdth_hud.loaded_options.Ingame.Hud_scale)
		ammo_total:move(0, font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale)
		primary_weapon_panel:set_x(0)
		primary_weapon_panel:set_bottom(weapons_panel:h())
		local eq_rect = {
			84,
			0,
			44,
			32
		}
		primary_weapon_panel:child("bg"):set_image(tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4])
		primary_weapon_panel:child("bg"):set_size(primary_weapon_panel:size())
		primary_weapon_panel:child("bg"):set_visible(false)
	else
		primary_weapon_panel:child("bg"):set_visible(false)
		primary_weapon_panel:child("ammo_total"):set_visible(false)
		primary_weapon_panel:child("ammo_clip"):set_visible(false)
	end
	local secondary_weapon_panel = weapons_panel:panel({
		name = "secondary_weapon_panel",
		visible = false,
		layer = 1,
		w = weapon_panel_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 32 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0,
		y = primary_weapon_panel:bottom()
	})
	secondary_weapon_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = weapon_panel_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0
	})
	secondary_weapon_panel:text({
		name = "ammo_clip",
		visible = main_player and true,
		text = "" .. math.random(40),
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = (ammo_text_w + extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = secondary_weapon_panel:h(),
		x = 0,
		y = 0 + (font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale),
		vertical = "bottom",
		align = "center",
		font_size = 32 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.hud_players.ammo_font
	})
	secondary_weapon_panel:text({
		name = "ammo_total",
		visible = true,
		text = "000",
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = (ammo_text_w - extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = secondary_weapon_panel:h(),
		x = (ammo_text_w + extra_clip_w) * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 0 + (font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale),
		vertical = "bottom",
		align = "center",
		font_size = 24 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.hud_players.ammo_font
	})
	local weapon_selection_panel = teammate_panel:panel({
		name = "weapon_selection_second",
		layer = 1,
		visible = main_player and true,
		w = w_selection_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = teammate_panel:w() - (58 * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		visible = false,
		texture = tabs_texture,
		texture_rect = weapon_selection_rect2,
		color = Color.white,
		w = w_selection_w * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	secondary_weapon_panel:set_bottom(weapons_panel:h())
	self:_create_secondary_weapon_firemode()
	if not main_player then
		local ammo_total = secondary_weapon_panel:child("ammo_total")
		local _x, _y, _w, _h = ammo_total:text_rect()
		secondary_weapon_panel:set_size(_w + (8 * pdth_hud.loaded_options.Ingame.Hud_scale), _h)
		ammo_total:set_font_size(22 * pdth_hud.loaded_options.Ingame.Hud_scale)
		ammo_total:set_shape(0, 0, secondary_weapon_panel:size())
		ammo_total:move(0, font_bottom_align_correction * pdth_hud.loaded_options.Ingame.Hud_scale)
		secondary_weapon_panel:set_x(primary_weapon_panel:right())
		secondary_weapon_panel:set_bottom(weapons_panel:h())
		local eq_rect = {
			84,
			0,
			44,
			32
		}
		secondary_weapon_panel:child("bg"):set_image(tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4])
		secondary_weapon_panel:child("bg"):set_size(secondary_weapon_panel:size())
		secondary_weapon_panel:child("bg"):set_visible(false)
	else
		secondary_weapon_panel:child("bg"):set_visible(false)
		secondary_weapon_panel:child("ammo_total"):set_visible(false)
		secondary_weapon_panel:child("ammo_clip"):set_visible(false)
	end
	local eq_rect = {
		84,
		0,
		44,
		32
	}
	local temp_scale = 1 * pdth_hud.loaded_options.Ingame.Hud_scale
	local eq_h = 64 / 3
	local eq_w = 48
	local eq_tm_scale = PlayerBase.USE_GRENADES and 1 * pdth_hud.loaded_options.Ingame.Hud_scale or 0.75
	local deployable_equipment_panel = self._player_panel:panel({
		name = "deployable_equipment_panel",
		layer = 1,
		w = eq_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = eq_h * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = weapons_panel:right() + (20 * pdth_hud.loaded_options.Ingame.Hud_scale),
		y = weapons_panel:y() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	deployable_equipment_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = eq_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = deployable_equipment_panel:w(),
		x = 0
	})
	local equipment = deployable_equipment_panel:bitmap({
		name = "equipment",
		visible = false,
		layer = 1,
		color = Color.white,
		w = deployable_equipment_panel:h() * temp_scale,
		h = deployable_equipment_panel:h() * temp_scale,
		x = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2,
		y = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2
	})
	
	if not main_player then
		local amount = deployable_equipment_panel:text({
			name = "amount",
			visible = false,
			text = tostring(12),
			font = tweak_data.menu.small_font,
			--font_size = 22,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			--halign = "right",
			align = "right",
			vertical = "center",
			layer = 2,
			x = -2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			w = deployable_equipment_panel:w(),
			h = deployable_equipment_panel:h()
		})
		local scale = eq_tm_scale
		--deployable_equipment_panel:set_size(deployable_equipment_panel:w() * (0.9 * pdth_hud.loaded_options.Ingame.Hud_scale), deployable_equipment_panel:h() * scale)
		--deployable_equipment_panel:set_size(deployable_equipment_panel:w() * (0.9), deployable_equipment_panel:h())
		--equipment:set_size((equipment:w() * scale) + 4, (equipment:h() * scale) + 4)
		equipment:set_size((equipment:w()) + 4, (equipment:h()) + 4)
		equipment:set_center_y(deployable_equipment_panel:h() / 2)
		equipment:set_x(equipment:x() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_center_y(deployable_equipment_panel:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_center_y(deployable_equipment_panel:h() / (2))
		--amount:set_right(deployable_equipment_panel:w() - (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_right(deployable_equipment_panel:w() - (4))
		amount:set_font_size(14 * pdth_hud.loaded_options.Ingame.Hud_scale)
		deployable_equipment_panel:set_x(weapons_panel:right() - (8 * pdth_hud.loaded_options.Ingame.Hud_scale))
		deployable_equipment_panel:set_bottom(weapons_panel:bottom() + (1.5 * pdth_hud.loaded_options.Ingame.Hud_scale))
		local bg = deployable_equipment_panel:child("bg")
		bg:set_size(deployable_equipment_panel:size())
		bg:set_visible(false)
	else
		local amount = deployable_equipment_panel:text({
			name = "amount",
			visible = false,
			text = tostring(12),
			font = tweak_data.menu.small_font,
			--font_size = 22,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			halign = "right",
			--align = "right",
			--vertical = "center",
			layer = 2,
			x = -2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			w = deployable_equipment_panel:w(),
			h = deployable_equipment_panel:h()
		})
		local bg = deployable_equipment_panel:child("bg")
		bg:set_visible(false)
		equipment:set_w(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		equipment:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		equipment:set_x(0)
		equipment:set_y(0)
		deployable_equipment_panel:set_w(48 * pdth_hud.loaded_options.Ingame.Hud_scale)
		deployable_equipment_panel:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--deployable_equipment_panel:set_y(weapons_panel:y() - (30 * pdth_hud.loaded_options.Ingame.Hud_scale))
		local y = (self._panel:h() - deployable_equipment_panel:h()) - (46 * pdth_hud.loaded_options.Ingame.Hud_scale)
		deployable_equipment_panel:set_y(y)
		deployable_equipment_panel:set_x(self._panel:w() - (deployable_equipment_panel:h() * (1.3871 )))--* pdth_hud.loaded_options.Ingame.Hud_scale)))
		
		amount:set_x(equipment:right() - (9 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_y(equipment:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--log(deployable_equipment_panel:x())
		--cable_ties:set_w(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--cable_ties:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--cable_ties:set_x(0)
		--cable_ties:set_y(0)
		--cable_ties_panel:set_w(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--cable_ties_panel:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--cable_ties:set_texture("guis/textures/hud_icons")
		--amount:set_x(cable_ties:right() - (8 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_y(cable_ties:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale))
	end
	local texture, rect = tweak_data.hud_icons:get_icon_data(tweak_data.equipments.specials.cable_tie.icon)
	local cable_ties_panel = self._player_panel:panel({
		name = "cable_ties_panel",
		visible = true,
		layer = 1,
		w = eq_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = eq_h * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = weapons_panel:right() + (20 * pdth_hud.loaded_options.Ingame.Hud_scale),
		y = weapons_panel:y() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	cable_ties_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = eq_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = deployable_equipment_panel:w(),
		x = 0
	})
	local cable_ties = cable_ties_panel:bitmap({
		name = "cable_ties",
		visible = false,
		texture = texture,
		texture_rect = rect,
		layer = 1,
		color = Color.white,
		w = deployable_equipment_panel:h() * temp_scale,
		h = deployable_equipment_panel:h() * temp_scale,
		x = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2,
		y = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2
	})
	
	if PlayerBase.USE_GRENADES then
		cable_ties_panel:set_center_y(weapons_panel:center_y() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale))
	else
		cable_ties_panel:set_bottom(weapons_panel:bottom())
	end
	if not main_player then
		local amount = cable_ties_panel:text({
			name = "amount",
			visible = false,
			text = tostring(12),
			font = tweak_data.menu.small_font,
			--font_size = 22,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			--halign = "right",
			align = "right",
			vertical = "center",
			layer = 2,
			x = -2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			w = deployable_equipment_panel:w(),
			h = deployable_equipment_panel:h()
		})
		local scale = eq_tm_scale
		--cable_ties_panel:set_size(cable_ties_panel:w() * (0.9 * pdth_hud.loaded_options.Ingame.Hud_scale), cable_ties_panel:h() * scale)
		--cable_ties_panel:set_size(cable_ties_panel:w() * (0.9), cable_ties_panel:h())
		--cable_ties:set_size((cable_ties:w() * scale) + 4, (cable_ties:h() * scale) + 4)
		cable_ties:set_size((cable_ties:w()) + 4, (cable_ties:h()) + 4)
		--cable_ties:set_center_y(cable_ties_panel:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
		cable_ties:set_center_y(cable_ties_panel:h() / (2))
		cable_ties:set_x(cable_ties:x() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_center_y(cable_ties_panel:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_center_y(cable_ties_panel:h() / (2))
		--amount:set_right(cable_ties_panel:w() - (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_right(cable_ties_panel:w() - (4))
		amount:set_font_size(14 * pdth_hud.loaded_options.Ingame.Hud_scale)
		cable_ties_panel:set_x(deployable_equipment_panel:right())
		cable_ties_panel:set_bottom(deployable_equipment_panel:bottom())
		local bg = cable_ties_panel:child("bg")
		bg:set_size(cable_ties_panel:size())
		bg:set_visible(false)
	else
		local amount = cable_ties_panel:text({
			name = "amount",
			visible = false,
			text = tostring(12),
			font = tweak_data.menu.small_font,
			--font_size = 22,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			halign = "right",
			--align = "right",
			--vertical = "center",
			layer = 2,
			x = -2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			w = deployable_equipment_panel:w(),
			h = deployable_equipment_panel:h()
		})
		local bg = cable_ties_panel:child("bg")
		bg:set_visible(false)
		cable_ties:set_w(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		cable_ties:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		cable_ties:set_x(0)
		cable_ties:set_y(0)
		cable_ties_panel:set_w(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		cable_ties_panel:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		local y = (self._panel:h() - cable_ties_panel:h()) - (82 * pdth_hud.loaded_options.Ingame.Hud_scale)
		cable_ties_panel:set_y(y)
		cable_ties_panel:set_x(self._panel:w() - (cable_ties_panel:w() * (1.3871 )))--* pdth_hud.loaded_options.Ingame.Hud_scale)))

		--cable_ties:set_texture("guis/textures/hud_icons")
		amount:set_x(cable_ties:right() - (9 * pdth_hud.loaded_options.Ingame.Hud_scale))
		amount:set_y(cable_ties:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale))

		--deployable_equipment_panel:set_w(48 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--deployable_equipment_panel:set_h(36 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--deployable_equipment_panel:set_y(weapons_panel:y() - (30 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_x(equipment:right() - (8 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_y(equipment:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale))
		--amount:set_font_size(18)
	end
	if PlayerBase.USE_GRENADES then
		local texture, rect = tweak_data.hud_icons:get_icon_data("frag_grenade")
		local grenades_panel = self._player_panel:panel({
			name = "grenades_panel",
			visible = true,
			layer = 1,
			w = eq_w * pdth_hud.loaded_options.Ingame.Hud_scale,
			h = eq_h * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = weapons_panel:right() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale),
			y = weapons_panel:y()
		})
		local bg = grenades_panel:bitmap({
			name = "bg",
			texture = tabs_texture,
			texture_rect = eq_rect,
			visible = true,
			layer = 0,
			color = bg_color,
			w = cable_ties_panel:w(),
			x = 0
		})
		local grenades = grenades_panel:bitmap({
			name = "grenades",
			visible = true,
			texture = texture,
			texture_rect = rect,
			layer = 1,
			color = Color.white,
			w = cable_ties_panel:h() * temp_scale,
			h = cable_ties_panel:h() * temp_scale,
			x = -(cable_ties_panel:h() * temp_scale - cable_ties_panel:h()) / 2,
			y = -(cable_ties_panel:h() * temp_scale - cable_ties_panel:h()) / 2
		})
		local amount = grenades_panel:text({
			name = "amount",
			visible = true,
			text = tostring("03"),
			font = tweak_data.menu.small_font,
			font_size = 22 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			align = "right",
			vertical = "center",
			layer = 2,
			x = -2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale,
			w = grenades_panel:w(),
			h = grenades_panel:h()
		})
		grenades_panel:set_bottom(weapons_panel:bottom())
		if not main_player then
			local scale = eq_tm_scale
			--grenades_panel:set_size(grenades_panel:w() * (0.9 * pdth_hud.loaded_options.Ingame.Hud_scale), grenades_panel:h() * scale)
			--grenades_panel:set_size(grenades_panel:w() * (0.9), grenades_panel:h())
			--grenades:set_size((grenades:w() * scale) + (4 ), (grenades:h() * scale) + (4 ))
			grenades:set_size((grenades:w()) + (4 ), (grenades:h()) + (4 ))
			--grenades:set_center_y(grenades_panel:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
			grenades:set_center_y(grenades_panel:h() / (2))
			grenades:set_x(grenades:x() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
			--amount:set_center_y(grenades_panel:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount:set_center_y(grenades_panel:h() / (2))
			--amount:set_right(grenades_panel:w() - (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount:set_right(grenades_panel:w() - (4))
			amount:set_font_size(14 * pdth_hud.loaded_options.Ingame.Hud_scale)
			grenades_panel:set_x(cable_ties_panel:right())
			grenades_panel:set_bottom(cable_ties_panel:bottom())
			bg:set_size(grenades_panel:size())
			bg:set_visible(false)
		else
			grenades_panel:set_visible(false)
			bg:set_visible(false)
			amount:set_visible(false)
		end
	end
	local bag_rect = {
		32,
		33,
		32,
		31
	}
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local bag_w = bag_rect[3]
	local bag_h = bag_rect[4]
	local carry_panel = self._player_panel:panel({
		name = "carry_panel",
		visible = false,
		layer = 1,
		w = bag_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = (bag_h + 2) * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0,
		y = radial_health_panel:top() - (bag_h * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	carry_panel:set_x((24 - bag_w / 2) * pdth_hud.loaded_options.Ingame.Hud_scale)
	carry_panel:set_center_x(radial_health_panel:center_x())
	if not main_player then
		carry_panel:set_x(cable_ties_panel:right() + (44 * pdth_hud.loaded_options.Ingame.Hud_scale))
		carry_panel:set_y(carry_panel:y() + (43 * pdth_hud.loaded_options.Ingame.Hud_scale))
	end
	carry_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = false,
		layer = 0,
		color = bg_color,
		x = 0,
		y = 0,
		w = 100 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = carry_panel:h()
	})
	carry_panel:bitmap({
		name = "bag",
		texture = tabs_texture,
		w = bag_w * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = bag_h * pdth_hud.loaded_options.Ingame.Hud_scale,
		texture_rect = bag_rect,
		visible = true,
		layer = 0,
		color = Color.white,
		x = 1 * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 1 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	if not main_player then
	 carry_panel:child("bag"):set_w(bag_w / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
	 carry_panel:child("bag"):set_h(bag_h / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
	end
	carry_panel:text({
		name = "value",
		visible = false,
		text = "",
		layer = 0,
		color = Color.white,
		x = bag_rect[3] + 4,
		y = 0,
		vertical = "center",
		font_size = tweak_data.hud.small_font_size * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = "fonts/font_small_mf"
	})
	local interact_panel = self._player_panel:panel({
		name = "interact_panel",
		visible = false,
		layer = 3
	})
	--interact_panel:set_shape(weapons_panel:shape())
	interact_panel:set_shape(radial_health_panel:shape())
	interact_panel:set_size(radial_size * (1.25 * pdth_hud.loaded_options.Ingame.Hud_scale), radial_size * (1.25 * pdth_hud.loaded_options.Ingame.Hud_scale))
	--interact_panel:set_leftbottom(interact_panel:w() / (4 * pdth_hud.loaded_options.Ingame.Hud_scale), interact_panel:h() * (1.92 ))
	interact_panel:set_left(interact_panel:w() / (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
	interact_panel:set_y(0)
	--interact_panel:set_center(radial_health_panel:center())
	local radius = interact_panel:h() / 2 - 4
	self._interact = CircleBitmapGuiObject:new(interact_panel, {
		use_bg = true,
		rotation = 360,
		radius = (radius / 2.4) * pdth_hud.loaded_options.Ingame.Hud_scale,
		blend_mode = "add",
		color = Color.white,
		layer = 0
	})
	self._interact:set_position(4 * pdth_hud.loaded_options.Ingame.Hud_scale, 4 * pdth_hud.loaded_options.Ingame.Hud_scale)
	self._special_equipment = {}
	
	self._health = nil
	self._armor = nil
	if main_player then
		local teammates_panel = self._panel:child("player")
		local radial_health_panel = teammates_panel:child("radial_health_panel")
		
		local primary_weapon_ammo = self._panel:panel({
			name = "primary_weapon_ammo",
			visible = false,
			layer = 10,
			w = teammates_panel:w() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale),
			h = 20 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = -17.5 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = radial_health_panel:bottom() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale)
		})
		
		local secondary_weapon_ammo = self._panel:panel({
			name = "secondary_weapon_ammo",
			visible = false,
			layer = 10,
			w = teammates_panel:w() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale),
			h = 20 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = -17.5 * pdth_hud.loaded_options.Ingame.Hud_scale,
			y = radial_health_panel:bottom() - (20 * pdth_hud.loaded_options.Ingame.Hud_scale)
		})
	
	
		local grenade_bitmap
		local grenades_text
		local spacing = -0.5
		
		if PlayerBase.USE_GRENADES then
			
			grenade_bitmap = teammate_panel:bitmap({
				name = "grenade_bitmap",
				visible = true,
				texture = "guis/textures/hud_icons",
				texture_rect = {
					416,
					384,
					48,
					48
				},
				layer = 5,
				--color = Color.white,
				w = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
				h = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
				--x = (weapons_panel:left() ) + (55 / pdth_hud.loaded_options.Ingame.Hud_scale),
				x = 0,
				y = teammate_panel:bottom() - (58 * pdth_hud.loaded_options.Ingame.Hud_scale)
			})
			grenade_bitmap:set_right(primary_weapon_ammo:right() - (19 * pdth_hud.loaded_options.Ingame.Hud_scale))
			grenades_text = teammate_panel:text({
				name = "grenades_text",
				visible = true,
				text = "t",
				--valign = "center",
				halign = "right",
				layer = 6,
				color = Color.white,
				blend_mode = "normal",
				font = tweak_data.menu.small_font,
				font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
				x = grenade_bitmap:right() - (10 * pdth_hud.loaded_options.Ingame.Hud_scale),
				y = grenade_bitmap:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale)
			})
		end
		
		local secondary_weapon_bitmap = teammate_panel:bitmap({
			name = "secondary_weapon_bitmap",
			visible = true,
			texture = "guis/textures/hud_icons",
			texture_rect = {
				48,
				0,
				48,
				48
			},
			layer = 5,
			--color = Color.white,
			w = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
			h = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = 0,
			y = 0
		})
		--secondary_weapon_bitmap:set_x(weapons_panel:left() + (20 * pdth_hud.loaded_options.Ingame.Hud_scale))
		secondary_weapon_bitmap:set_right(grenade_bitmap:left() - spacing)
		secondary_weapon_bitmap:set_y(grenade_bitmap:y())
		
		local primary_weapon_bitmap = teammate_panel:bitmap({
			name = "primary_weapon_bitmap",
			visible = true,
			texture = "guis/textures/hud_icons",
			texture_rect = {
				48,
				0,
				48,
				48
			},
			layer = 5,
			--color = Color.white,
			w = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
			h = 36 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = 0,
			y = 0
		})
		--primary_weapon_bitmap:set_x((weapons_panel:left() - primary_weapon_bitmap:w()) + (21 * pdth_hud.loaded_options.Ingame.Hud_scale))
		primary_weapon_bitmap:set_right(secondary_weapon_bitmap:left() - spacing)
		primary_weapon_bitmap:set_y(grenade_bitmap:y())
		
		local primary_ammo = teammate_panel:text({
			name = "primary_ammo",
			visible = true,
			text = "wot",
			--valign = "center",
			halign = "right",
			layer = 6,
			color = Color.white,
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = primary_weapon_bitmap:right() - (22 * pdth_hud.loaded_options.Ingame.Hud_scale),
			y = primary_weapon_bitmap:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale)
		})
		
		local secondary_ammo = teammate_panel:text({
			name = "secondary_ammo",
			visible = true,
			text = "wot",
			--valign = "center",
			--align = "center",
			halign = "right",
			layer = 6,
			color = Color.white,
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
			x = secondary_weapon_bitmap:right() - (22 * pdth_hud.loaded_options.Ingame.Hud_scale),
			y = secondary_weapon_bitmap:bottom() - (18 * pdth_hud.loaded_options.Ingame.Hud_scale)
		})
		
		
		
		local swan_song_left = secondary_weapon_ammo:bitmap({
			name = "swan_song_left",
			visible = false,
			texture = "guis/textures/alphawipe_test",
			layer = 0,
			color = Color(0, 0, 0),
			blend_mode = "normal",
			w = secondary_weapon_ammo:w(),
			h = secondary_weapon_ammo:h(),
			x = 0,
			y = 0 
		})
		
		local swan_song_left1 = primary_weapon_ammo:bitmap({
			name = "swan_song_left1",
			visible = false,
			texture = "guis/textures/alphawipe_test",
			layer = 0,
			color = Color(0, 0, 0),
			blend_mode = "normal",
			w = primary_weapon_ammo:w(),
			h = primary_weapon_ammo:h(),
			x = 0,
			y = 0 
		})
		self.texture_rect = nil
		self.weaponid = nil
		self.weapon = nil
		self.factory_id = nil
		self.category = nil
		self.w = nil
		self.h = nil
		self.scale = nil
		
	end
	self._character = nil
	self._no = 1
end

--[[function HUDTeammate:recreate_weapon_firemode()
	self:_create_primary_weapon_firemode()
	self:_create_secondary_weapon_firemode()
end]]--

function HUDTeammate:_create_primary_weapon_firemode()
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local weapon_selection_panel = self._panel:child("weapon_selection_primary")
	--weapon_selection_panel:set_bottom(self._panel:bottom())
	weapon_selection_panel:set_w(27 * pdth_hud.loaded_options.Ingame.Hud_scale)
	local old_single = weapon_selection_panel:child("firemode_single")
	local old_auto = weapon_selection_panel:child("firemode_auto")
	if alive(old_single) then
		weapon_selection_panel:remove(old_single)
	end
	if alive(old_auto) then
		weapon_selection_panel:remove(old_auto)
	end
	if self._main_player then
		local equipped_primary = managers.blackmarket:equipped_primary()
		local weapon_tweak_data = tweak_data.weapon[equipped_primary.weapon_id]
		local fire_mode = weapon_tweak_data.FIRE_MODE
		local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
		local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_primary.factory_id, equipped_primary.blueprint)
		local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_primary.factory_id, equipped_primary.blueprint)
		local single_id = "firemode_single" .. ((not can_toggle_firemode or locked_to_single) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(single_id)
		local firemode_single = weapon_selection_panel:text({
			name = "firemode_single",
			--texture = "guis/textures/pd2/weapons",
			--texture_rect = texture_rect,
			--x = 2,
			font = tweak_data.menu.small_font,
			font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale,
			text = managers.localization:text("pdth_hud_semi"),
			blend_mode = "normal",
			align = "center",
			halign = "center",
			vertical = "bottom",
			hvertical = "bottom",
			layer = 1
		})
		--firemode_single:set_bottom(weapon_selection_panel:h() - 1)
		firemode_single:hide()
		firemode_single:set_y(firemode_single:y() - 3)
		local auto_id = "firemode_auto" .. ((not can_toggle_firemode or locked_to_auto) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(auto_id)
		local firemode_auto = weapon_selection_panel:text({
			name = "firemode_auto",
			--texture = "guis/textures/pd2/weapons",
			--texture_rect = texture_rect,
			--x = 2,
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale,
			text = managers.localization:text("pdth_hud_auto"),
			align = "center",
			halign = "center",
			vertical = "bottom",
			hvertical = "bottom",
			layer = 1
		})
		--firemode_auto:set_bottom(weapon_selection_panel:h() - 1)
		firemode_auto:hide()
		firemode_auto:set_y(firemode_auto:y() - (3 * pdth_hud.loaded_options.Ingame.Hud_scale))
		if locked_to_single or not locked_to_auto and fire_mode == "single" then
			firemode_single:show()
		else
			firemode_auto:show()
		end
		if not pdth_hud.loaded_options.Ingame.Fireselector then
			firemode_auto:hide()
			firemode_single:hide()
		end
		--weapon_selection_panel:hide()
	end
end

function HUDTeammate:_create_secondary_weapon_firemode()
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local weapon_selection_panel = self._panel:child("weapon_selection_second")
	--weapon_selection_panel:set_bottom(self._panel:bottom())
	weapon_selection_panel:set_w(27 * pdth_hud.loaded_options.Ingame.Hud_scale)
	local old_single = weapon_selection_panel:child("firemode_single")
	local old_auto = weapon_selection_panel:child("firemode_auto")
	if alive(old_single) then
		weapon_selection_panel:remove(old_single)
	end
	if alive(old_auto) then
		weapon_selection_panel:remove(old_auto)
	end
	if self._main_player then
		local equipped_secondary = managers.blackmarket:equipped_secondary()
		local weapon_tweak_data = tweak_data.weapon[equipped_secondary.weapon_id]
		local fire_mode = weapon_tweak_data.FIRE_MODE
		local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
		local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_secondary.factory_id, equipped_secondary.blueprint)
		local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_secondary.factory_id, equipped_secondary.blueprint)
		local single_id = "firemode_single" .. ((not can_toggle_firemode or locked_to_single) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(single_id)
		local firemode_single = weapon_selection_panel:text({
			name = "firemode_single",
			--texture = "guis/textures/pd2/weapons",
			--texture_rect = texture_rect,
			--x = 2,
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale,
			text = managers.localization:text("pdth_hud_semi"),
			align = "center",
			halign = "center",
			vertical = "bottom",
			hvertical = "bottom",
			layer = 1
		})
		--firemode_single:set_bottom(weapon_selection_panel:h() - 1)
		firemode_single:hide()
		firemode_single:set_y(firemode_single:y() - (3 * pdth_hud.loaded_options.Ingame.Hud_scale))
		local auto_id = "firemode_auto" .. ((not can_toggle_firemode or locked_to_auto) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(auto_id)
		local firemode_auto = weapon_selection_panel:text({
			name = "firemode_auto",
			--texture = "guis/textures/pd2/weapons",
			--texture_rect = texture_rect,
			--x = 2,
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale,
			text = managers.localization:text("pdth_hud_auto"),
			align = "center",
			halign = "center",
			vertical = "bottom",
			hvertical = "bottom",
			layer = 1
		})
		--firemode_auto:set_bottom(weapon_selection_panel:h() - 1)
		firemode_auto:hide()
		firemode_auto:set_y(firemode_auto:y() - (3 * pdth_hud.loaded_options.Ingame.Hud_scale))
		if locked_to_single or not locked_to_auto and fire_mode == "single" then
			firemode_single:show()
		else
			firemode_auto:show()
		end
		if not pdth_hud.loaded_options.Ingame.Fireselector then
			firemode_auto:hide()
			firemode_single:hide()
		end
		--weapon_selection_panel:hide()
	end
end

--[[function HUDTeammate:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end]]--

--[[function HUDTeammate:panel()
	return self._panel
end]]--

--[[function HUDTeammate:add_panel()
	local teammate_panel = self._panel
	teammate_panel:set_visible(true)
end

function HUDTeammate:remove_panel()
	local teammate_panel = self._panel
	teammate_panel:set_visible(false)
	local special_equipment = self._special_equipment
	while special_equipment[1] do
		teammate_panel:remove(table.remove(special_equipment))
	end
	self:set_condition("mugshot_normal")
	self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):set_visible(false)
	self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):set_visible(false)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	deployable_equipment_panel:child("equipment"):set_visible(false)
	deployable_equipment_panel:child("amount"):set_visible(false)
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	cable_ties_panel:child("cable_ties"):set_visible(false)
	cable_ties_panel:child("amount"):set_visible(false)
	self._player_panel:child("carry_panel"):set_visible(false)
	self._player_panel:child("carry_panel"):child("value"):set_text("")
	self:set_cheater(false)
	self:stop_timer()
	self:teammate_progress(false, false, false, false)
	self._peer_id = nil
	self._ai = nil
end

function HUDTeammate:peer_id()
	return self._peer_id
end

function HUDTeammate:set_peer_id(peer_id)
	self._peer_id = peer_id
end

function HUDTeammate:set_ai(ai)
	self._ai = ai
end]]--

function HUDTeammate:_set_weapon_selected(id, hud_icon)
	local is_secondary = id == 1
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local weapon_selection_panel_sec = self._panel:child("weapon_selection_second")
	local weapon_selection_panel_prim = self._panel:child("weapon_selection_primary")
	primary_weapon_panel:set_alpha(is_secondary and 0.5 or 1)
	if is_secondary then
		weapon_selection_panel_prim:set_visible(false)
		weapon_selection_panel_sec:set_visible(true)
	else
		weapon_selection_panel_prim:set_visible(true)
		weapon_selection_panel_sec:set_visible(false)
	end
	secondary_weapon_panel:set_alpha(is_secondary and 1 or 0.5)
	
	if self._main_player then
		local primary_weapon_bitmap = self._panel:child("primary_weapon_bitmap")
		local secondary_weapon_bitmap = self._panel:child("secondary_weapon_bitmap")
		local primary_weapon_ammo = self._panel:child("primary_weapon_ammo")
		local secondary_weapon_ammo = self._panel:child("secondary_weapon_ammo")
		local primary_ammo = self._panel:child("primary_ammo")
		local secondary_ammo = self._panel:child("secondary_ammo")
		local weapons_panel = self._player_panel:child("weapons_panel")
		primary_weapon_bitmap:set_alpha(is_secondary and 0.5 or 1)
		--primary_weapon_ammo:set_visible(is_secondary and false or true)
		secondary_weapon_bitmap:set_alpha(is_secondary and 1 or 0.5)
		secondary_weapon_ammo:set_visible(is_secondary and true or false)
		primary_ammo:set_visible(is_secondary and true or false)
		--secondary_ammo:set_visible(is_secondary and false or true)
		
		local prim_weapon = managers.blackmarket:equipped_primary()
		local second_weapon = managers.blackmarket:equipped_secondary()
		
		if is_secondary then
			primary_weapon_ammo:set_visible(false)
			secondary_ammo:set_visible(false)
		else
			primary_weapon_ammo:set_visible(true)
			secondary_ammo:set_visible(true)
		end

		--[[local test_title = self._panel:text({
			name = "test_title",
			visible = true,
			text = "uwot",
			valign = "center",
			align = "center",
			layer = 40,
			color = Color(1, 0.3, 0.3),
			blend_mode = "normal",
			font = tweak_data.menu.small_font,
			font_size = tweak_data.hud_present.text_size - 2,
			h = 64
		})]]--
		--test_title:set_bottom(self._panel:bottom())
		
		--if is_secondary then
			local sfactory_id = second_weapon.factory_id
			local sweaponid = second_weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(sfactory_id)
			local scategory = tweak_data.weapon[sweaponid].category
			local texture, rectangle = pdth_hud.textures:get_weapon_texture(sweaponid, scategory)
			if texture ~= nil and rectangle ~= nil then
				secondary_weapon_bitmap:set_image(texture, rectangle[1], rectangle[2], rectangle[3] , rectangle[4])
			end
		--else
			local pfactory_id = prim_weapon.factory_id
			local pweaponid = prim_weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(pfactory_id)
			local pcategory = tweak_data.weapon[pweaponid].category
			local texture, rectangle = pdth_hud.textures:get_weapon_texture(pweaponid, pcategory)
			if texture ~= nil and rectangle ~= nil then
				primary_weapon_bitmap:set_image(texture, rectangle[1], rectangle[2], rectangle[3] , rectangle[4])
			end
		--end
	end
end

function HUDTeammate:set_weapon_selected(id, hud_icon)
	self:_set_weapon_selected(id, hud_icon)
end

function HUDTeammate:set_weapon_firemode(id, firemode)
	local is_secondary = id == 1
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local weapon_selection = is_secondary and self._panel:child("weapon_selection_second") or self._panel:child("weapon_selection_primary")
	if alive(weapon_selection) then
		local firemode_single = weapon_selection:child("firemode_single")
		local firemode_auto = weapon_selection:child("firemode_auto")
		if alive(firemode_single) and alive(firemode_auto) then
			if firemode == "single" then
				firemode_single:show()
				firemode_auto:hide()
			else
				firemode_single:hide()
				firemode_auto:show()
			end
		end
	end
end

function HUDTeammate:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max)
	local weapon_panel = self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
	
	weapon_panel:set_visible(true)
	local low_ammo = current_left <= math.round(max_clip / 2)
	local low_ammo_clip = current_clip <= math.round(max_clip / 4)
	local out_of_ammo_clip = current_clip <= 0
	local out_of_ammo = current_left <= 0
	local color_total = out_of_ammo and Color(1, 0.9, 0.3, 0.3)
	color_total = color_total or low_ammo and Color(1, 0.9, 0.9, 0.3)
	color_total = color_total or Color.white
	local color_clip = out_of_ammo_clip and Color(1, 0.9, 0.3, 0.3)
	color_clip = color_clip or low_ammo_clip and Color(1, 0.9, 0.9, 0.3)
	color_clip = color_clip or Color.white
	local ammo_clip = weapon_panel:child("ammo_clip")
	local zero = current_clip < 10 and "00" or current_clip < 100 and "0" or ""
	ammo_clip:set_text(zero .. tostring(current_clip))
	ammo_clip:set_color(color_clip)
	ammo_clip:set_range_color(0, string.len(zero), color_clip:with_alpha(0.5))
	local ammo_total = weapon_panel:child("ammo_total")
	local zero = current_left < 10 and "00" or current_left < 100 and "0" or ""
	ammo_total:set_text(zero .. tostring(current_left))
	if self._main_player then
		local ammo = pdth_hud.loaded_options.Ingame.spooky_ammo and current_left + current_clip or current_left
		local new_zero = ammo < 10 and "00" or ammo < 100 and "0" or ""
		local weapon_ammo = self._panel:child(type .. "_ammo")
		weapon_ammo:set_text(new_zero .. tostring(ammo))
	end
	ammo_total:set_color(color_total)
	ammo_total:set_range_color(0, string.len(zero), color_total:with_alpha(0.5))
	pdth_hud._max_clip = max_clip
	if self._main_player then
		local ammo_panel = self._panel:child(type .. "_weapon_ammo")
		--pdth_hud.bullet_type = type
		if type == "primary" then
			self.weapon = managers.blackmarket:equipped_primary()
			self.factory_id = self.weapon.factory_id
			self.weaponid = self.weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(self.factory_id)
			self.category = tweak_data.weapon[self.weaponid].category
		else
			self.weapon = managers.blackmarket:equipped_secondary()
			self.factory_id = self.weapon.factory_id
			self.weaponid = self.weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(self.factory_id)
			self.category = tweak_data.weapon[self.weaponid].category
		end
		if not ammo_panel:child("ammo_totaly") then
			local ammo_totaly = ammo_panel:text({
				name = "ammo_totaly",
				visible = true,
				text = "uwot",
				--valign = "center",
				--align = "center",
				layer = 2,
				color = Color.white,
				blend_mode = "normal",
				font = tweak_data.menu.small_font,
				font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
				y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale
			})
			ammo_totaly:set_x(ammo_panel:right() - (27 * pdth_hud.loaded_options.Ingame.Hud_scale))
		end
		if not ammo_panel:child("ammo_slash") then
			local ammo_totaly = ammo_panel:child("ammo_totaly")
			local ammo_slash = ammo_panel:text({
				name = "ammo_slash",
				visible = true,
				text = "/",
				--valign = "center",
				--align = "center",
				layer = 2,
				color = Color.white,
				blend_mode = "normal",
				font = tweak_data.menu.small_font,
				font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
				y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale
			})
			ammo_slash:set_right(ammo_totaly:right() - (8 * pdth_hud.loaded_options.Ingame.Hud_scale))
		end
		if not ammo_panel:child("ammo_clipy") then
			local ammo_slash = ammo_panel:child("ammo_slash")
			local ammo_clipy = ammo_panel:text({
				name = "ammo_clipy",
				visible = true,
				text = "uwot",
				--valign = "center",
				--align = "center",
				layer = 2,
				color = Color.white,
				blend_mode = "normal",
				font = tweak_data.menu.small_font,
				font_size = 18 * pdth_hud.loaded_options.Ingame.Hud_scale,
				y = 2 * pdth_hud.loaded_options.Ingame.Hud_scale
			})
			--ammo_clipy:set_x(ammo_panel:right() - (60 * pdth_hud.loaded_options.Ingame.Hud_scale))
			ammo_clipy:set_right(ammo_slash:right() - (25 * pdth_hud.loaded_options.Ingame.Hud_scale))
		end
		if ammo_panel:child("ammo_clipy") then
			local ammo_clipy = ammo_panel:child("ammo_clipy")
			local zero = current_clip < 10 and "00" or current_clip < 100 and "0" or ""
			ammo_clipy:set_text(zero .. tostring(current_clip))
		end
		if ammo_panel:child("ammo_totaly") then
			local ammo_totaly = ammo_panel:child("ammo_totaly")
			local zero = current_left < 10 and "00" or current_left < 100 and "0" or ""
			ammo_totaly:set_text(zero .. tostring(current_left))
			if current_left <= 0 then
				ammo_totaly:set_color(Color.red)
			else
				ammo_totaly:set_color(Color.white)
			end
		end
		
		local r, g, b = 1, 1, 1
		if current_clip <= math.round(max_clip / 4) then
			g = current_clip / (max_clip / 2)
			b = current_clip / (max_clip / 2)
		end
		local ammo_clipy = ammo_panel:child("ammo_clipy")
		ammo_clipy:set_color(Color(0.8, r, g, b))
		if self.category ~= "minigun" and self.category ~= "saw" and self.category ~= "flamethrower" and self.category ~= "bow" and self.category ~= "crossbow" and pdth_hud.loaded_options.Ingame.Bullet ~= 1 then
			
			for i = 1, max_clip do
				if not ammo_panel:child("bullet_" .. i) then
					local bullet_texture, bullet_rectangle, w, h, scale = pdth_hud.textures:get_icon_data(self.category .. "_bullet_" .. pdth_hud.loaded_options.Ingame.Bullet, true)
					if bullet_texture ~= nil and bullet_rectangle ~= nil then
						self.texture_rect = bullet_rectangle
						self.scale = scale --* pdth_hud.loaded_options.Ingame.Hud_scale
						self.w = w * pdth_hud.loaded_options.Ingame.Hud_scale
						self.h = h * pdth_hud.loaded_options.Ingame.Hud_scale
					else
						self.w = 8 * pdth_hud.loaded_options.Ingame.Hud_scale
						self.h = 32 * pdth_hud.loaded_options.Ingame.Hud_scale
						self.texture_rect = {0, 0, self.w, self.h}
						self.scale = 1.8 --* pdth_hud.loaded_options.Ingame.Hud_scale
					end
					local bullet = ammo_panel:bitmap({
						name = "bullet_" .. i,
						visible = true,
						texture = "guis/textures/ammocounter",
						texture_rect = self.texture_rect,
						layer = 1,
						blend_mode = "normal",
						w = self.w / self.scale,
						h = self.h / self.scale,
						x = ammo_panel:right() - ((self.w / (self.scale - 0.2)) * (i)) - (65 * pdth_hud.loaded_options.Ingame.Hud_scale),
						y = 2  * pdth_hud.loaded_options.Ingame.Hud_scale
					})
					if ammo_panel:child("bullet_" .. i) then
						ammo_panel:child("bullet_" .. i):set_image(bullet_texture, self.texture_rect[1], self.texture_rect[2], self.texture_rect[3], self.texture_rect[4])
					end
				end
				
			end
			
			for i = 1, current_clip do
				if ammo_panel:child("bullet_" .. i) then
					local bullet1 = ammo_panel:child("bullet_" .. i)
					bullet1:set_alpha(1)
				end
			end
			
			for i = current_clip + 1, max_clip do
				if ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:child("bullet_" .. i)
					bullet:set_alpha(0.5)
				end
			end

			local r, g, b = 1, 1, 1
			if current_clip <= math.round(max_clip / 4) then
				g = current_clip / (max_clip / 2)
				b = current_clip / (max_clip / 2)
			end
			
			for i = 1, max_clip do		
				if ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:child("bullet_" .. i)
					local ammo_clipy = ammo_panel:child("ammo_clipy")
					if bullet:alpha() == 0.5 then
						bullet:set_color(Color(0.2, r, g, b))
					else
						bullet:set_color(Color(0.8, r, g, b))
						ammo_clipy:set_color(Color(0.8, r, g, b))
					end
				end
			end
			
			for i = max_clip + 1, 400 do
				if ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:child("bullet_" .. i)
					ammo_panel:remove(ammo_panel:child("bullet_" .. i))
				end
			end
		elseif pdth_hud.loaded_options.Ingame.Bullet == 1 then
			local ammo_panel = self._panel:child(type .. "_weapon_ammo")
			for i = 1, max_clip do
				if ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:child("bullet_" .. i)
					ammo_panel:remove(ammo_panel:child("bullet_" .. i))
				end
			end
		
		else
			local ammo_panel = self._panel:child(type .. "_weapon_ammo")
			for i = 1, max_clip do
				if ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:child("bullet_" .. i)
					ammo_panel:remove(ammo_panel:child("bullet_" .. i))
				end
			end
		end
	end
end

function HUDTeammate:set_health(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_bg = radial_health_panel:child("radial_bg")
	local radial_shield = radial_health_panel:child("radial_shield")
	local red = data.current / data.total
	if red < radial_health:color().red then
		self:_damage_taken()
	end
	if teammate_panel:child( "ai_health" ) then	
		teammate_panel:remove( teammate_panel:child( "ai_health" ) )
	end
	local amount = data.current / data.total
	local y_offset = (self.health_h / pdth_hud.loaded_options.Ingame.Hud_scale) * (1 - amount)
	local y_offset_scaled = self.health_h * (1 - amount)
	local y_offsetsmall = (32.5 * pdth_hud.loaded_options.Ingame.Hud_scale) * (1 - amount)
	pdth_hud.health_y_offset = y_offset
	pdth_hud.health_y_offsetsmall = y_offsetsmall
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
		radial_health:set_image(texture, rectanglehp[1], rectanglehp[2] + y_offset, rectanglehp[3], rectanglehp[4] - y_offset)
	end
	if not self._main_player then
		--radial_bg:set_y(0)
		radial_health:set_h((32.5 * pdth_hud.loaded_options.Ingame.Hud_scale) - y_offsetsmall)
		radial_health:set_bottom(radial_bg:bottom())
		radial_shield:set_bottom(radial_bg:bottom())
	else
		radial_health:set_h(self.health_h - y_offset_scaled)
		radial_health:set_bottom(radial_bg:bottom())
		--radial_bg:set_bottom(radial_health:bottom())
	end
	local color = amount < 0.33 and Color(1, 0, 0) or Color(0.5, 0.8, 0.4)
	pdth_hud.colour_amount = amount
	pdth_hud.health_colour = color
	if pdth_hud.loaded_options.Ingame.Coloured then
		radial_health:set_color(color)
	else
		
	end
end

function HUDTeammate:set_armor(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_shield = radial_health_panel:child("radial_shield")
	local radial_bg = radial_health_panel:child("radial_bg")
	local radial_health = radial_health_panel:child("radial_health")
	local red = data.current / data.total
	if red < radial_shield:color().red then
		self:_damage_taken()
	end
	local amount = data.current / data.total
	local y_offset = (self.health_h / pdth_hud.loaded_options.Ingame.Hud_scale) * (1 - amount)
	local y_offset_scaled = self.health_h * (1 - amount)
	local y_offsetsmall = (32.5 * pdth_hud.loaded_options.Ingame.Hud_scale) * (1 - amount)
	pdth_hud.armor_y_offset = y_offset
	pdth_hud.armor_y_offsetsmall = y_offsetsmall
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
		radial_shield:set_image(texture, rectangleam[1], rectangleam[2] + y_offset, rectangleam[3], rectangleam[4] - y_offset)
	end
	if not self._main_player then
		radial_bg:set_y(0)
		radial_health:set_bottom(radial_bg:bottom())
		radial_shield:set_h((32.5 * pdth_hud.loaded_options.Ingame.Hud_scale) - y_offsetsmall)
		radial_shield:set_bottom(radial_bg:bottom())
	else
		radial_shield:set_h(self.health_h - y_offset_scaled)
		radial_shield:set_bottom(radial_bg:bottom())
	end
end

function HUDTeammate:set_custom_radial(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_custom = radial_health_panel:child("radial_custom")
	local radial_bg = radial_health_panel:child("radial_bg")
	local amount = data.current / data.total
	local y_offset = self.health_h * (1 - amount)
	radial_custom:set_texture_rect(0, 0 + y_offset, 64, 130 - y_offset)
	radial_custom:set_h(self.health_h - y_offset)
	radial_custom:set_bottom(radial_bg:bottom())
	radial_custom:show()
end

function HUDTeammate:_damage_taken()
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local damage_indicator = radial_health_panel:child("damage_indicator")
	--damage_indicator:stop()
	--damage_indicator:animate(callback(self, self, "_animate_damage_taken"))
	local player = managers.player:player_unit()
	if not self._main_player and not managers.trade:is_peer_in_custody(self._peer_id) and not self._ai then
		local gradient = self._panel:child("gradient")
		gradient:animate(callback(self, self, "mugshot_damage_taken"))
	end
end

function HUDTeammate:mugshot_damage_taken(gradient)
  		local a1 = 0.4
  		local a2 = 0.0
  		gradient:set_gradient_points( { 0, Color( a1, 1, 0 ,0 ), 1, Color( a2, 1, 0 ,0 ) }  )
  		local i = 1.0
  		local t = i
  		while t > 0 do
  			local dt = coroutine.yield()
  			t = t - dt
  			gradient:set_gradient_points( { 0, Color( a1, (t/i), 0 ,0 ), 1, Color( a2, (t/i), 0 ,0 ) }  )
  		end
  		gradient:set_gradient_points( { 0, Color( a1, 0, 0 ,0 ), 1, Color( a2, 0, 0 ,0 ) } )
end

function HUDTeammate:_animate_damage_taken(damage_indicator)
	damage_indicator:set_alpha(1)
	local st = 3
	local t = st
	local st_red_t = 0.5
	local red_t = st_red_t
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		red_t = math.clamp(red_t - dt, 0, 1)
		damage_indicator:set_color(Color(1, red_t / st_red_t, red_t / st_red_t))
		damage_indicator:set_alpha(t / st)
	end
	damage_indicator:set_alpha(0)
end

function HUDTeammate:set_name(teammate_name)
	local teammate_panel = self._panel
	local name = teammate_panel:child("name")
	local name_bg = teammate_panel:child("name_bg")
	local callsign = teammate_panel:child("callsign")
	self._teammate_name = teammate_name
	name:set_text(utf8.to_upper(" " .. teammate_name))
	local h = name:h()
	managers.hud:make_fine_text(name)
	name:set_h(h)
	name_bg:set_w(name:w() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
	if name:visible() == false then
		name_bg:set_visible(false)
	end
end

--[[function HUDTeammate:set_cheater(state)
	self._panel:child("name"):set_color(state and tweak_data.screen_colors.pro_color or Color.white)
end]]--

--[[function HUDTeammate:set_(id)
	local teammate_panel = self._panel
	print("id", id)
	Application:stack_dump()
	local callsign = teammate_panel:child("callsign")
	local alpha = callsign:color().a
	callsign:set_color(tweak_data.chat_colors[id]:with_alpha(alpha))
end]]--

function HUDTeammate:set_cable_tie(data)
	local teammate_panel = self._panel:child("player")
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	local cable_ties2 = cable_ties_panel:child("cable_ties")
	cable_ties2:set_image("guis/textures/hud_icons", 0, 144, 48, 48)
	--cable_ties2:set_image(icon, unpack(texture_rect))
	cable_ties2:set_visible(true)
	self:set_cable_ties_amount(data.amount)
	return nil
end

function HUDTeammate:set_cable_ties_amount(amount)
	local visible = amount ~= 0
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	local cable_ties_amount = cable_ties_panel:child("amount")
	
	if amount == -1 then
		cable_ties_amount:set_text("--")
	else
		cable_ties_amount:set_text(amount)
		--self:_set_amount_string(cable_ties_amount, amount)
	end
	
	local cable_ties = cable_ties_panel:child("cable_ties")
	--if not self._main_player then
		cable_ties:set_visible(visible)
		cable_ties_amount:set_visible(visible)
	--else
		--cable_ties_amount:set_visible(true)
	--end
	self:layout_special_equipments()
end

function HUDTeammate:_set_amount_string(text, amount)
	if not PlayerBase.USE_GRENADES then
		text:set_text(tostring(amount))
		return
	end
	local zero = self._main_player and amount < 10 and "0" or ""
	text:set_text(zero .. amount)
	text:set_range_color(0, string.len(zero), Color.white:with_alpha(0.5))
end

function HUDTeammate:set_state(state)
	local teammate_panel = self._panel
	local is_player = state == "player"
	teammate_panel:child("player"):set_alpha(is_player and 1 or 0)
	local radial_health_panel = self._panel:child("player"):child("radial_health_panel")
	local name = teammate_panel:child("name")
	local name_bg = teammate_panel:child("name_bg")
	local callsign_bg = teammate_panel:child("callsign_bg")
	local callsign = teammate_panel:child("callsign")
	if not self._main_player then
		local gradient = self._panel:child("gradient")
		if is_player then
			name:set_x((48 + name:h() - 13) * pdth_hud.loaded_options.Ingame.Hud_scale)
			name:set_bottom(teammate_panel:h() - (name:h() + 6))
			if teammate_panel:child( "ai_health" ) then	
				teammate_panel:remove( teammate_panel:child( "ai_health" ) )
			end
		else
			name:set_left(radial_health_panel:right() + 5)
			name:set_bottom(teammate_panel:h() - ((teammate_panel:h() / 3) ))-- (name:h() / 2)))--* pdth_hud.loaded_options.Ingame.Hud_scale))
			--name:set_center_y(radial_health_panel:center_y())
			local ai_health = teammate_panel:bitmap({
				name = "ai_health",
				visible = false,
				texture = "guis/textures/pd2/masks",
				blend_mode = "normal",
				w = 16 * pdth_hud.loaded_options.Ingame.Hud_scale,
				h = 32.5 * pdth_hud.loaded_options.Ingame.Hud_scale,
				x = 0,
				y = -60 * pdth_hud.loaded_options.Ingame.Hud_scale,
				layer = 10
			
			})
			ai_health:set_x(32 * pdth_hud.loaded_options.Ingame.Hud_scale)
			ai_health:set_bottom(gradient:bottom() - ((gradient:h() - ai_health:h()) / 2))
			--ai_health:set_center_y(teammate_panel:center_y())
			if not self._panel:child("talk") then
				local talk_icon, talk_texture_rect = tweak_data.hud_icons:get_icon_data("mugshot_talk")
				local talk = self._panel:bitmap({
					name = "talk",
					texture = talk_icon,
					visible = false,
					layer = 11,
					texture_rect = talk_texture_rect,
					w = talk_texture_rect[3] * pdth_hud.loaded_options.Ingame.Hud_scale,
					h = talk_texture_rect[4] * pdth_hud.loaded_options.Ingame.Hud_scale
				})
				talk:set_righttop(radial_health_panel:right() + (talk:w() - 5), radial_health_panel:top() - (talk:h() - 5))
			end
			
		end
		name_bg:set_position(name:x(), name:y() + (4 * pdth_hud.loaded_options.Ingame.Hud_scale))
		callsign_bg:set_position(name:x() - name:h(), name:y() + (1 * pdth_hud.loaded_options.Ingame.Hud_scale))
		callsign:set_position(name:x() - name:h(), name:y() + (1 * pdth_hud.loaded_options.Ingame.Hud_scale))
		self:teammate_fix()
	end
end

--[[function HUDTeammate:set_deployable_equipment(data)
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local equipment = deployable_equipment_panel:child("equipment")
	equipment:set_visible(true)
	equipment:set_image(icon, unpack(texture_rect))
	self:set_deployable_equipment_amount(1, data)
end]]--

function HUDTeammate:set_deployable_equipment_amount(index, data)
	local teammate_panel = self._panel:child("player")
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local amount = deployable_equipment_panel:child("amount")

	--self:_set_amount_string(amount, data.amount)
	amount:set_text(data.amount)
	if not self._main_player then
		deployable_equipment_panel:child("equipment"):set_visible(data.amount ~= 0)
		amount:set_visible(data.amount ~= 0)
	else
		amount:set_visible(true)
	end
end

function HUDTeammate:set_grenades(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local grenades_panel = self._player_panel:child("grenades_panel")
	local grenades = grenades_panel:child("grenades")
	grenades:set_visible(true)
	grenades:set_image(icon, unpack(texture_rect))
	self:set_grenades_amount(data)
	if self._main_player then
		grenades:set_visible(false)
		grenades_panel:child("bg"):set_visible(false)
		grenades_panel:child("amount"):set_visible(false)
		local grenade_bitmap = self._panel:child("grenade_bitmap")
		grenade_bitmap:set_image(icon, unpack(texture_rect))
	end
end

function HUDTeammate:set_grenades_amount(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	local teammate_panel = self._panel:child("player")
	local grenades_panel = self._player_panel:child("grenades_panel")
	local amount = grenades_panel:child("amount")
	grenades_panel:child("grenades"):set_visible(data.amount ~= 0)
	self:_set_amount_string(amount, data.amount)
	amount:set_visible(data.amount ~= 0)
	if self._main_player then
		grenades_panel:child("grenades"):set_visible(false)
		grenades_panel:child("bg"):set_visible(false)
		grenades_panel:child("amount"):set_visible(false)
		local grenades_text = self._panel:child("grenades_text")
		grenades_text:set_text(data.amount)
	end
end

--[[function HUDTeammate:set_carry_info(carry_id, value)
	local carry_panel = self._player_panel:child("carry_panel")
	carry_panel:set_visible(true)
	local value_text = carry_panel:child("value")
	value_text:set_text(managers.experience:cash_string(value))
	local _, _, w, _ = value_text:text_rect()
	local bg = carry_panel:child("bg")
	bg:set_w(carry_panel:child("bag"):w() + w + 4)
end

function HUDTeammate:remove_carry_info()
	local carry_panel = self._player_panel:child("carry_panel")
	carry_panel:set_visible(false)
end]]--

function HUDTeammate:add_special_equipment(data)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	local id = data.id
	local icon, texture_rect
	local equipment = self._player_panel:child("deployable_equipment_panel"):child("equipment")
	local equipment_panel = teammate_panel:panel({
		name = id,
		layer = 0,
		y = 0
	})
	if data.icon == "pd2_c4" then
		icon, texture_rect = tweak_data.hud_icons:get_icon_data("equipment_c4")
	else
		icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	end
	if not self._main_player then
		equipment_panel:set_size(16 * pdth_hud.loaded_options.Ingame.Hud_scale, 16 * pdth_hud.loaded_options.Ingame.Hud_scale)
	else
		equipment_panel:set_size(equipment:w(), equipment:h())
	end
	local bitmap = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		color = Color.white,
		layer = 1,
		texture_rect = texture_rect,
		w = equipment_panel:w(),
		h = equipment_panel:w()
	})
	local amount, amount_bg
	if data.amount then
		amount = equipment_panel:child("amount") or equipment_panel:text({
			name = "amount",
			text = tostring(data.amount),
			font = tweak_data.menu.small_font,
			font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white,
			align = "center",
			vertical = "center",
			layer = 4,
			w = equipment_panel:w(),
			h = equipment_panel:h()
		})
		amount:set_visible(1 < data.amount)
		amount_bg = equipment_panel:child("amount_bg") or equipment_panel:bitmap({
			name = "amount_bg",
			texture = "guis/textures/pd2/equip_count",
			visible = false,
			color = Color.white,
			layer = 3
		})
		if not self._main_player then
			amount:set_font_size(6 * pdth_hud.loaded_options.Ingame.Hud_scale)
			amount:set_color(Color.black)
			amount_bg:set_w(amount_bg:w() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount_bg:set_h(amount_bg:h() / (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount_bg:set_visible(1 < data.amount)
		end
	end
	local flash_icon = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		color = tweak_data.hud.prime_color,
		layer = 2,
		texture_rect = texture_rect,
		w = equipment_panel:w() + (2 * pdth_hud.loaded_options.Ingame.Hud_scale),
		h = equipment_panel:w() + (2 * pdth_hud.loaded_options.Ingame.Hud_scale)
	})
	table.insert(special_equipment, equipment_panel)
	local w = teammate_panel:w()
	equipment_panel:set_x(w - (equipment_panel:w() + 0) * #special_equipment)
	if amount then
		amount_bg:set_center(bitmap:center())
		amount_bg:move(3.5 * pdth_hud.loaded_options.Ingame.Hud_scale, 3.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		amount:set_center(amount_bg:center())
		if self._main_player then
			amount:set_x(amount:x() + (11 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount:set_y(amount:y() + (5 * pdth_hud.loaded_options.Ingame.Hud_scale))
			amount:set_font_size(18 * pdth_hud.loaded_options.Ingame.Hud_scale)
			amount_bg:set_visible(false)
		end
	end
	
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	flash_icon:set_center(bitmap:center())
	flash_icon:animate(hud.flash_icon, nil, equipment_panel)
	self:layout_special_equipments()
end

--[[function HUDTeammate:remove_special_equipment(equipment)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	for i, panel in ipairs(special_equipment) do
		if panel:name() == equipment then
			local data = table.remove(special_equipment, i)
			teammate_panel:remove(panel)
			self:layout_special_equipments()
			return
		end
	end
end]]--

function HUDTeammate:set_special_equipment_amount(equipment_id, amount)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	for i, panel in ipairs(special_equipment) do
		if panel:name() == equipment_id then
			panel:child("amount"):set_text(tostring(amount))
			panel:child("amount"):set_visible(amount > 1)
			if not self._main_player then
				panel:child("amount_bg"):set_visible(amount > 1)
			end
			return
		end
	end
end

--[[function HUDTeammate:clear_special_equipment()
	self:remove_panel()
	self:add_panel()
end]]--

function HUDTeammate:layout_special_equipments()
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	local name = teammate_panel:child("name")
	local w = teammate_panel:w()
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	local cable_ties = cable_ties_panel:child("cable_ties")
	for i, panel in ipairs(special_equipment) do
		if self._main_player then
			--teammate_panel:set_h(700)
			local y = (self._panel:h() - (panel:w() * i)) - ((cable_ties:visible() and 114 or 114 - panel:w()) * pdth_hud.loaded_options.Ingame.Hud_scale)
			--panel:set_x(self._panel:w() - (panel:w() * (1.3871 )))--* pdth_hud.loaded_options.Ingame.Hud_scale)))
			panel:set_center_x(cable_ties_panel:center_x())
			panel:set_y(y)
		else
			panel:set_x((name:right() + (5 * pdth_hud.loaded_options.Ingame.Hud_scale)) + panel:w() * (i - 1))
			--panel:set_y(72 * pdth_hud.loaded_options.Ingame.Hud_scale)
			panel:set_y(name:top() + (2 * pdth_hud.loaded_options.Ingame.Hud_scale))
		end
	end
end

function HUDTeammate:set_condition(icon_data, text)
	local condition_icon = self._panel:child("condition_icon")
	local teammate_panel = self._panel
	local name = teammate_panel:child("name")
	if icon_data == "mugshot_normal" then
		condition_icon:set_visible(false)
	else
		condition_icon:set_visible(true)
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(icon_data)
		condition_icon:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	end
end

function HUDTeammate:teammate_progress(enabled, tweak_data_id, timer, success)
	--log("teammate progress called")
	self._player_panel:child("radial_health_panel"):set_alpha(enabled and 0.2 or 1)
	self._player_panel:child("interact_panel"):stop()
	self._player_panel:child("interact_panel"):set_visible(enabled)
	if enabled then
		self._player_panel:child("interact_panel"):animate(callback(HUDManager, HUDManager, "_animate_label_interact"), self._interact, timer)
	elseif success then
		local panel = self._player_panel
		local bitmap = panel:bitmap({
			rotation = 360,
			texture = "guis/textures/pd2/job_circles",
			blend_mode = "add",
			align = "center",
			valign = "center",
			layer = 2
		})
		bitmap:set_size(self._interact:size())
		bitmap:set_position(self._player_panel:child("interact_panel"):x() + 4, self._player_panel:child("interact_panel"):y() + 4)
		local radius = self._interact:radius()
		local circle = CircleBitmapGuiObject:new(panel, {
			rotation = 360,
			radius = radius * pdth_hud.loaded_options.Ingame.Hud_scale,
			color = Color.white:with_alpha(1),
			blend_mode = "normal",
			layer = 3
		})
		circle:set_position(bitmap:position())
		bitmap:animate(callback(HUDInteraction, HUDInteraction, "_animate_interaction_complete"), circle)
	end
end

function HUDTeammate:start_timer(time)
	self._timer_paused = 0
	self._timer = time
	if not self._main_player then
		self._panel:child("condition_timer"):set_font_size(tweak_data.hud_players.timer_size - 10)
	else
		self._panel:child("condition_timer"):set_font_size(tweak_data.hud_players.timer_size)
	end
	self._panel:child("condition_timer"):set_color(Color.white)
	self._panel:child("condition_timer"):stop()
	self._panel:child("condition_timer"):set_visible(true)
	self._panel:child("condition_timer"):animate(callback(self, self, "_animate_timer"))
end

--[[function HUDTeammate:set_pause_timer(pause)
	if not self._timer_paused then
		return
	end
	self._timer_paused = self._timer_paused + (pause and 1 or -1)
end

function HUDTeammate:stop_timer()
	if not alive(self._panel) then
		return
	end
	self._panel:child("condition_timer"):set_visible(false)
	self._panel:child("condition_timer"):stop()
end

function HUDTeammate:is_timer_running()
	return self._panel:child("condition_timer"):visible()
end

function HUDTeammate:_animate_timer()
	local rounded_timer = math.round(self._timer)
	while self._timer >= 0 do
		local dt = coroutine.yield()
		if self._timer_paused == 0 then
			self._timer = self._timer - dt
			local text = self._timer < 0 and "00" or (math.round(self._timer) < 10 and "0" or "") .. math.round(self._timer)
			self._panel:child("condition_timer"):set_text(text)
			if rounded_timer > math.round(self._timer) then
				rounded_timer = math.round(self._timer)
				if rounded_timer < 11 then
					self._panel:child("condition_timer"):animate(callback(self, self, "_animate_timer_flash"))
				end
			end
		end
	end
end]]--

function HUDTeammate:_animate_timer_flash()
	local t = 0
	local condition_timer = self._panel:child("condition_timer")
	while t < 0.5 do
		t = t + coroutine.yield()
		local n = 1 - math.sin(t * 180)
		local r = math.lerp(1 or self._point_of_no_return_color.r, 1, n)
		local g = math.lerp(0 or self._point_of_no_return_color.g, 0.8, n)
		local b = math.lerp(0 or self._point_of_no_return_color.b, 0.2, n)
		condition_timer:set_color(Color(r, g, b))
		condition_timer:set_font_size(math.lerp((tweak_data.hud_players.timer_size - 10) * pdth_hud.loaded_options.Ingame.Hud_scale, (tweak_data.hud_players.timer_size - 8) * pdth_hud.loaded_options.Ingame.Hud_scale, n))
	end
	condition_timer:set_font_size((tweak_data.hud_players.timer_size - 10) * pdth_hud.loaded_options.Ingame.Hud_scale) 
end

function HUDTeammate:set_character_portrait()
	local radial_health_panel = self._player_panel:child("radial_health_panel")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_bg = radial_health_panel:child("radial_bg")
	local radial_shield = radial_health_panel:child("radial_shield")
	local character_text = radial_health_panel:child("character_text")
	local main_character = managers.network:session() and managers.network:session():local_peer():character()
	
	if self._main_player then
		local character_name = string.upper(managers.localization:text("menu_" .. main_character))
		character_text:set_text(character_name)
	end
	if self._main_player then
		self._character = managers.network:session():local_peer():character()
	else 
		self._character = managers.criminals:character_name_by_peer_id(self._peer_id)
	end
	if self._character ~= nil then
		local texturebg, rectanglebg = pdth_hud.textures:get_portrait_texture(self._character .. "_bg")
		local texturehp, rectanglehp = pdth_hud.textures:get_portrait_texture(self._character .. "_health")
		local textuream, rectangleam = pdth_hud.textures:get_portrait_texture(self._character .. "_armor")
		if rectanglehp ~= nil and rectangleam ~= nil and rectanglebg ~= nil and texturehp ~= nil then
			return rectanglehp, rectangleam, rectanglebg, texturehp
		else
			local health_texture_rect = {0, 0, 64, 130}
			local armor_texture_rect = {0, 130, 64, 130}
			local background_texture_rect = {0, 260, 64, 130}								
			return health_texture_rect, armor_texture_rect, background_texture_rect, "guis/textures/pd2/masks"
		end
	end
end

function HUDTeammate:teammate_fix()
	local radial_health_panel = self._player_panel:child("radial_health_panel")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_bg = radial_health_panel:child("radial_bg")
	local radial_shield = radial_health_panel:child("radial_shield")
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg then
		radial_health:set_image(texture, rectanglehp[1], rectanglehp[2], rectanglehp[3], rectanglehp[4])
		radial_health:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--radial_health:set_texture(texture)
		radial_bg:set_y(0)
		--radial_bg:set_texture(texture)
		radial_bg:set_image(texture, rectanglebg[1], rectanglebg[2], rectanglebg[3], rectanglebg[4])
		radial_health:set_bottom(radial_bg:bottom())
		radial_shield:set_image(texture, rectangleam[1], rectangleam[2], rectangleam[3], rectangleam[4])
		radial_shield:set_h(32.5 * pdth_hud.loaded_options.Ingame.Hud_scale)
		--radial_shield:set_texture(texture)
		radial_shield:set_bottom(radial_bg:bottom())
	end
end

function HUDTeammate:set_ai_portrait()
	local ai_health = self._panel:child( "ai_health" )
	if self._ai then
		ai_health:set_visible(true)
		local character = managers.criminals:character_name_by_panel_id(self._id)
		--log(character)
		if character then
			local texturehp, rectanglehp = pdth_hud.textures:get_portrait_texture(character .. "_health")
			if texturehp and rectanglehp then
				ai_health:set_image(texturehp, rectanglehp[1], rectanglehp[2], rectanglehp[3], rectanglehp[4])
			end
		end
	elseif ai_health then
		ai_health:set_visible(false)
	end
end

function HUDTeammate:portrait_changed()
	if not self._ai then
		local radial_health_panel = self._player_panel:child("radial_health_panel")
		local radial_health = radial_health_panel:child("radial_health")
		local radial_bg = radial_health_panel:child("radial_bg")
		local radial_shield = radial_health_panel:child("radial_shield")
		local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
		if rectanglehp and rectangleam and rectanglebg then
			local health_offset, armor_offset, height
			if self._main_player then
				health_offset = pdth_hud.health_y_offset
				armor_offset = pdth_hud.armor_y_offset
				height = 129 * pdth_hud.loaded_options.Ingame.Hud_scale
			else
				health_offset = pdth_hud.health_y_offsetsmall
				armor_offset = pdth_hud.armor_y_offsetsmall
				height = 32.5 * pdth_hud.loaded_options.Ingame.Hud_scale
			end
			radial_health:set_color(pdth_hud.health_colour)
			radial_health:set_image(texture, rectanglehp[1], rectanglehp[2] + health_offset, rectanglehp[3], rectanglehp[4] - health_offset)
			radial_health:set_h(height - health_offset)
			radial_bg:set_y(0)
			radial_bg:set_image(texture, rectanglebg[1], rectanglebg[2], rectanglebg[3], rectanglebg[4])
			radial_health:set_bottom(radial_bg:bottom())
			radial_shield:set_image(texture, rectangleam[1], rectangleam[2] + armor_offset, rectangleam[3], rectangleam[4] - armor_offset)
			radial_shield:set_h(height - armor_offset)
			radial_shield:set_bottom(radial_bg:bottom())
		end
	else
		local ai_health = self._panel:child("ai_health")
		local character = managers.criminals:character_name_by_panel_id(self._id)
		local texturehp, rectanglehp = pdth_hud.textures:get_portrait_texture(character .. "_health")
		ai_health:set_image(texturehp, rectanglehp[1], rectanglehp[2], rectanglehp[3], rectanglehp[4])
	end
end

function HUDTeammate:bullet_changed()
	if self._main_player then
		local ammo_panel
		local weapon
		local factory_id
		local weaponid
		local category
		for i = 1, 2 do
			local type = i == 1 and "primary" or "secondary"
			ammo_panel = self._panel:child(type .. "_weapon_ammo")
			if pdth_hud.loaded_options.Ingame.Bullet == 1 then
				for i = 1, 600 do
					if ammo_panel and ammo_panel:child("bullet_" .. i) then
						local bullet = ammo_panel:child("bullet_" .. i)
						bullet:set_visible(false)
					end
				end
			elseif pdth_hud.loaded_options.Ingame.Bullet == 2 or pdth_hud.loaded_options.Ingame.Bullet == 3 then
				if type == "primary" then
					weapon = managers.blackmarket:equipped_primary()
					factory_id = weapon.factory_id
					weaponid = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
					category = tweak_data.weapon[weaponid].category
				else
					weapon = managers.blackmarket:equipped_secondary()
					factory_id = weapon.factory_id
					weaponid = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
					category = tweak_data.weapon[weaponid].category
				end
				local bullet_texture, bullet_rectangle, w, h, scale = pdth_hud.textures:get_icon_data(category .. "_bullet_" .. pdth_hud.loaded_options.Ingame.Bullet, true)
				for i = 1, 600 do
					if ammo_panel and ammo_panel:child("bullet_" .. i) then
						ammo_panel:child("bullet_" .. i):set_image(bullet_texture, bullet_rectangle[1], bullet_rectangle[2], bullet_rectangle[3], bullet_rectangle[4])
						local bullet = ammo_panel:child("bullet_" .. i)
						bullet:set_visible(true)
					end
				end
			end
		end
	end
end
end