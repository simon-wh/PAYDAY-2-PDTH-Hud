if pdth_hud.Options.HUD.MainHud then
    function HUDTeammate:init(i, teammates_panel, is_player, height)
        self._id = i
        local main_player = is_player
        self._main_player = main_player
        
        local const = pdth_hud.constants
        local scale = pdth_hud.Options.HUD.Scale
        
        local teammate_panel = teammates_panel:panel({
            visible = false,
            name = "" .. i,
            h = height
        })
        self._player_panel = teammate_panel:panel({name = "player"})
        self._panel = teammate_panel
        
        self.health_h = is_player and const.main_health_h or (teammate_panel:h() - (const.tm_health_gap * 2))
        self.health_w = is_player and const.main_health_w or ((self.health_h / (pdth_hud.Options.HUD.OGTMHealth and const.tm_health_h or const.main_health_h)) * (pdth_hud.Options.HUD.OGTMHealth and const.tm_health_w or const.main_health_w))
        
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
        radial_health_panel:set_bottom(self._player_panel:h())
        radial_health_panel:set_left(0)
        
        local character_icon
        if not main_player then
            radial_health_panel:set_center_y(self._player_panel:h() / 2)
            radial_health_panel:set_left(const.tm_health_gap)
            
            character_icon = self._player_panel:bitmap({
                name = "character_icon",
                texture = "guis/textures/hud_icons",
                w = self.health_h,
                h = self.health_h,
                visible = pdth_hud.Options.HUD.OGTMHealth,
                layer = 1
            })
            character_icon:set_center_y(self._player_panel:center_y())
            character_icon:set_left(radial_health_panel:right() + const.tm_health_gap)
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
        
        if pdth_hud.Options.HUD.Coloured then
            radial_health:set_color(Color(0.5, 0.8, 0.4))
        end
        
        local talk_icon, talk_texture_rect = tweak_data.hud_icons:get_icon_data("mugshot_talk")
        local talk = teammate_panel:bitmap({
            name = "talk",
            texture = talk_icon,
            visible = false,
            layer = 14,
            texture_rect = talk_texture_rect,
            w = talk_texture_rect[3] * scale,
            h = talk_texture_rect[4] * scale
        })
        if main_player or not pdth_hud.Options.HUD.OGTMHealth then
            talk:set_righttop(radial_health_panel:right() + (5), radial_health_panel:top() - (5))
        else
            talk:set_righttop(character_icon:right(), character_icon:top())
        end
        
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
        local name_bg = teammate_panel:bitmap({name = "name_bg", visible = false, w = 0, h = 0})
        local callsign = teammate_panel:bitmap({name = "callsign", visible = false, w = 0, h = 0})
        
        if main_player then
            name:set_visible(false)
        else
            name:set_font_size(const.tm_name_font_size)
            managers.hud:make_fine_text(name)
            name:set_left((pdth_hud.Options.HUD.OGTMHealth and character_icon:right() or radial_health_panel:right() ) + const.tm_name_gap)
            name:set_top(character_icon:top())
        end
        
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
        
        local condition_icon = teammate_panel:bitmap({
            name = "condition_icon",
            layer = 12,
            visible = false,
            color = Color.white,
            blend_mode = "normal"
        })
        if main_player or not pdth_hud.Options.HUD.OGTMHealth then
            condition_icon:set_w(radial_health_panel:w())
            condition_icon:set_h(radial_health_panel:h() / 2)
        else
            condition_icon:set_w(character_icon:w() / const.tm_condition_demultiplier)
            condition_icon:set_h(character_icon:h() / const.tm_condition_demultiplier)
        end
        
        condition_icon:set_center_x((main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:center_x() or character_icon:center_x())
        condition_icon:set_center_y((main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:center_y() or character_icon:center_y())
        
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
            id = "secondary_weapon",
            icon = "",
            amount = 400,
            no_flash = true,
            weapon = true,
            default = true
        })
        
        self:add_special_equipment({
            id = "primary_weapon",
            icon = "",
            amount = 400,
            no_flash = true,
            weapon = true,
            default = true
        })
        
        self:add_special_equipment({
            id = "grenades_panel",
            icon = "frag_grenade",
            amount = 12,
            no_flash = true,
            weapon = main_player,
            default = true
        })
        
        self:add_special_equipment({
            id = "deployable_equipment_panel",
            icon = "equipment_doctor_bag",
            amount = 2,
            no_flash = true,
            default = true
        })
        
        self:add_special_equipment({
            id = "cable_ties_panel",
            icon = tweak_data.equipments.specials.cable_tie.icon,
            amount = 2,
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
            self._primary_weapon_ammo:set_right(deployable_equipment_panel:right() - const.main_ammo_panel_x_offset)
            self._primary_weapon_ammo:set_bottom(teammate_panel:bottom())
            self:InitAmmoPanel(self._primary_weapon_ammo)
            self._secondary_weapon_ammo = self._player_panel:panel({
                id = "secondary_weapon_ammo",
                visible = false,
                layer = 1
            })
            self._secondary_weapon_ammo:set_shape(self._primary_weapon_ammo:shape())
            self:InitAmmoPanel(self._secondary_weapon_ammo)
        end
        
        local tabs_texture = "guis/textures/pd2/hud_tabs"
        
        local bag_rect = {32, 33, 32, 31}

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
            w = (main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:h() or character_icon:h(),
            h = (main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:h() or character_icon:h()
        })
        
        interact_panel:set_center_x((main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:center_x() or character_icon:center_x())
        interact_panel:set_center_y((main_player or not pdth_hud.Options.HUD.OGTMHealth) and radial_health_panel:center_y() or character_icon:center_y())
        
        self._interact = CircleBitmapGuiObject:new(interact_panel, {
            use_bg = true,
            rotation = 360,
            radius = interact_panel:h() / 2,
            blend_mode = "add",
            color = Color.white,
            layer = 0
        })
        
        self.health_amount = 1
        self.armor_amount = 1
        self.health_colour = Color(0.5, 0.8, 0.4)
        self._max_clip = 0
        self._current_primary = nil
        self._current_secondary = nil
        self:RefreshPortraits()
        self._set_max_clip = {}
        self._set_max_clip.primary = 0
        self._set_max_clip.secondary = 0
    end

    function HUDTeammate:_create_primary_weapon_firemode()
        if self._main_player then
            local equipped_primary = managers.blackmarket:equipped_primary()
            local weapon_tweak_data = tweak_data.weapon[equipped_primary.weapon_id]
            local fire_mode = weapon_tweak_data.FIRE_MODE
            local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
            local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_primary.factory_id, equipped_primary.blueprint)
            local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_primary.factory_id, equipped_primary.blueprint)
            if locked_to_single or not locked_to_auto and fire_mode == "single" then
                self:set_weapon_firemode(2, "single")
            else
                self:set_weapon_firemode(2, "auto")
            end
        end
    end

    function HUDTeammate:_create_secondary_weapon_firemode()
        if self._main_player then
            local equipped_secondary = managers.blackmarket:equipped_secondary()
            local weapon_tweak_data = tweak_data.weapon[equipped_secondary.weapon_id]
            local fire_mode = weapon_tweak_data.FIRE_MODE
            local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
            local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_secondary.factory_id, equipped_secondary.blueprint)
            local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_secondary.factory_id, equipped_secondary.blueprint)
            if locked_to_single or not locked_to_auto and fire_mode == "single" then
                log("set single")
                self:set_weapon_firemode(1, "single")
            else
                log("set auto")
                self:set_weapon_firemode(1, "auto")
            end
        end
    end
    
    function HUDTeammate:set_weapon_firemode_burst(id, firemode, burst_fire)
        local is_secondary = id == 1
        local weapPanel = is_secondary and self._secondary_weapon_ammo or self._primary_weapon_ammo
        if alive(weapPanel) then
            local firemodeText = weapPanel:child("firemode")
            if alive(firemodeText)then
                firemodeText:set_text("BRST")
                firemodeText:set_visible(pdth_hud.Options.HUD.Fireselector)
            end
        end
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
        
        if self._current_primary == prim_weapon_id and self._current_secondary == sec_weapon_id then
            return
        end
        
        self._current_primary = prim_weapon_id
        self._current_secondary = sec_weapon_id
        
        local texture, rectangle = pdth_hud.textures:get_weapon_texture(prim_weapon_id, prim_category)
        if texture ~= nil and rectangle ~= nil then
            primary_weapon_panel:child("bitmap"):set_image(texture, unpack(rectangle))
        end
        
        local texture, rectangle = pdth_hud.textures:get_weapon_texture(sec_weapon_id, sec_category)
        if texture ~= nil and rectangle ~= nil then
            secondary_weapon_panel:child("bitmap"):set_image(texture, unpack(rectangle))
        end
    end

    function HUDTeammate:set_weapon_firemode(id, firemode)
        local is_secondary = id == 1
        local weapPanel = is_secondary and self._secondary_weapon_ammo or self._primary_weapon_ammo
        if alive(weapPanel) then
            local firemodeText = weapPanel:child("firemode")
            if alive(firemodeText)then
                if firemode == "single" then
                    log("set semi")
                    firemodeText:set_text("SEMI")
                else
                    log("set set auto")
                    firemodeText:set_text("AUTO")
                end
                firemodeText:set_visible(pdth_hud.Options.HUD.Fireselector)
            end
        end
    end
    
    function HUDTeammate:InitAmmoPanel(panel)
        local const = pdth_hud.constants
        local scale = pdth_hud.Options.HUD.Scale
    
        local firemode = panel:child("firemode")
        if not firemode then
            firemode = panel:text({
                name = "firemode",
                text = "AUTO",
                layer = 1,
                font = tweak_data.menu.small_font,
                font_size = const.main_firemode_font_size
            })
            managers.hud:make_fine_text(firemode)
            firemode:set_center_y(panel:h() / 2)
            firemode:set_right(panel:w())
        end
        
        local ammo = panel:child("ammo")
        if not ammo then
            ammo = panel:text({
                name = "ammo",
                text = "000/000",
                layer = 1,
                font = tweak_data.menu.small_font,
                font_size = const.main_ammo_font_size
            })
            managers.hud:make_fine_text(ammo)
            ammo:set_center_y(panel:h() / 2)
            ammo:set_right(firemode:left() - const.main_firemode_gap)
        end
        
        self:recreate_weapon_firemode()
    end
    
    local forbid_cat = {
        "saw",
        "minigun"
    }
    function HUDTeammate:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max)
        local const = pdth_hud.constants
        local scale = pdth_hud.Options.HUD.Scale
        local ammoAmount = self._main_player and pdth_hud.Options.HUD.spooky_ammo and current_left + current_clip or current_left
        
        self:set_special_equipment_amount(type .. "_weapon", ammoAmount)
        
        if self._main_player then
            local ammo_panel = type == "primary" and self._primary_weapon_ammo or self._secondary_weapon_ammo
            
            local weapon
            if type == "primary" then
                weapon = managers.blackmarket:equipped_primary()    
            else
                weapon = managers.blackmarket:equipped_secondary()
            end
            
            local category = tweak_data.weapon[managers.weapon_factory:get_weapon_id_by_factory_id(weapon.factory_id)].category

            local firemode = ammo_panel:child("firemode")
            local ammo = ammo_panel:child("ammo")
            
            local clip_string = (current_clip < 10 and "00" or current_clip < 100 and "0" or "") .. current_clip
            local left_string = (current_left < 10 and "00" or current_left < 100 and "0" or "") .. current_left
            
            ammo:set_text(clip_string .. "/" .. left_string)
            
            if current_left <= 0 then
                ammo:set_range_color(4, 7, Color.red)
            else
                ammo:set_range_color(4, 7, Color.white)
            end
            
            local r, g, b = 1, 1, 1
            if current_clip <= math.round(max_clip / 4) then
                g = current_clip / (max_clip / 2)
                b = current_clip / (max_clip / 2)
            end
            ammo:set_range_color(0, 3, Color(1, r, g, b))
            
            local icon, texture_rect = pdth_hud.textures:get_bullet_texture(category)
            
            if icon and not table.contains(forbid_cat, category) and not (max_clip > 200) then
                if self._set_max_clip[type] > max_clip then
                    for i = max_clip + 1, self._set_max_clip[type] do
                        local bullet = ammo_panel:child("bullet_" .. i)
                        if bullet then
                            ammo_panel:remove(bullet)
                        end
                    end
                end
                
                local h = ammo:h() * const.main_ammo_size_multiplier
                local w = (h / texture_rect[4]) * texture_rect[3]
                
                
                local r, g, b = 1, 1, 1
                if current_clip <= math.round(max_clip / 4) then
                    g = current_clip / (max_clip / 2)
                    b = current_clip / (max_clip / 2)
                end
                
                for i = 1, max_clip do
                    local bullet = ammo_panel:child("bullet_" .. i)
                    if not bullet then
                        bullet = ammo_panel:bitmap({
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
                    elseif self[type .. "_set_texture_rect"] ~= texture_rect then
                        bullet:set_image(icon, unpack(texture_rect))
                    end
                    
                    if i <= current_clip then
                        bullet:set_alpha(1)
                        bullet:set_color(Color(0.8, r, g, b))
                    elseif i >= current_clip then
                        bullet:set_alpha(0.5)
                        bullet:set_color(Color(0.2, r, g, b))
                    end
                end
                self[type .. "_set_texture_rect"] = texture_rect
                
                self._set_max_clip[type] = max_clip
            else
                for _, child in pairs(ammo_panel:children()) do
                    if string.begins(child:name(), "bullet_") then
                        ammo_panel:remove(child)
                    end
                end
            end
        end
    end

    function HUDTeammate:set_health(data) 
        local amount = data.current / data.total
        if amount < self.health_amount then
            self:_damage_taken()
        end
            
        local color = amount < 0.33 and Color(1, 0, 0) or Color(0.5, 0.8, 0.4)
        self.health_amount = amount
        self.health_colour = color
        
        self:RefreshPortraits()
    end

    function HUDTeammate:set_armor(data)
        local amount = data.current / data.total
        if amount < self.armor_amount then
            self:_damage_taken()
        end
        
        self.armor_amount = amount
        
        self:RefreshPortraits()
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
        if amount == 0 then
            radial_custom:hide()
        end
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
        self:set_special_equipment_amount("cable_ties_panel", amount)
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
                weapon = self._main_player,
                default = true
            })
            self._player_panel:child("grenades_panel"):set_visible(false)
        end
        
        if not self._player_panel:child("deployable_equipment_panel") then
            self:add_special_equipment({
                id = "deployable_equipment_panel",
                icon = "",
                amount = 2,
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
                no_flash = true,
                default = true
            })
            self._player_panel:child("cable_ties_panel"):set_visible(false)
        end
        
        self:teammate_progress(false, false, false, false)
        self:_set_weapon_selected(1)
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
    end

    function HUDTeammate:set_name(teammate_name)
        local const = pdth_hud.constants
        local teammate_panel = self._panel
        local name = teammate_panel:child("name")
        local radial_health_panel = self._player_panel:child("radial_health_panel")
        local carry_panel = self._player_panel:child("carry_panel")
        local character_icon = self._player_panel:child("character_icon")
        self._teammate_name = teammate_name
        name:set_text(utf8.to_upper(teammate_name))
        managers.hud:make_fine_text(name)
        if not self._main_player then
            name:set_left((pdth_hud.Options.HUD.OGTMHealth and character_icon:right() or radial_health_panel:right() ) + const.tm_name_gap)
            name:set_top(character_icon:top())
        end
        carry_panel:set_left(name:right())
        carry_panel:set_top(name:top())
    end

    function HUDTeammate:set_callsign(id)
    end

    function HUDTeammate:set_state(state)
        local const = pdth_hud.constants
        local teammate_panel = self._panel
        local is_player = state == "player"
        local radial_health_panel = self._panel:child("player"):child("radial_health_panel")
        local name = teammate_panel:child("name")
        local carry_panel = self._player_panel:child("carry_panel")
        local character_icon = self._player_panel:child("character_icon")
        if not self._main_player then
            local gradient = self._panel:child("gradient")
            managers.hud:make_fine_text(name)
            name:set_left((pdth_hud.Options.HUD.OGTMHealth and character_icon:right() or radial_health_panel:right() ) + const.tm_name_gap)
            name:set_top(character_icon:top())
            carry_panel:set_left(name:right())
            carry_panel:set_top(name:top())
            if is_player then
                for i, special in pairs(self._special_equipment) do
                    special.panel:set_visible(true)
                end
                radial_health_panel:set_visible(true)
            else
                for i, special in pairs(self._special_equipment) do
                    if special.default then
                        special.panel:set_visible(false)
                    else
                        self:remove_special_equipment(special.panel:name())
                    end
                end
                radial_health_panel:set_visible(not pdth_hud.Options.HUD.OGTMHealth)
                
                self.health_amount = 1
                self.armour_amount = 1
            end
            self:RefreshPortraits()
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
        --[[if not PlayerBase.USE_GRENADES then
            return
        end]]--
        local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
        self:set_grenades_amount(data)
        self:set_special_equipment_image("grenades_panel", icon, texture_rect)
    end

    function HUDTeammate:set_grenades_amount(data)
        --[[if not PlayerBase.USE_GRENADES then
            return
        end]]--
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
            teammate_height = self._player_panel:child("radial_health_panel"):h() - name:h() + (const.tm_equipment_inflation * pdth_hud.Options.HUD.Scale)
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
        
        if self._main_player and data.weapon then
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
                teammate_panel:remove(panel)
                table.remove(special_equipment, i)
                self:layout_special_equipments()
                break
            end
        end
        
        for i, weap in ipairs(self._weapons) do
            local panel = weap.panel
            if panel:name() == equipment then
                teammate_panel:remove(panel)
                table.remove(self._weapons, i)
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
            panel:set_w(panel:child("bitmap"):w() + (special.num_on_right and amw + const.num_on_right_inflation or 0))
            txtAmount:set_right(panel:w())
            if not special.default then
                txtAmount:set_visible(tonumber(amount) > 1)
            end
            if tonumber(amount) < 1 and not special.weapon then
                self:remove_special_equipment(equipment_id)
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
        
        for i, special in ipairs(self._weapons) do
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
        local character_icon = self._player_panel:child("character_icon")
        
        local main_player_right = teammate_panel:right() - (const.main_equipment_size / 2)
        
        local main_player_bottom = teammate_panel:bottom() - (const.main_equipment_size * const.main_equipment_y_offset_multiplier)
        
        local gap = const.equipment_gap 
        for i, special in ipairs(special_equipment) do
            local panel = special.panel
            if self._main_player and panel then
                panel:set_right(main_player_right)
                panel:set_bottom(self._special_equipment[i - 1] and self._special_equipment[i - 1].panel:top() or main_player_bottom)
            elseif panel then
                panel:set_left(special_equipment[i - 1] and special_equipment[i - 1].panel and (special_equipment[i - 1].panel:right() + gap) or (pdth_hud.Options.HUD.OGTMHealth and character_icon:right() or radial_health_panel:right()) + gap)
                panel:set_bottom(character_icon:bottom() + 2)
            end
        end
        
        if self._main_player then
            for i, weap in ipairs(self._weapons) do
                local panel = weap.panel
                panel:set_right((main_player_right - const.main_equipment_size) - (panel:w() * (#self._weapons - i))) -- Has issues when no equipment is present
                panel:set_top(main_player_bottom)
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
        local character_icon = self._player_panel:child("character_icon")
        if character_icon and pdth_hud.Options.HUD.OGTMHealth then
            character_icon:set_alpha(enabled and 0.2 or 1)
        else
            self._player_panel:child("radial_health_panel"):set_alpha(enabled and 0.2 or 1)
        end
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
                layer = 2,
                visible = false
            })
            bitmap:set_size(self._interact:size())
            bitmap:set_position(self._player_panel:child("interact_panel"):x(), self._player_panel:child("interact_panel"):y())
            local radius = self._interact:radius()
            local circle = CircleBitmapGuiObject:new(panel, {
                rotation = 360,
                radius = radius * pdth_hud.Options.HUD.Scale,
                color = Color.white:with_alpha(1),
                blend_mode = "normal",
                layer = 3
            })
            circle:set_position(bitmap:position())
            bitmap:animate(callback(HUDInteraction, HUDInteraction, "_animate_interaction_complete"), circle)
        end
    end

    function HUDTeammate:start_timer(time)
        local const = pdth_hud.constants
        self._timer_paused = 0
        self._timer = time
        self._panel:child("condition_timer"):set_color(Color.white)
        self._panel:child("condition_timer"):stop()
        self._panel:child("condition_timer"):set_visible(true)
        self._panel:child("condition_timer"):set_font_size(const.tm_condition_font_size) 
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
                if pdth_hud.Options.HUD.OGTMHealth then
                    self._panel:child("condition_timer"):set_center(self._player_panel:child("character_icon"):center())
                else
                    self._panel:child("condition_timer"):set_center(self._player_panel:child("radial_health_panel"):center())
                end
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
            if pdth_hud.Options.HUD.OGTMHealth then
                condition_timer:set_center(self._player_panel:child("character_icon"):center())
            else
                condition_timer:set_center(self._player_panel:child("radial_health_panel"):center())
            end
        end
        condition_timer:set_font_size(const.tm_condition_font_size) 
    end

    function HUDTeammate:set_carry_info(carry_id, value)
        local carry_panel = self._player_panel:child("carry_panel")
        carry_panel:set_visible(true)
        local value_text = carry_panel:child("value")
    end
    
    function HUDTeammate:RefreshPortraits()
        local const = pdth_hud.constants
        local radial_health_panel = self._player_panel:child("radial_health_panel")
        local radial_health = radial_health_panel:child("radial_health")
        local radial_bg = radial_health_panel:child("radial_bg")
        local radial_shield = radial_health_panel:child("radial_shield")
        local character_text = radial_health_panel:child("character_text")
        local character_icon = self._player_panel:child("character_icon")
        
        local character
        if self._main_player then
            character = managers.network:session():local_peer():character()
        elseif self._ai then
            character = managers.criminals:character_name_by_panel_id(self._id)
        else
            character = managers.criminals:character_name_by_peer_id(self._peer_id)
        end
        
        if self._main_player and character then
            local character_name = string.upper(managers.localization:text("menu_" .. character))
            character_text:set_text(character_name)
            managers.hud:make_fine_text(character_text)
            character_text:set_center_x(radial_health_panel:center_x())
            character_text:set_bottom(radial_health_panel:h() - const.main_character_y_offset)
        end
        
        if character then
            local height = self.health_h
        
            local texture, rect = pdth_hud.textures:get_portrait_texture(character, "health", self._main_player)
            local y_offset = rect[4] * (1 - self.health_amount)
            local h_offset = self.health_h * (1 - self.health_amount)
            radial_health:set_color(pdth_hud.Options.HUD.Coloured and self.health_colour or Color.white)
                
            radial_health:set_image(texture, rect[1], rect[2] + y_offset, rect[3], rect[4] - y_offset)
            radial_health:set_h(height - h_offset)
            radial_health:set_bottom(radial_bg:bottom())
            
            local texture, rect = pdth_hud.textures:get_portrait_texture(character, "armor", self._main_player)
            local y_offset = rect[4] * (1 - self.armor_amount)
            local h_offset = self.health_h * (1 - self.armor_amount)
            radial_shield:set_image(texture, rect[1], rect[2] + y_offset, rect[3], rect[4] - y_offset)
            radial_shield:set_h(height - h_offset)
            radial_shield:set_bottom(radial_bg:bottom())
            
            local texture, rect = pdth_hud.textures:get_portrait_texture(character, "bg", self._main_player)
            radial_bg:set_image(texture, unpack(rect))
        end
        
        if not self._ai or not pdth_hud.Options.HUD.OGTMHealth then
            radial_health_panel:set_visible(true)
        end
        
        radial_bg:set_visible(not self._ai)
        radial_shield:set_visible(not self._ai)
        radial_health:set_blend_mode(self._ai and "normal" or "add")
        if self._ai then
            radial_health:set_color(Color.white)
        end
        
        if character and not self._main_player and pdth_hud.Options.HUD.OGTMHealth then
            local texture, rect = pdth_hud.textures:get_portrait_texture(character, "tm")
            if texture ~= character_icon:texture_name() then
                character_icon:set_image(texture, unpack(rect))
            end
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
end