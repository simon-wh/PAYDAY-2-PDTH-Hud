pdth_hud.textures = {}

pdth_hud.textures.portraits = {}

pdth_hud.textures.portraits["fallback"] = {}
pdth_hud.textures.portraits["fallback"].bg = {
	texture = "guis/textures/pd2/masks",
	texture_rect = {
		0,
        780,
        192,
        390
	}
}

pdth_hud.textures.portraits["fallback"].health = {
	texture = "guis/textures/pd2/masks",
	texture_rect = {
		0,
        0,
        192,
        390
	}
}

pdth_hud.textures.portraits["fallback"].armor = {
	texture = "guis/textures/pd2/masks",
	texture_rect = {
		0,
        390,
        192,
        390
	}
}

pdth_hud.textures.portraits["fallback"].tm = {
	texture = "guis/textures/pd2/masks",
	texture_rect = {
		0,
        1170,
        192,
        192
	}
}

pdth_hud.textures.portraits.teammate = {}

pdth_hud.textures.portraits.teammate.health = {
    texture = "guis/textures/hud_icons",
	texture_rect = {
		264,
		240,
		12,
		48
	}
}

pdth_hud.textures.portraits.teammate.armor = {
    texture = "guis/textures/hud_icons",
	texture_rect = {
		252,
		240,
		12,
		48
	}
}

pdth_hud.textures.portraits.teammate.bg = {
    texture = "guis/textures/hud_icons",
	texture_rect = {
		240,
		240,
		12,
		48
	}
}

pdth_hud.textures.bullets = {
	textures = {
		[2] = "guis/textures/ammocounter",
		[3] = "guis/textures/pd2/weapons"
	},
	pistol_9mm = {
		texture_rect = {
			52,
			5,
			55,
			150
		}
	},
	pistol_45 = {
		texture_rect = {
			212,
			5,
			55,
			150
		}
	},
	pistol_40 = {
		texture_rect = {
			372,
			5,
			55,
			150
		}
	},
	shotgun_shell = {
		texture_rect = {
			529,
			5,
			61,
			150
		}
	},
	rifle_556 = {
		texture_rect = {
			703,
			5,
			34,
			150
		}
	},
	rifle_762 = {
		texture_rect = {
			65,
			165,
			29,
			151
		}
	},
	snp_44 = {
		texture_rect = {
			215,
			165,
			47,
			150
		}
	},
	snp_50 = {
		texture_rect = {
			385,
			165,
			29,
			150
		}
	},
	grenade = {
		texture_rect = {
			532,
			165,
			56,
			150
		}
	},
	rpg = {
		texture_rect = {
			702,
			165,
			37,
			150
		},
		rotation = 270
	},
	arrow = {
		texture_rect = {
			65,
			325,
			30,
			150
		},
		rotation = 270
	},
	crossbow_bolt = {
		texture_rect = {
			233,
			325,
			15,
			150
		},
		rotation = 270
	},
	saw_blade = {
		texture_rect = {
			325,
			325,
			150,
			150
		},
		spin_on_change = true,
		single = true
	},
	fuel_tank = {
		texture_rect = {
			525,
			325,
			68,
			150
		},
		rotation = 270,
		single = true
	}
}

pdth_hud.textures.weapons = {}

function pdth_hud.textures:get_icon_data(icon_id)
	local icon = pdth_hud.textures[icon_id] and pdth_hud.textures[icon_id].texture or icon_id
	local texture_rect = pdth_hud.textures[icon_id] and pdth_hud.textures[icon_id].texture_rect or {
		384,
		260,
		64,
		130
	}
	return icon, texture_rect
end

function pdth_hud.textures:get_bullet_details(weapon_id, category)
    local option = pdth_hud.Options:GetValue("HUD/Bullet")

    local texture = self.bullets.textures[option]
	local details

    if tweak_data.weapon[weapon_id].ammo then
		details = self.bullets[tweak_data.weapon[weapon_id].ammo]
	elseif pdth_hud.definitions.ammo[category] then
		details = self.bullets[pdth_hud.definitions.ammo[category]]
	end

    return texture, details
end

function pdth_hud.textures:apply_tweak_data_icons()
	local icons = tweak_data.hud_icons
	icons.equipment_body_bag = pdth_hud.textures:get_weapon_texture("equipment_body_bag", nil, true)
    icons.equipment_ammo_bag = pdth_hud.textures:get_weapon_texture("equipment_ammo_bag", nil, true)
    icons.equipment_doctor_bag = pdth_hud.textures:get_weapon_texture("equipment_doctor_bag", nil, true)
    icons.equipment_sentry = pdth_hud.textures:get_weapon_texture("equipment_sentry", nil, true)
    icons.equipment_trip_mine = pdth_hud.textures:get_weapon_texture("equipment_trip_mine", nil, true)
    icons.equipment_ecm_jammer = pdth_hud.textures:get_weapon_texture("equipment_ecm_jammer", nil, true)
    icons.equipment_armor_kit = pdth_hud.textures:get_weapon_texture("equipment_armor_kit", nil, true)
    icons.equipment_first_aid_kit = pdth_hud.textures:get_weapon_texture("equipment_first_aid_kit", nil, true)
    icons.equipment_bodybags_bag = pdth_hud.textures:get_weapon_texture("equipment_body_bag", nil, true)

    icons.frag_grenade = pdth_hud.textures:get_weapon_texture("frag_grenade", nil, true)
    icons.molotov_grenade = pdth_hud.textures:get_weapon_texture("molotov_grenade", nil, true)
    icons.dynamite_grenade = pdth_hud.textures:get_weapon_texture("dynamite_grenade", nil, true)
    icons.four_projectile = pdth_hud.textures:get_weapon_texture("four_projectile", nil, true)
    icons.ace_projectile = pdth_hud.textures:get_weapon_texture("ace_projectile", nil, true)
    icons.jav_projectile = pdth_hud.textures:get_weapon_texture("jav_projectile", nil, true)
end

function pdth_hud.textures:get_weapon_texture(weapon_id, category, ret_tbl)
	local def = pdth_hud.definitions.weapon_texture
	local texture = def.textures[pdth_hud.Options:GetValue("HUD/WeaponIcon")]
	local rectangle = {0,0,0,0}

	if self.weapons[weapon_id] then
		rectangle = self.weapons[weapon_id]
	else
		local weap_index = table.index_of(pdth_hud.definitions.weapon_texture.weapon_order, weapon_id)
		if weap_index == -1 and pdth_hud.definitions.weapon_texture.category_conversion[category] then
			weap_index = table.index_of(pdth_hud.definitions.weapon_texture.weapon_order, pdth_hud.definitions.weapon_texture.category_conversion[category])
		end
		if weap_index == -1 then
			if ret_tbl then
				return {texture = texture, texture_rect = rectangle}
			else
				return texture, rectangle
			end
		end

		local row = math.floor((weap_index-1) / (def.texture_size.w / def.icon_size.w))
		local column = (weap_index-1) % (def.texture_size.w / def.icon_size.w)
		row = math.floor(row)
		rectangle = {
			column * def.icon_size.w,
			row * def.icon_size.h,
			def.icon_size.w,
			def.icon_size.h
		}
		self.weapons[weapon_id] = rectangle
	end

	if ret_tbl then
		return {texture = texture, texture_rect = rectangle}
	else
		return texture, rectangle
	end
end

pdth_hud.textures._portrait_order = {}

function pdth_hud.textures:refresh_portrait_order()
	self._portrait_order = clone(pdth_hud.portrait_options)

	table.sort(self._portrait_order, function(a, b)
        return pdth_hud.Options:GetValue("HUD/portraits/" .. a) < pdth_hud.Options:GetValue("HUD/portraits/" .. b)
    end)
end

function pdth_hud.textures:get_portrait_texture(character, section, main_player)
    if not main_player and section ~= "tm" and pdth_hud.Options:GetValue("HUD/OGTMHealth") then
        local icon = self.portraits.teammate[section].texture
        local texture_rect = self.portraits.teammate[section].texture_rect
        return icon, texture_rect
    end

	local order = self._portrait_order

	local portrait_id = "default"
	for i, portrait in pairs(order) do
		if portrait and self.portraits[portrait] and self.portraits[portrait][character] then
			portrait_id = portrait
			break
		end
	end

	local icon = self.portraits[portrait_id][character] and self.portraits[portrait_id][character][section] and self.portraits[portrait_id][character][section].texture or self.portraits["default"][character] and self.portraits["default"][character][section] and self.portraits["default"][character][section].texture or self.portraits["fallback"][section].texture or nil
	local texture_rect = self.portraits[portrait_id][character] and self.portraits[portrait_id][character][section] and self.portraits[portrait_id][character][section].texture_rect or self.portraits["default"][character] and self.portraits["default"][character][section] and self.portraits["default"][character][section].texture_rect or self.portraits["fallback"][section].texture_rect or nil

	return icon, texture_rect
end

local portrait_parts = { "health", "armor", "bg", "tm" }
function pdth_hud.textures:ProcessAddon(data, portrait_tbl)
    if data.portraits then
        for _, portait_set in pairs(data.portraits) do
            local name = portait_set.name
            local display_name = portait_set.display_name
            local main_texture = portait_set.main_texture
            if display_name then
				table.insert(portrait_tbl, name)
                Hooks:Add("LocalizationManagerPostInit", "PDTHHudPortrait" .. name, function(loc)
                    LocalizationManager:add_localized_strings({
                        [name .. "_title_id"] = display_name
                    })
                end)
            end
            self.portraits[name] = {}
			if portait_set.portraits then
	            for _, portrait in pairs(portait_set.portraits) do
	                local character_id = portrait.character_id
	                self.portraits[name][character_id] = {}
	                for ptype, rect in pairs(portrait.texture_rects) do
	                    self.portraits[name][character_id][ptype] = {
	                        texture = portait_set.texture or main_texture,
	                        texture_rect = rect
	                    }
	                end
	            end
			elseif portait_set.portraits_info then
				local info = portait_set.portraits_info
				local w = info.w
				local h = info.h
				local current_x = 0

				for _, character in pairs(info.included_characters) do
					self.portraits[name][character] = self.portraits[name][character] or {}
					local current_y = 0
					for _, part in pairs(portrait_parts) do
						self.portraits[name][character][part] = {
							texture = main_texture,
							texture_rect = {
								current_x,
								current_y,
								w,
								part == "tm" and w or h
							}
						}
						current_y = current_y + h
					end
					current_x = current_x + w
				end
			end
        end
    end
end

--pdth_hud:LoadAddons()
