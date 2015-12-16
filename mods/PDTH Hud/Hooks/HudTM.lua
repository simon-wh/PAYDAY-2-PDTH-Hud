if pdth_hud.loaded_options.Ingame.MainHud then
HUDTeammate = HUDTeammate or class()
function HUDTeammate:init(i, teammates_panel, is_player, height)
	self._id = i
	local main_player = is_player
	self._main_player = main_player
    
	local const = pdth_hud.constants
	local scale = pdth_hud.loaded_options.Ingame.Hud_scale
    
    local teammate_panel = teammates_panel:panel({
		visible = false,
		name = "" .. i,
        h = height
	})
	self._player_panel = teammate_panel:panel({name = "player"})
	self._panel = teammate_panel
    
    self.health_h = is_player and const.main_health_h or (teammate_panel:h() - (const.tm_health_gap * 2))
	self.health_w = is_player and const.main_health_w or (((teammate_panel:h() - (const.tm_health_gap * 2)) / const.main_health_h) * const.main_health_w)
	
	local gradient
	if not main_player then
		gradient = teammate_panel:gradient({
			name = "gradient",
			w = const.tm_gradient_width,
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
    
	local radial_health_panel = self._player_panel:panel({
		name = "radial_health_panel",
		layer = 11,
		w = self.health_w,
		h = self.health_h
	})
    radial_health_panel:set_bottom(self._player_panel:bottom())
    radial_health_panel:set_left(self._player_panel:left())
    
	if not main_player then
		radial_health_panel:set_center_y(self._player_panel:center_y())
        radial_health_panel:set_left(self._player_panel:left() + const.tm_health_gap)
	end
    
	local radial_bg = radial_health_panel:bitmap({
		name = "radial_bg",
		texture = "guis/textures/pd2/masks",
		align = "bottom",
		blend_mode = "normal",
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 0
	})

	local radial_health = radial_health_panel:bitmap({
		name = "radial_health",
		texture = "guis/textures/pd2/masks",
		blend_mode = "add",
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 1
	})
	local radial_shield = radial_health_panel:bitmap({
		name = "radial_shield",
		texture = "guis/textures/pd2/masks",
		blend_mode = "add",
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 3
	})
    
    local pnlPerk = self._player_panel:panel({
		name = "pnlPerk",
        visible = false,
		layer = 11
	})
    
    pnlPerk:set_w(radial_health_panel:w())
    pnlPerk:set_h(pnlPerk:w() / const.main_perk_multiplier)
    
    pnlPerk:set_bottom(radial_health_panel:top() - const.main_perk_health_gap)
    pnlPerk:set_left(radial_health_panel:left())
    
    local bmpPerkBackground = pnlPerk:bitmap({
		name = "bmpPerkBackground",
		visible = true,
		blend_mode = "normal",
		layer = 1,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			0,
			414,
			360,
			20
		},
        x = 0,
        y = 0,
        w = pnlPerk:w(),
        h = pnlPerk:h()
	})

	local bmpPerkBar = pnlPerk:bitmap({
		name = "bmpPerkBar",
		layer = 2,
		visible = true,
		blend_mode = "normal",
        color = Color.green,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			0,
			392,
			360,
			22
		}
	})
    
    bmpPerkBar:set_w(bmpPerkBackground:w() - const.main_perk_gap)
    bmpPerkBar:set_left(bmpPerkBackground:left() + const.main_perk_gap / 2)
    
    bmpPerkBar:set_h(bmpPerkBackground:h() - const.main_perk_gap)
    bmpPerkBar:set_top(bmpPerkBackground:top() + const.main_perk_gap / 2)
    
	if pdth_hud.loaded_options.Ingame.Coloured then
		radial_health:set_color(Color(0.5, 0.8, 0.4))
	end
    
	if not main_player then
		self:teammate_fix()
	end
	
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
	
    local name = teammate_panel:text({
		name = "name",
		text = "R",
		layer = 1,
		color = Color.white,
		y = 0,
		vertical = "bottom",
		font_size = tweak_data.hud_players.name_size * scale,
		font = tweak_data.menu.small_font
	})
	local _, _, name_w, name_h = name:text_rect()
	
	if main_player then
		name:set_visible(false)
	else
		name:set_font_size(const.tm_name_font_size)
	end
    managers.hud:make_fine_text(name)
    name:set_left(radial_health_panel:right() + const.tm_name_gap)
    name:set_top(radial_health_panel:top())
    
	local radial_custom = radial_health_panel:bitmap({
		name = "radial_custom",
		texture = "guis/textures/trial_diamondheist",
        visible = false,
		texture_rect = {
			0,
			0,
			64,
			130
		},
		blend_mode = "add",
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 3
	})
    
    local ai_health = teammate_panel:bitmap({
		name = "ai_health",
		visible = false,
		texture = "guis/textures/pd2/masks",
		blend_mode = "normal",
		w = self.health_w,
        h = self.health_h,
		layer = 10
	})
    ai_health:set_shape(radial_health_panel:shape())
    
    local character_text
	if main_player then
		character_text = radial_health_panel:text({
			name = "character_text",
			visible = true,
			text = "",
			layer = 4,
			color = Color.white,
			blend_mode = "normal",
			font_size = const.main_character_font_size,
			font = tweak_data.menu.small_font
		})
	end
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
		radial_health:set_image(texture, unpack(rectanglehp))
		radial_shield:set_image(texture, unpack(rectangleam))
		radial_bg:set_image(texture, unpack(rectanglebg))
	end
    
	local x, y, w, h = radial_health_panel:shape()
	local condition_icon = teammate_panel:bitmap({
		name = "condition_icon",
		layer = 12,
		visible = false,
		color = Color.white,
		blend_mode = "normal",
		w = w,
		h = h / 2
	})
	condition_icon:set_center(radial_health_panel:center())
    
	local condition_timer = teammate_panel:text({
		name = "condition_timer",
		visible = false,
		text = "000",
		layer = 13,
		color = Color.white,
		blend_mode = "normal",
		font_size = const.tm_condition_font_size,
		font = tweak_data.hud_players.timer_font
	})
    managers.hud:make_fine_text(condition_timer)
    condition_timer:set_center(condition_icon:center())
    
    local weapons_panel = self._player_panel:panel({
		name = "weapons_panel",
		layer = 11,
	})
    
    self:add_special_equipment({
        id = "primary_weapon",
        icon = "",
        amount = 400,
        no_flash = true,
        --num_on_right = not self._main_player,
        weapon = true,
        default = true,
        weapon_row = true
    })
    
    self:add_special_equipment({
        id = "secondary_weapon",
        icon = "",
        amount = 400,
        no_flash = true,
        --num_on_right = not self._main_player,
        weapon = true,
        default = true,
        weapon_row = true
    })
    
    self:add_special_equipment({
        id = "grenades_panel",
        icon = "frag_grenade",
        amount = 12,
        no_flash = true,
        --num_on_right = not self._main_player,
        --weapon = true,
        default = true,
        weapon_row = true
    })
    
    self:add_special_equipment({
        id = "deployable_equipment_panel",
        icon = "equipment_doctor_bag",
        amount = 2,
        --num_on_right = not self._main_player,
        no_flash = true,
        default = true
    })
    
    self:add_special_equipment({
        id = "cable_ties_panel",
        icon = tweak_data.equipments.specials.cable_tie.icon,
        amount = 2,
        --num_on_right = not self._main_player,
        no_flash = true,
        default = true
    })
    
    self:layout_special_equipments()
    
    if self._main_player then
        local grenades_panel = self._player_panel:child("grenades_panel")
        local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
        self._primary_weapon_ammo = self._player_panel:panel({
            id = "primary_weapon_ammo",
            h = self._player_panel:h() - grenades_panel:bottom(),
            w = self._panel:w(),
            visible = false,
            layer = 1
        })
        self._primary_weapon_ammo:set_right(deployable_equipment_panel:center_x())
        self._primary_weapon_ammo:set_bottom(teammate_panel:bottom())
        
        self._secondary_weapon_ammo = self._player_panel:panel({
            id = "secondary_weapon_ammo",
            visible = false,
            layer = 1
        })
        self._secondary_weapon_ammo:set_shape(self._primary_weapon_ammo:shape())
    end
    
    local tabs_texture = "guis/textures/pd2/hud_tabs"
    
	local bag_rect = {
		32,
		33,
		32,
		31
	}

	local carry_panel = self._player_panel:panel({
		name = "carry_panel",
		visible = false,
		layer = 1,
		w = name:h(),
		h = name:h(),
	})
    
	local carry_bitmap = carry_panel:bitmap({
		name = "bag",
		texture = tabs_texture,
		w = carry_panel:w(),
		h = carry_panel:h(),
		texture_rect = bag_rect,
		visible = true,
		layer = 0,
		color = Color.white,
	})
    
	local interact_panel = self._player_panel:panel({
		name = "interact_panel",
		visible = false,
		layer = 14,
        w = radial_health_panel:h(),
        h = radial_health_panel:h()
	})
    
    interact_panel:set_center(radial_health_panel:center())
    
	self._interact = CircleBitmapGuiObject:new(interact_panel, {
		use_bg = true,
		rotation = 360,
		radius = radial_health_panel:h() / 2,
		blend_mode = "add",
		color = Color.white,
		layer = 0
	})

	self.texture_rect = nil
	self.weaponid = nil
	self.weapon = nil
	self.factory_id = nil
	self.category = nil
	self.w = nil
	self.h = nil
	self.scale = nil
	self._character = nil
	self._no = 1
end

function HUDTeammate:_create_primary_weapon_firemode()
	--[[local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
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
	end]]--
end

function HUDTeammate:_create_secondary_weapon_firemode()
	--[[local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
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
	end]]--
end

function HUDTeammate:_set_weapon_selected(id, hud_icon)
	local is_secondary = id == 1
	local primary_weapon_panel = self._player_panel:child("primary_weapon")
    local secondary_weapon_panel = self._player_panel:child("secondary_weapon")
	primary_weapon_panel:child("bitmap"):set_alpha(is_secondary and 0.5 or 1)
	secondary_weapon_panel:child("bitmap"):set_alpha(is_secondary and 1 or 0.5)
    
    if self._main_player then
        primary_weapon_panel:child("amount"):set_visible(is_secondary)
        secondary_weapon_panel:child("amount"):set_visible(not is_secondary)
        self._primary_weapon_ammo:set_visible(not is_secondary)
        self._secondary_weapon_ammo:set_visible(is_secondary)
    end
    
    if not self._set_weapon_icons then
        local peer, blackmarket_outfit
        if managers.network:session() then
            peer = managers.network:session():peer(self._peer_id)
            
            if peer and peer._profile["outfit_string"] then
                blackmarket_outfit = peer:blackmarket_outfit()
            elseif not self._main_player then
                return
            end
        elseif not self._main_player then
            return
        end
        
        local prim_factory_id = self._main_player and managers.blackmarket:equipped_primary().factory_id or blackmarket_outfit.primary.factory_id
        local prim_weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(prim_factory_id)
        local prim_category = tweak_data.weapon[prim_weapon_id].category
        
        local sec_factory_id = self._main_player and managers.blackmarket:equipped_secondary().factory_id or blackmarket_outfit.secondary.factory_id
        local sec_weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(sec_factory_id)
        local sec_category = tweak_data.weapon[sec_weapon_id].category
        
        local texture, rectangle = pdth_hud.textures:get_weapon_texture(prim_weapon_id, prim_category)
        if texture ~= nil and rectangle ~= nil then
            primary_weapon_panel:child("bitmap"):set_image(texture, unpack(rectangle))
        end
        
        local texture, rectangle = pdth_hud.textures:get_weapon_texture(sec_weapon_id, sec_category)
        if texture ~= nil and rectangle ~= nil then
            secondary_weapon_panel:child("bitmap"):set_image(texture, unpack(rectangle))
        end
        
        self._set_weapon_icons = true
    end
end

function HUDTeammate:set_weapon_selected(id, hud_icon)
	self:_set_weapon_selected(id, hud_icon)
end

function HUDTeammate:set_weapon_firemode(id, firemode)
	--[[local is_secondary = id == 1
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
	end]]--
end

function HUDTeammate:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max)
    local const = pdth_hud.constants
    local scale = pdth_hud.loaded_options.Ingame.Hud_scale
	local ammo = self._main_player and pdth_hud.loaded_options.Ingame.spooky_ammo and current_left + current_clip or current_left
	self:set_special_equipment_amount(type .. "_weapon", ammo)
        
	pdth_hud._max_clip = max_clip
	if self._main_player then
		local ammo_panel = type == "primary" and self._primary_weapon_ammo or self._secondary_weapon_ammo
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
        local ammo = ammo_panel:child("ammo")
		if not ammo then
			ammo = ammo_panel:text({
				name = "ammo",
				text = "000/000",
				layer = 1,
				font = tweak_data.menu.small_font,
				font_size = const.main_ammo_font_size
			})
            managers.hud:make_fine_text(ammo)
            ammo:set_center_y(ammo_panel:h() / 2)
            ammo:set_right(ammo_panel:w() - (const.main_equipment_size / 2))
            
		end
        
        local clip_zero = current_clip < 10 and "00" or current_clip < 100 and "0" or ""
        local left_zero = current_left < 10 and "00" or current_left < 100 and "0" or ""
        
        ammo:set_text(clip_zero .. current_clip .. "/" .. left_zero .. current_left)
        
		if current_left <= 0 then
            ammo:set_range_color(3, 7, Color.red)
		else
            ammo:set_range_color(3, 7, Color.white)
		end
        
        
		local r, g, b = 1, 1, 1
		if current_clip <= math.round(max_clip / 4) then
			g = current_clip / (max_clip / 2)
			b = current_clip / (max_clip / 2)
		end
		ammo:set_range_color(0, 3, Color(1, r, g, b))
        
        local forbidCat = {
            "minigun",
            "saw",
            "flamethrower",
            "bow",
            "crossbow"
        }
        
		if not table.contains(forbidCat, self.category) and pdth_hud.loaded_options.Ingame.Bullet ~= 1 then
			local icon, texture_rect = pdth_hud.textures:get_icon_data(self.category .. "_bullet_" .. pdth_hud.loaded_options.Ingame.Bullet, true)
            
            local h = ammo:h() * const.main_ammo_size_multiplier
            local w = (h / texture_rect[4]) * texture_rect[3]
            
            
			for i = 1, max_clip do
				if not ammo_panel:child("bullet_" .. i) then
					local bullet = ammo_panel:bitmap({
						name = "bullet_" .. i,
						visible = true,
						layer = 1,
						blend_mode = "normal",
						w = w,
						h = h,
					})
                    local prev_bullet = ammo_panel:child("bullet_" .. i - 1)
                    bullet:set_right(prev_bullet and prev_bullet:left() or ammo:left() - const.main_ammo_image_gap)
                    bullet:set_center_y(ammo:center_y())
					bullet:set_image(icon, unpack(texture_rect))
				end
				
			end
			
			for i = 1, current_clip do
                local bullet = ammo_panel:child("bullet_" .. i)
				if bullet then
					bullet:set_alpha(1)
				end
			end
			
			for i = current_clip + 1, max_clip do
                local bullet = ammo_panel:child("bullet_" .. i)
				if bullet then
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
					if bullet:alpha() == 0.5 then
						bullet:set_color(Color(0.2, r, g, b))
					else
						bullet:set_color(Color(0.8, r, g, b))
					end
				end
			end
		else
			for _, child in pairs(ammo_panel:children()) do
                if not child:name() == "ammo" then
                    ammo_panel:remove(child)
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
	local bmpHealthCharge = radial_health_panel:child("bmpHealthCharge")
    
	local amount = data.current / data.total
	if amount < radial_health:color().red then
		self:_damage_taken()
	end
    
	if teammate_panel:child( "ai_health" ) then	
		teammate_panel:remove( teammate_panel:child( "ai_health" ) )
	end
	
	
	local y_offset_scaled = self.health_h * (1 - amount)
	pdth_hud.health_y_offset = y_offset
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
        local y_offset = rectanglehp[4] * (1 - amount)
		radial_health:set_image(texture, rectanglehp[1], rectanglehp[2] + y_offset, rectanglehp[3], rectanglehp[4] - y_offset)
	end
	if not self._main_player then
		radial_health:set_h(self.health_h - y_offset_scaled)
		radial_health:set_bottom(radial_bg:bottom())
	else
		radial_health:set_h(self.health_h - y_offset_scaled)
		radial_health:set_bottom(radial_bg:bottom())
	end
	local color = amount < 0.33 and Color(1, 0, 0) or Color(0.5, 0.8, 0.4)
	pdth_hud.colour_amount = amount
	pdth_hud.health_colour = color
	if pdth_hud.loaded_options.Ingame.Coloured then
		radial_health:set_color(color)
	else
		radial_health:set_color(Color.white)
	end
end

function HUDTeammate:set_armor(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_shield = radial_health_panel:child("radial_shield")
	local radial_bg = radial_health_panel:child("radial_bg")
	local radial_health = radial_health_panel:child("radial_health")
	local bmpHealthCharge = radial_health_panel:child("bmpHealthCharge")
	local amount = data.current / data.total
	if amount < radial_shield:color().red then
		self:_damage_taken()
	end
	
	local y_offset_scaled = self.health_h * (1 - amount)
	pdth_hud.armor_y_offset = y_offset
	local rectanglehp, rectangleam, rectanglebg, texture = self:set_character_portrait()
	if rectanglehp and rectangleam and rectanglebg and texture then
        local y_offset = rectangleam[4] * (1 - amount)
    
		radial_shield:set_image(texture, rectangleam[1], rectangleam[2] + y_offset, rectangleam[3], rectangleam[4] - y_offset)
	end
	if not self._main_player then
		radial_shield:set_h(self.health_h - y_offset_scaled)
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
	local y_offset = 130 * (1 - amount)
	radial_custom:set_texture_rect(0, 0 + y_offset, 64, 130 - y_offset)
	radial_custom:set_h(self.health_h - y_offset)
	radial_custom:set_bottom(radial_bg:bottom())
	radial_custom:show()
end

function HUDTeammate:_damage_taken()
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local damage_indicator = radial_health_panel:child("damage_indicator")
	local player = managers.player:player_unit()
	if not self._main_player and not managers.trade:is_peer_in_custody(self._peer_id) and not self._ai then
		local gradient = self._panel:child("gradient")
		gradient:animate(callback(self, self, "mugshot_damage_taken"))
	end
end

function HUDTeammate:mugshot_damage_taken(gradient)
  	local a1 = 0.4
  	local a2 = 0.0
  	gradient:set_gradient_points({ 
        0, 
        Color(a1, 1, 0 ,0), 
        1, 
        Color(a2, 1, 0 ,0) 
    })
  	local i = 1.0
  	local t = i
  	while t > 0 do
  		local dt = coroutine.yield()
  		t = t - dt
  		gradient:set_gradient_points({ 
            0, 
            Color(a1, (t / i), 0 ,0), 
            1, 
            Color(a2, (t / i), 0 ,0) 
        })
  	end
  	gradient:set_gradient_points({
        0, 
        Color(a1, 0, 0 ,0), 
        1,
        Color(a2, 0, 0 ,0) 
    })
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

function HUDTeammate:set_cable_tie(data)
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
    self:set_special_equipment_image("cable_ties_panel", "guis/textures/hud_icons", {0, 144, 48, 48})
	self:set_cable_ties_amount(data.amount)
end

function HUDTeammate:set_cable_ties_amount(amount)
    if self._main_player then
        self:set_special_equipment_amount("cable_ties_panel", amount)
    end
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

function HUDTeammate:add_panel()
	local teammate_panel = self._panel
	teammate_panel:set_visible(true)
    self:set_condition("mugshot_normal")
	
    for i, special in pairs(self._special_equipment) do
        if special.default then
            special.panel:set_visible(true)
        end
	end
    
    if not self._player_panel:child("grenades_panel") then
        self:add_special_equipment({
            id = "grenades_panel",
            icon = "",
            amount = 12,
            no_flash = true,
            --num_on_right = not self._main_player,
            --weapon = true,
            default = true,
            weapon_row = true
        })
        self._player_panel:child("grenades_panel"):set_visible(false)
    end
    
    if not self._player_panel:child("deployable_equipment_panel") then
        self:add_special_equipment({
            id = "deployable_equipment_panel",
            icon = "",
            amount = 2,
            --num_on_right = not self._main_player,
            no_flash = true,
            default = true
        })
        self._player_panel:child("deployable_equipment_panel"):set_visible(false)
    end
    
    if not self._player_panel:child("cable_ties_panel") then
        self:add_special_equipment({
            id = "cable_ties_panel",
            icon = tweak_data.equipments.specials.cable_tie.icon,
            amount = 2,
            --num_on_right = not self._main_player,
            no_flash = true,
            default = true
        })
        self._player_panel:child("cable_ties_panel"):set_visible(false)
    end
    
	self:teammate_progress(false, false, false, false)
end

function HUDTeammate:remove_panel()
	local teammate_panel = self._panel
	teammate_panel:set_visible(false)
	local special_equipment = self._special_equipment
	for i, special in pairs(special_equipment) do
        if not special.default then
            teammate_panel:remove(special.panel)
            table.remove(special_equipment, i)
        end
	end
	self:set_condition("mugshot_normal")
	self._player_panel:child("primary_weapon"):set_visible(false)
	self._player_panel:child("secondary_weapon"):set_visible(false)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
    if deployable_equipment_panel then
        deployable_equipment_panel:set_visible(false)
    end

	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
    if cable_ties_panel then
        cable_ties_panel:set_visible(false)
    end
	self._player_panel:child("carry_panel"):set_visible(false)
	self:set_cheater(false)
	self:stop_timer()
	self:teammate_progress(false, false, false, false)
	self._peer_id = nil
	self._ai = nil
    self._set_weapon_icons = false
end

function HUDTeammate:set_name(teammate_name)
	local teammate_panel = self._panel
	local name = teammate_panel:child("name")
    local radial_health_panel = self._player_panel:child("radial_health_panel")
    local carry_panel = self._player_panel:child("carry_panel")
	self._teammate_name = teammate_name
	name:set_text(utf8.to_upper(" " .. teammate_name))
	managers.hud:make_fine_text(name)
    name:set_left(radial_health_panel:right() + pdth_hud.constants.tm_name_gap)
    name:set_top(radial_health_panel:top())
    carry_panel:set_left(name:right())
    carry_panel:set_top(name:top())
end

function HUDTeammate:set_callsign(id)
end

function HUDTeammate:set_state(state)
	local teammate_panel = self._panel
	local is_player = state == "player"
	local radial_health_panel = self._panel:child("player"):child("radial_health_panel")
	local name = teammate_panel:child("name")
    local carry_panel = self._player_panel:child("carry_panel")
    local ai_health = teammate_panel:child("ai_health")
	if not self._main_player then
		local gradient = self._panel:child("gradient")
        managers.hud:make_fine_text(name)
        name:set_left(radial_health_panel:right() + pdth_hud.constants.tm_name_gap)
        name:set_top(radial_health_panel:top())
        carry_panel:set_left(name:right())
        carry_panel:set_top(name:top())
		if is_player then
            self._set_weapon_icons = false
            for i, special in pairs(self._special_equipment) do
                special.panel:set_visible(true)
            end
            radial_health_panel:set_visible(true)
			ai_health:set_visible(false)
		else
            self._set_weapon_icons = false
            for i, special in pairs(self._special_equipment) do
                if special.default then
                    special.panel:set_visible(false)
                else
                    self._player_panel:remove(special.panel)
                end
            end
            radial_health_panel:set_visible(false)
            ai_health:set_visible(true)
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
		self:teammate_fix()
	end
end

function HUDTeammate:set_deployable_equipment(data)
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
    
	self:set_special_equipment_image("deployable_equipment_panel", icon, texture_rect)
	self:set_deployable_equipment_amount(1, data)
end

function HUDTeammate:set_deployable_equipment_amount(index, data)
	self:set_special_equipment_amount("deployable_equipment_panel", data.amount)
end

function HUDTeammate:set_grenades(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	self:set_grenades_amount(data)
	self:set_special_equipment_image("grenades_panel", icon, texture_rect)
end

function HUDTeammate:set_grenades_amount(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
    
	self:set_special_equipment_amount("grenades_panel", data.amount)
end

function HUDTeammate:add_special_equipment(data)
    -- id, icon, amount, no_flash
    local const = pdth_hud.constants
	local teammate_panel = self._player_panel
    self._special_equipment = self._special_equipment or {}
    self._weapons = self._weapons or {}
	local special_equipment = self._special_equipment
	local id = data.id
    
    local teammate_height = 16
    local name = self._panel:child("name")
    if not self._main_player then
        teammate_height = self._player_panel:child("radial_health_panel"):h() - name:h() + (const.tm_equipment_inflation * pdth_hud.loaded_options.Ingame.Hud_scale)
    end
    
    local w = (self._main_player and const.main_equipment_size or teammate_height)
    local h = (self._main_player and const.main_equipment_size or teammate_height)
    
	local equipment_panel = teammate_panel:panel({
		name = id,
		layer = 0,
        w = w,
        h = h
	})
    
    local icon, texture_rect
	if data.icon == "pd2_c4" then
		icon, texture_rect = tweak_data.hud_icons:get_icon_data("equipment_c4")
	else
		icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	end
    
	local bitmap = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		layer = 1,
		texture_rect = texture_rect,
		w = w,
		h = h
	})
    
	local amount, amount_bg
	if data.amount then
		amount = equipment_panel:text({
			name = "amount",
			text = tostring(data.amount),
			font = tweak_data.menu.small_font,
			font_size = (self._main_player and const.main_equipment_font_size or const.tm_equipment_font_size),
			color = Color.white,
			layer = 4,
		})
        managers.hud:make_fine_text(amount)
		amount:set_visible(data.amount > 1)
        
        local amx, amy, amw, amh = amount:text_rect()
        equipment_panel:set_w(w + (data.num_on_right and amw + const.num_on_right_inflation or 0))
        
        amount:set_right(equipment_panel:w())
        
        if data.num_on_right then
            amount:set_center_y(equipment_panel:center_y())
        else
            amount:set_bottom(equipment_panel:bottom())
        end
	end

    local panelData = {panel = equipment_panel, weapon = data.weapon, num_on_right = data.num_on_right, default = data.default}
    
    if self._main_player and data.weapon_row then
        table.insert(self._weapons, panelData)
    else
        table.insert(special_equipment, panelData)
    end
    
    if not data.no_flash then
        bitmap:animate(callback(self, self, "equipment_flash_icon"))
    end
    
    if not data.default then
        self:layout_special_equipments()
    end
end

function HUDTeammate:remove_special_equipment(equipment)
	local teammate_panel = self._player_panel
	local special_equipment = self._special_equipment
	for i, special in ipairs(special_equipment) do
        local panel = special.panel
		if panel:name() == equipment then
			local data = table.remove(special_equipment, i)
			teammate_panel:remove(panel)
			self:layout_special_equipments()
			break
		end
	end
    
    for i, weap in ipairs(self._weapons) do
        local panel = weap.panel
		if panel:name() == equipment then
			local data = table.remove(self._weapons, i)
			teammate_panel:remove(panel)
			self:layout_special_equipments()
			break
		end
	end
end

function HUDTeammate:equipment_flash_icon( o)
  	local t = 4
    while t > 0 do
		local dt = coroutine.yield()
        t = t - dt
		o:set_color( tweak_data.hud.prime_color:with_alpha( 0.5 + (math.sin( Application:time() * 750) + 1) / 4 ))
	end
    
    o:set_color(Color.white)
end

function HUDTeammate:set_special_equipment_amount(equipment_id, amount)
    local const = pdth_hud.constants
	local teammate_panel = self._player_panel
	local special_equipment = self._special_equipment
    
    local function apply_setting(i, special, panel)
        local txtAmount = panel:child("amount")
        panel:set_visible(true)
        txtAmount:set_text(tostring(amount))
        managers.hud:make_fine_text(txtAmount)
        local amx, amy, amw, amh = txtAmount:text_rect()
        if not special.weapon then
            panel:set_w(panel:child("bitmap"):w() + (special.num_on_right and amw + const.num_on_right_inflation or 0))
        end
        txtAmount:set_right(panel:w())
        if not special.default then
            txtAmount:set_visible(tonumber(amount) > 1)
        end
        if tonumber(amount) < 1 and not special.weapon then
            teammate_panel:remove(panel)
            table.remove(self._special_equipment, i)
        end
    end
    
    for i, special in ipairs(special_equipment) do
        local panel = special.panel
        if panel and panel:name() == equipment_id then
            apply_setting(i, special, panel)
        end
    end
    
    for i, weap in ipairs(self._weapons) do
        local panel = weap.panel
        if panel and panel:name() == equipment_id then
            apply_setting(i, weap, panel)
        end
    end
    
    self:layout_special_equipments()
end

function HUDTeammate:set_special_equipment_image(equipment_id, image, texture_rect)
    for i, special in ipairs(self._special_equipment) do
        local panel = special.panel
        if panel and panel:name() == equipment_id then
            panel:child("bitmap"):set_image(image, unpack(texture_rect))
        end
    end
end

function HUDTeammate:layout_special_equipments()
    local const = pdth_hud.constants
	local teammate_panel = self._player_panel
	local special_equipment = self._special_equipment
	local name = self._panel:child("name")
    local radial_health_panel = self._player_panel:child("radial_health_panel")
    
    local gap = const.equipment_gap 
	for i, special in ipairs(special_equipment) do
        local panel = special.panel
        if self._main_player and panel then
			panel:set_right(teammate_panel:right() - panel:w() / 2)
            panel:set_bottom(self._special_equipment[i - 1] and self._special_equipment[i - 1].panel:top() or teammate_panel:bottom() - (panel:h() * const.main_equipment_y_offset_multiplier))
		elseif panel then
			panel:set_left(special_equipment[i - 1] and special_equipment[i - 1].panel and (special_equipment[i - 1].panel:right() + gap) or radial_health_panel:right() + gap)
			panel:set_bottom(radial_health_panel:bottom() + 2)
		end
	end
    
    if self._main_player then
        for i, weap in ipairs(self._weapons) do
            local panel = weap.panel
            panel:set_right(special_equipment[1].panel:left() - (panel:w() * (#self._weapons - i)))
            panel:set_top(special_equipment[1].panel:bottom())
        end
    end
end

function HUDTeammate:set_condition(icon_data, text)
	local condition_icon = self._panel:child("condition_icon")
	local name = self._panel:child("name")
	if icon_data == "mugshot_normal" then
		condition_icon:set_visible(false)
	else
		condition_icon:set_visible(true)
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(icon_data)
		condition_icon:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	end
end

function HUDTeammate:teammate_progress(enabled, tweak_data_id, timer, success)
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
		bitmap:set_position(self._player_panel:child("interact_panel"):x(), self._player_panel:child("interact_panel"):y())
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

function HUDTeammate:_animate_timer()
	local rounded_timer = math.round(self._timer)
	while self._timer >= 0 do
		local dt = coroutine.yield()
		if self._timer_paused == 0 then
			self._timer = self._timer - dt
			local text = self._timer < 0 and "00" or (math.round(self._timer) < 10 and "0" or "") .. math.round(self._timer)
			self._panel:child("condition_timer"):set_text(text)
			managers.hud:make_fine_text(self._panel:child("condition_timer"))
            self._panel:child("condition_timer"):set_center(self._player_panel:child("radial_health_panel"):center())
			if rounded_timer > math.round(self._timer) then
				rounded_timer = math.round(self._timer)
				if rounded_timer < 11 then
					self._panel:child("condition_timer"):animate(callback(self, self, "_animate_timer_flash"))
				end
			end
		end
	end
end

function HUDTeammate:_animate_timer_flash()
    local const = pdth_hud.constants
	local t = 0
	local condition_timer = self._panel:child("condition_timer")
	while t < 0.5 do
		t = t + coroutine.yield()
		local n = 1 - math.sin(t * 180)
		local r = math.lerp(1 or self._point_of_no_return_color.r, 1, n)
		local g = math.lerp(0 or self._point_of_no_return_color.g, 0.8, n)
		local b = math.lerp(0 or self._point_of_no_return_color.b, 0.2, n)
		condition_timer:set_color(Color(r, g, b))
		condition_timer:set_font_size(math.lerp(const.tm_condition_font_size, const.tm_condition_font_size_flash, n))
	end
	condition_timer:set_font_size(const.tm_condition_font_size) 
end

function HUDTeammate:set_carry_info(carry_id, value)
	local carry_panel = self._player_panel:child("carry_panel")
	carry_panel:set_visible(true)
	local value_text = carry_panel:child("value")
end

function HUDTeammate:set_character_portrait()
    local const = pdth_hud.constants
    local radial_health_panel = self._player_panel:child("radial_health_panel")
	local character_text = radial_health_panel:child("character_text")
	local main_character = managers.network:session() and managers.network:session():local_peer():character()
	
	if self._main_player then
		local character_name = string.upper(managers.localization:text("menu_" .. main_character))
		character_text:set_text(character_name)
        managers.hud:make_fine_text(character_text)
        character_text:set_center_x(radial_health_panel:center_x())
        character_text:set_bottom(radial_health_panel:h() - const.main_character_y_offset)
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
		radial_health:set_image(texture, unpack(rectanglehp))
		radial_health:set_h(self.health_h)
		radial_bg:set_y(0)
		radial_bg:set_image(texture, unpack(rectanglebg))
		radial_health:set_bottom(radial_bg:bottom())
		radial_shield:set_image(texture, unpack(rectangleam))
		radial_shield:set_h(self.health_h)
		radial_shield:set_bottom(radial_bg:bottom())
	end
end

function HUDTeammate:set_ai_portrait()
	local ai_health = self._panel:child("ai_health")
	if self._ai then
		ai_health:set_visible(true)
		local character = managers.criminals:character_name_by_panel_id(self._id)
		if character then
			local texturehp, rectanglehp = pdth_hud.textures:get_portrait_texture(character .. "_health")
			if texturehp and rectanglehp then
				ai_health:set_image(texturehp, unpack(rectanglehp))
			end
		end
	elseif ai_health then
		ai_health:set_visible(false)
	end
end

function HUDTeammate:set_stored_health_max(stored_health_ratio)
    local pnlPerk = self._player_panel:child("pnlPerk")
    local bmpPerkBackground = pnlPerk:child("bmpPerkBackground")
    local bmpPerkBar = pnlPerk:child("bmpPerkBar")
    
	if alive(bmpPerkBackground) then
		local red = math.min(stored_health_ratio, 1)
		bmpPerkBackground:set_color(Color(1, red, 1, 1))
	end
end
function HUDTeammate:set_stored_health(stored_health_ratio)
    local const = pdth_hud.constants
    local pnlPerk = self._player_panel:child("pnlPerk")
    local bmpPerkBackground = pnlPerk:child("bmpPerkBackground")
    local bmpPerkBar = pnlPerk:child("bmpPerkBar")
    
	if alive(bmpPerkBar) then
		local red = math.min(stored_health_ratio, 1)
		pnlPerk:set_visible(red > 0)
		bmpPerkBar:set_w((pnlPerk:w() - const.main_perk_gap) * red)
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
			local health_offset = pdth_hud.health_y_offset
            local armor_offset = pdth_hud.armor_y_offset
			local height = self.health_h
                
            health:set_color(pdth_hud.health_colour)
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