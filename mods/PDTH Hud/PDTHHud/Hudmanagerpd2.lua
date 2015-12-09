if pdth_hud.loaded_options.Ingame.MainHud then
function HUDManager:_create_teammates_panel( hud )
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud.teammate_panels_data = self._hud.teammate_panels_data or {}
	self._teammate_panels = {}
	if hud.panel:child( "teammates_panel" ) then	
		hud.panel:remove( hud.panel:child( "teammates_panel" ) )
	end
	local h = 120
	local teammates_panel = hud.panel:panel({ 
		name = "teammates_panel", 
		h = ((129 * pdth_hud.loaded_options.Ingame.Hud_scale) / 3) - 2, 
		y = hud.panel:h() - h,
		--w = hud.panel:w()
		--halign = "grow", 
		--valign = "bottom" 
	})
	local teammate_w = 204 	-- This is what each teammate panel width should be right now
	local player_gap = 240	-- Extra gap to player panel
	local small_gap = (teammates_panel:w() - player_gap - teammate_w * 4)/3
	local teammate_1
	local teammate_2
	local teammate_3
	for i = 1, 4 do
		local is_player = i == HUDManager.PLAYER_PANEL
		self._hud.teammate_panels_data[ i ] = { taken = false and is_player, special_equipments = {} }
		local pw = teammate_w  + ( is_player and 0 or 64 )-- (is_player and 0 or 32)
		if i == 4 then
			teammates_panel:set_h(hud.panel:h())
			teammates_panel:set_y(0)
		end
		local teammate = HUDTeammate:new( i, teammates_panel, is_player, pw )
		
		local x = math.floor((pw + small_gap) * (i-1) + (i == HUDManager.PLAYER_PANEL and player_gap or 0))
		local xmod = math.floor((pw + small_gap) * (1-1) + (i == HUDManager.PLAYER_PANEL and player_gap or 0) + 43)
		
		if i == 1 then
			teammate._panel:set_x(math.floor(xmod) * pdth_hud.loaded_options.Ingame.Hud_scale)
			--teammate._panel:set_y(hud.panel:h() - 115 + (3 * pdth_hud.loaded_options.Ingame.Hud_scale))
			teammate._panel:set_bottom(hud.panel:bottom())
			--teammate._panel:set_w(hud.panel:w())
			teammate_1 = teammate._panel
		else
			if i == 2 then
				teammate._panel:set_x(math.floor(xmod) * pdth_hud.loaded_options.Ingame.Hud_scale)
				--teammate._panel:set_y(hud.panel:h() - 115 - (41.5 * pdth_hud.loaded_options.Ingame.Hud_scale))
				--teammate._panel:set_bottom(teammate_1:top() + 3)
				--teammate._panel:set_top(hud.panel:h() - (((129 * pdth_hud.loaded_options.Ingame.Hud_scale) / 3) * 2))
				teammate._panel:set_center_y(hud.panel:h() - ((129 * pdth_hud.loaded_options.Ingame.Hud_scale) / 2))
				--teammate._panel:set_w(hud.panel:w())
				teammate_2 = teammate._panel
			else
				if i == 3 then
					teammate._panel:set_x(math.floor(xmod) * pdth_hud.loaded_options.Ingame.Hud_scale)
					--teammate._panel:set_y(hud.panel:h() - 115 - (86 * pdth_hud.loaded_options.Ingame.Hud_scale))
					teammate._panel:set_top(hud.panel:h() - (129 * pdth_hud.loaded_options.Ingame.Hud_scale))
					--teammate._panel:set_w(hud.panel:w())
					teammate_3 = teammate._panel
				else
					if i == 4 then
						teammate._panel:set_x(0)
						--teammate._panel:set_w(hud.panel:w())
					end
				end
			end
		end	
		table.insert( self._teammate_panels, teammate )
		
		if is_player then
			teammate:add_panel()
		end
	end
end
end

function HUDManager:set_teammate_ammo_amount(id, selection_index, max_clip, current_clip, current_left, max)
	local type = selection_index == 1 and "secondary" or "primary"
	local send_real = false
	local weapon, category, factoryid, weaponid
	if type == "primary" then
		weapon = managers.blackmarket:equipped_primary()
		factoryid = weapon.factory_id
		weaponid = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factoryid)
		category = tweak_data.weapon[weaponid].category
	else
		weapon = managers.blackmarket:equipped_secondary()
		factoryid = weapon.factory_id
		weaponid = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factoryid)
		category = tweak_data.weapon[weaponid].category
	end
	
	if id == 4 and pdth_hud.loaded_options.Ingame.spooky_ammo then
		if category == "saw" then
			send_real = false
		else
			send_real = true
		end
	end
	local left_ammo_value = (current_left - max_clip) + (max_clip - current_clip)
	self._teammate_panels[id]:set_ammo_amount_by_type(type, max_clip, current_clip, send_real and left_ammo_value or current_left, max)
end

local custom_radial = HUDManager.set_teammate_custom_radial
function HUDManager:set_teammate_custom_radial(i, data)
	local hud = managers.hud:script( PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	if pdth_hud.loaded_options.Ingame.Swansong then
		if not hud.panel:child("swan_song_left") then
			local swan_song_left = hud.panel:bitmap({
				name = "swan_song_left",
				visible = false,
				texture = "guis/textures/alphawipe_test",
				layer = 0,
				color = Color(0, 0.7, 1),
				blend_mode = "add",
				w = hud.panel:w(),
				h = hud.panel:h(),
				x = 0,
				y = 0 
			})
		end
		local swan_song_left = hud.panel:child("swan_song_left")
		if i == 4 and data.current < data.total and data.current > 0 and swan_song_left then
			swan_song_left:set_visible(true)
			local hudinfo = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
			swan_song_left:animate(hudinfo.flash_icon, 4000000000)
		elseif hud.panel:child("swan_song_left") then
			swan_song_left:stop()
			swan_song_left:set_visible(false)
		end
		if swan_song_left and data.current == 0 then
			swan_song_left:set_visible(false)
		end
	else
		if hud.panel:child("swan_song_left") then
			local swan_song_left = hud.panel:child("swan_song_left")
			swan_song_left:stop()
			swan_song_left:set_visible(false)
		end
	end
	return custom_radial(self, i, data)
end