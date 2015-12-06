CloneClass(StatisticsManager)

function StatisticsManager.stop_session(self, data)
	self.orig.stop_session(self, data)
	local success = data and data.success
	managers.challenges:session_stopped({success = success, from_beginning = self._start_session_from_beginning, drop_in = self._start_session_drop_in, last_session = self._global.last_session})
	managers.challenges:reset("session")
	managers.challenges:reset_counter("juan_deag")
end

Hooks:RegisterHook("StatisticsManagerKilledByAnyone")
function StatisticsManager.killed_by_anyone(self, data)
	self.orig.killed_by_anyone(self, data)
	--[[local by_explosion = data.variant == "explosion"
	local name_id = data.weapon_unit and data.weapon_unit:base() and data.weapon_unit:base():get_name_id()
	if by_explosion and data.name == "patrol" and name_id ~= "m79" then
		self._patrol_bombed = self._patrol_bombed and self._patrol_bombed + 1 or 1
		if self._patrol_bombed >= 12 and Global.level_data.level_id == "diamond_heist" then
			managers.challenges:set_flag( "bomb_man" )
		end
	end]]--
	Hooks:Call("StatisticsManagerKilledByAnyone", self, data)
end

function StatisticsManager.killed(self, data)
	self.orig.killed(self, data)
	local success, err = pcall(function()
		local by_bullet = data.variant == "bullet"
		local by_melee = data.variant == "melee"
		local by_explosion = data.variant == "explosion"
		if by_bullet then
			local name_id = data.weapon_unit:base():get_name_id()
			self:_bullet_challenges( data )
			if name_id == "sentry_gun" then
				managers.challenges:count_up( "sentry_gun_law_row_kills" )
				
				if game_state_machine:last_queued_state_name() == "ingame_waiting_for_respawn" then
					managers.challenges:count_up( "grim_reaper" )
				end
			else
				managers.challenges:reset_counter( "sentry_gun_law_row_kills" )
			end
			if data.name == "tank" then
				if (name_id == "r870_shotgun" or name_id == "mossberg") then
					managers.challenges:set_flag( "cheney" )
				end
			end
			if name_id == "new_m14" then
				if self._m14_kills == self._m14_shots then
					if self._m14_kills == 29 then
						managers.challenges:set_flag( "one_shot_one_kill" )
					end
				else
					self._m14_kills = 0
					self._m14_shots = 0
				end
			
				self._m14_kills = self._m14_kills and self._m14_kills + 1 or 1
			end
			
		elseif by_melee then
			self:_melee_challenges(data)
			managers.challenges:reset_counter( "sentry_gun_law_row_kills" )
		elseif by_explosion then
			local name_id
			if data.weapon_unit then
				if data.weapon_unit:base() and data.weapon_unit:base().grenade_entry then
					name_id = tweak_data.blackmarket.grenades[data.weapon_unit:base():grenade_entry()].weapon_id
				else
					name_id = data.weapon_unit and data.weapon_unit:base().get_name_id and data.weapon_unit:base():get_name_id()
				end
			end
			if name_id == "gre_m79" or name_id == "rpg7" or name_id == "m32" then
				self:_bullet_challenges( data )
			end
			self:_explosion_challenges( data )
			managers.challenges:reset_counter( "sentry_gun_law_row_kills" )
		end
		if self:session_total_law_enforcer_kills() >= 100 then
			managers.challenges:set_flag( "civil_disobedience" )
		end
		if data.name == "fbi" then
			self._fbi_kills = self._fbi_kills and self._fbi_kills + 1 or 1
			
			if self._fbi_kills >= 25 then
				managers.challenges:set_flag( "federal_crime" )
			end
		else
			self._fbi_kills = 0
		end
	end)
	if not success then
		log("[Error] L92 " .. tostring(err))
	end
end

function StatisticsManager:_bullet_challenges( data )
	local success, err = pcall(function()
		managers.challenges:count_up( data.type.."_kill" )
		managers.challenges:count_up( data.name.."_kill" )
		if data.head_shot then
			managers.challenges:count_up( data.type.."_head_shot" )
		else
			managers.challenges:count_up( data.type.."_body_shot" )
		end
		if data.attacker_state then
			if data.attacker_state == "bleed_out" then
				local weapon_name_id = data.weapon_unit:base():get_name_id()
				if weapon_name_id ~= "sentry_gun" then
					managers.challenges:count_up( "bleed_out_kill" )
					managers.challenges:count_up( "bleed_out_multikill" ) -- During one bleed out session
				end
			end
		end
		local name_id
		if data.weapon_unit then
			if data.weapon_unit:base() and data.weapon_unit:base().grenade_entry then
				name_id = tweak_data.blackmarket.grenades[data.weapon_unit:base():grenade_entry()].weapon_id
			else
				name_id = data.weapon_unit and data.weapon_unit:base().get_name_id and data.weapon_unit:base():get_name_id()
			end
		end
		
		local weapon_tweak_data
		if data.weapon_unit:base().weapon_tweak_data and data.weapon_unit:base():weapon_tweak_data() then
			weapon_tweak_data = data.weapon_unit:base():weapon_tweak_data()
		elseif name_id == "gre_m79" then
			weapon_tweak_data = tweak_data.weapon.gre_m79
		elseif name_id == "rpg7" then
			weapon_tweak_data = tweak_data.weapon.rpg7
		elseif name_id == "m32" then
			weapon_tweak_data = tweak_data.weapon.m32
		end
		if weapon_tweak_data and weapon_tweak_data.category then
			managers.challenges:count_up( weapon_tweak_data.category .."_"..data.name.."_kill" )
			managers.challenges:count_up( weapon_tweak_data.category .."_"..data.type.."_kill" )
			if data.head_shot then
				managers.challenges:count_up( weapon_tweak_data.category .."_"..data.type.."_head_shot" )
				managers.challenges:count_up( weapon_tweak_data.category .."_"..data.name.."_head_shot" )
			else
				managers.challenges:count_up( weapon_tweak_data.category .."_"..data.type.."_body_shot" )
				managers.challenges:count_up( weapon_tweak_data.category .."_"..data.name.."_body_shot" )
			end	
		end
		if weapon_tweak_data and weapon_tweak_data.challenges then
			if weapon_tweak_data.challenges.weapon then
				if weapon_tweak_data.challenges.weapon == "deagle" and data.type == "law" then
					managers.challenges:count_up("juan_deag")
				end
				managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.type.."_kill" )
				managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.name.."_kill" )
			end
			if data.head_shot then
				if weapon_tweak_data.challenges.weapon then
					managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.type.."_head_shot" )
					managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.name.."_head_shot" )
				end
			else
				if weapon_tweak_data.challenges.weapon then
					managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.type.."_body_shot" )
					managers.challenges:count_up( weapon_tweak_data.challenges.weapon.."_"..data.name.."_body_shot" )
				end
			end	
		end
	end)
	if not success then
		log("[Error] L162 " .. tostring(err))
	end
end

function StatisticsManager:_melee_challenges( data )
	if data.type == "law" then
		managers.challenges:count_up( "melee_law_kill" )
	end
end


function StatisticsManager:_explosion_challenges(data)
	local success, err = pcall(function()
		if game_state_machine:last_queued_state_name() == "ingame_waiting_for_respawn" then
			managers.challenges:count_up("grim_reaper")
		end
		local weapon_id = data.weapon_unit and data.weapon_unit:base().get_name_id and data.weapon_unit:base():get_name_id()
		if weapon_id == "gre_m79" then
			managers.challenges:count_up("m79_law_simultaneous_kills")
			if data.name == "shield" or data.name == "spooc" or data.name == "tank" or data.name == "taser" then
				managers.challenges:count_up("m79_simultaneous_specials")
			end
		elseif weapon_id == "trip_mine" then
			if data.type == "law" then
				managers.challenges:count_up("trip_mine_law_kill")
			end
		end
	end)
	if not success then
		log("[Error] L191 " .. tostring(err))
	end
end

function StatisticsManager.tied(self, data)
	self.orig.tied(self, data)
	if data.name == "heavy_swat" then
		managers.challenges:set_flag( "intimidating" )
	end
	local type = tweak_data.character[ data.name ] and tweak_data.character[ data.name ].challenges.type
	if type then
		managers.challenges:count_up( "tiedown_"..type )
	end
	managers.challenges:count_up( "tiedown_"..data.name )
end

function StatisticsManager.revived(self, data)
	self.orig.revived(self, data)
	managers.challenges:count_up( "revive" )
end

function StatisticsManager.downed(self, data)
	self.orig.downed(self, data)
	if data.bleed_out then
		managers.challenges:reset( "bleed_out" )
	end
end

function StatisticsManager:session_total_law_enforcer_kills()
	return self._global.session.killed.total.count - self._global.session.killed.civilian.count - self._global.session.killed.civilian_female.count - self._global.session.killed.gangster.count - self._global.session.killed.other.count
end

function StatisticsManager.use_trip_mine(self)
	self.orig.use_trip_mine(self)
	managers.challenges:count_up("plant_tripmine")
end

function StatisticsManager.use_ammo_bag(self)
	self.orig.use_ammo_bag(self)
	managers.challenges:count_up("deploy_ammobag")
end

function StatisticsManager.use_doctor_bag(self)
	self.orig.use_doctor_bag(self)
	managers.challenges:count_up("deploy_medicbag")
end

function StatisticsManager.use_ecm_jammer(self)
	self.orig.use_ecm_jammer(self)
	managers.challenges:count_up("deploy_ecm")
end

function StatisticsManager.use_sentry_gun(self)
	self.orig.use_sentry_gun(self)
	managers.challenges:count_up("deploy_sentry")
end

function StatisticsManager.use_first_aid(self)
	self.orig.use_first_aid(self)
	managers.challenges:count_up("deploy_fak")
end