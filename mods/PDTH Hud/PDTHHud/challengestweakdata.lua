ChallengesTweakData = ChallengesTweakData or class()

local tiny_xp = 800
local small_xp = 1000
local mid_xp = 1400
local large_xp = 2400
local huge_xp = 3600
local gigantic_xp = 5000

local ten_steps = { "size08", "size10", "size12", "size12", "size14", "size16", "size18", "size20", "size20", "size20" }
local five_steps = { "size12", "size14", "size16", "size18", "size20" }

function ChallengesTweakData:init()
	--self.categories	= {}
	self.character = {}
	--[[self.character.bullet_to_bleed_out = {
		title_id = "ch_bullet_to_bleed_out_hl",
		description_id = "ch_bullet_to_bleed_out",
		flag_id = "bullet_to_bleed_out",
		unlock_level = 0,
		xp = tiny_xp,
		in_trial = true
	}
	self.character.fall_to_bleed_out = {
		title_id = "ch_fall_to_bleed_out_hl",
		description_id = "ch_fall_to_bleed_out",
		flag_id = "fall_to_bleed_out",
		unlock_level = 0,
		xp = tiny_xp
		--value = 600,
		--compare = ""
	}
	self.character.revived = {			
		title_id = "ch_revived_hl",
		description_id = "ch_revived_single",
		counter_id = "revived",
		unlock_level = 0,
		count = 1,
		xp = tiny_xp,
		in_trial = true
	}
	self.character.arrested = {			
		title_id = "ch_arrested_hl",
		description_id = "ch_arrested_single",
		counter_id = "arrested",
		unlock_level = 0,
		count = 1,
		xp = tiny_xp,
		in_trial = true
	}]]--
	self.character.deploy_ammobag = {
		title_id = "ch_deploy_ammobag_hl",
		description_id = "ch_deploy_ammobag",
		counter_id = "deploy_ammobag",
		unlock_level = 0,
		count = 100,
		--No visible counter?
		xp = mid_xp,
		--depends_on = { equipment = { "ammo_bag" } }
	}
	self.character.deploy_medicbag = {
		title_id = "ch_deploy_medicbag_hl",
		description_id = "ch_deploy_medicbag",
		counter_id = "deploy_medicbag",
		unlock_level = 0,
		count = 100,
		--No visible counter?
		xp = mid_xp,
		--depends_on = { equipment = { "medic_bag" } }
	}
	self.character.deploy_ecm = {
		title_id = "ch_deploy_ecm_hl",
		description_id = "ch_deploy_ecm",
		counter_id = "deploy_ecm",
		unlock_level = 0,
		count = 100,
		--No visible counter?
		xp = mid_xp,
		--depends_on = { equipment = { "ecm_bag" } }
	}
	self.character.deploy_fak = {
		title_id = "ch_deploy_fak_hl",
		description_id = "ch_deploy_fak",
		counter_id = "deploy_fak",
		unlock_level = 0,
		count = 100,
		--No visible counter?
		xp = mid_xp,
		--depends_on = { equipment = { "fak_bag" } }
	}
	self.character.deploy_sentry = {
		title_id = "ch_deploy_sentry_hl",
		description_id = "ch_deploy_sentry",
		counter_id = "deploy_sentry",
		unlock_level = 0,
		count = 100,
		--No visible counter?
		xp = mid_xp,
		--depends_on = { equipment = { "sentry_bag" } }
	}
	
	--[[self.character.tiedown_civilian = {			
		title_id = "ch_tiedown_civilian_hl",
		description_id = "ch_tiedown_civilian",
		counter_id = "tiedown_civilians",
		unlock_level = 0,
		count = 15,
		xp = tiny_xp,
		--depends_on = { challenges = { "revive" } }
	}
	self.character.tiedown_law = {			
		title_id = "ch_tiedown_law_hl",
		description_id = "ch_tiedown_law",
		counter_id = "tiedown_law",
		unlock_level = 0,
		count = 15,
		xp = small_xp,
		depends_on = { challenges = { "tiedown_civilian" } }
	}
	self.character.tiedown_cop = {			
		title_id = "ch_tiedown_cop_hl",
		description_id = "ch_tiedown_cop",
		counter_id = "tiedown_cop",
		unlock_level = 0,
		count = 15,
		xp = mid_xp,
		depends_on = { challenges = { "tiedown_law" } }
	}
	self.character.tiedown_fbi = {			
		title_id = "ch_tiedown_fbi_hl",
		description_id = "ch_tiedown_fbi",
		counter_id = "tiedown_fbi",
		unlock_level = 0,
		count = 15,
		xp = huge_xp,
		depends_on = { challenges = { "tiedown_cop" } }
	}
	self.character.tiedown_swat = {			
		title_id = "ch_tiedown_swat_hl",
		description_id = "ch_tiedown_swat",
		counter_id = "tiedown_swat",
		unlock_level = 0,
		count = 15,
		xp = large_xp,
		depends_on = { challenges = { "tiedown_fbi" } }
	}]]--
	--[[self.character.tiedown_smep = {			
		title_id = "ch_tiedown_smep_hl",
		description_id = "ch_tiedown_smep",
		counter_id = "tiedown_smep",
		unlock_level = 0,
		count = 15,
		xp = small_xp,
		depends_on = { challenges = { "tiedown_swat" } }
	}]]
										
	self.achievment = {}

	self.weapon = {}
	
	self:_any_weapon_challenges()
	--self:_c45_challenges()
	--self:_beretta92_challenges()
	--self:_bronco_challenges()
	--self:_reinbeck_challenges()
	--self:_mossberg_challenges()
	--self:_mp5_challenges()
	--self:_mac11_challenges()
	--self:_m4_challenges()
	self:_m14_challenges()
	--self:_hk21_challenges()
	
	self:_glock_challenges()	
	self:_ak47_challenges()
	self:_m79_challenges()
		
	self:_sentry_gun_challenges()

	self:_melee_challenges()
	--self:_bleed_out_challenges()
	self:_rpg7_challenges()
	self:_flamethrower_challenges()
	self:_minigun_challenges()
	self:_trip_mine_challenges()
	self:_shotgun_challenges()
	self:_assault_rifle_challenges()
	self:_snp_challenges()
	self:_lmg_challenges()
	self:_akimbo_challenges()
	--self:_saw_challenges()
	self:_smg_challenges()
	self:_pistol_challenges()
	
	--[[self.weapon.juan_deag = {
		title_id = "ch_juan_deag_title",
		description_id = "ch_juan_deag_desc",
		counter_id = "juan_deag",
		unlock_level = 0, --needs deagle level
		count = 14, 
		xp = tiny_xp,
		--depends_on = depends_on,
		--in_trial = definition.me.vs_the_law[ i ].in_trial
	}]]--

	--Revive challenges
	--[[self.character.revive = {			
		title_id = "ch_revive_hl",
		description_id = "ch_revive_single",
		counter_id = "revive",
		unlock_level = 0,
		count = 1,
		xp = small_xp,
	}]]--
	--[[self.character.revive_1 = {			
		title_id = "ch_revive_1_hl",
		description_id = "ch_revive",
		counter_id = "revive",
		unlock_level = 0,
		count = 5,
		xp = tiny_xp,
		--depends_on = { challenges = { "revive" } }
		in_trial = true
	}
	self.character.revive_2 = {			
		title_id = "ch_revive_2_hl",
		description_id = "ch_revive",
		counter_id = "revive",
		unlock_level = 0,
		count = 30,
		xp = small_xp,
		depends_on = { challenges = { "revive_1" } }
	}
	self.character.revive_3 = {			
		title_id = "ch_revive_3_hl",
		description_id = "ch_revive",
		counter_id = "revive",
		unlock_level = 0,
		count = 60,
		xp = mid_xp,
		depends_on = { challenges = { "revive_2" } }
	}
	self.character.revive_4 = {			
		title_id = "ch_revive_4_hl",
		description_id = "ch_revive",
		counter_id = "revive",
		unlock_level = 0,
		count = 120,
		xp = large_xp,
		depends_on = { challenges = { "revive_3" } }
	}]]--
	
	--Session challenges
	self.session = {}
	
	--self:_money_challenges()

	--[[self.session.never_downed = {			
		title_id = "ch_never_downed_hl",
		description_id = "ch_never_downed",
		-- counter_id = "something",
		unlock_level = 0,
		session_stopped = { callback = "never_downed" },
		xp = huge_xp,
		-- depends_on = { challenges = { "revive_3" } }
	}]]--
	
	--[[self.session.bank_no_civilians_hard = {			
		title_id = "ch_bank_no_civilians_hl",
		description_id = "ch_bank_no_civilians",
		unlock_level = 0, 
		xp = mid_xp,
		level_id = "big",
		difficulty = { "overkill", "overkill_145", "overkill_290" },
		session_stopped = { callback = "no_civilians_killed" },
	}
	self.session.bank_no_kills = {			
		title_id = "ch_bank_no_kills_hl",
		description_id = "ch_bank_no_kills",
		unlock_level = 0,
		xp = mid_xp,
		level_id = "big",
		difficulty = {"easy", "normal", "hard", "overkill", "overkill_145", "overkill_290"},
		session_stopped = { callback = "no_kills" },
	}
	
	self.session.bank_no_deaths_hard = {
		title_id = "ch_bank_no_deaths_hl",
		description_id = "ch_bank_no_deaths",
		unlock_level = 0, 
		xp = large_xp,
		level_id = "big", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "never_died" },
	}
	self.session.bank_no_bleedouts_hard = {
		title_id = "ch_bank_no_bleedouts_hl",
		description_id = "ch_bank_no_bleedouts",
		unlock_level = 0, xp = huge_xp,
		level_id = "big", 
		difficulty = {"overkill", "overkill_145", "overkill_290"},
		session_stopped = { callback = "never_bleedout" },										
	}
	self.session.bank_success_overkill = {
		title_id = "ch_bank_on_overkill_hl",
		description_id = "ch_bank_on_overkill",
		unlock_level = 0, xp = gigantic_xp,
		level_id = "big", 
		difficulty = {"overkill_145", "overkill_290"},
		session_stopped = { callback = "overkill_success" },
	}
	self.session.bank_overkill_no_trade = {
		title_id = "ch_bank_overkill_no_trade_hl",
		description_id = "ch_bank_overkill_no_trade",
		unlock_level = 0, 
		xp = gigantic_xp,
		level_id = "big", 
		difficulty = {"overkill_145", "overkill_290"},
		increment_counter = "dont_lose_face",
		session_stopped = { callback = "overkill_no_trade" },
	}
	self.session.bank_success_overkill_145 = {
		title_id = "ch_bank_on_overkill_145_hl",
		description_id = "ch_bank_on_overkill_145",
		unlock_level = 0, 
		xp = gigantic_xp,
		level_id = "big", 
		difficulty = "overkill_290",
		increment_counter = "golden_boy",
		session_stopped = { callback = "overkill_success" },
		--awards_achievment = "bank_145"
	}]]--

	-- Street
	--[[self.session.street_no_civilians_hard = {			
		title_id = "ch_street_no_civilians_hl",
		description_id = "ch_street_no_civilians",
		unlock_level = 20, xp = mid_xp,
		level_id = "heat_street", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "no_civilians_killed" },
	}
	self.session.street_no_deaths_hard = {
		title_id = "ch_street_no_deaths_hl",
		description_id = "ch_street_no_deaths",
		unlock_level = 20, 
		xp = large_xp,
		level_id = "heat_street", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "never_died" },
	}
	self.session.street_no_bleedouts_hard = {
		title_id = "ch_street_no_bleedouts_hl",
		description_id = "ch_street_no_bleedouts",
		unlock_level = 20, 
		xp = huge_xp,
		level_id = "heat_street", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "never_bleedout" },										
	}
	self.session.street_success_overkill = {
		title_id = "ch_street_on_overkill_hl",
		description_id = "ch_street_on_overkill",
		unlock_level = 48, 
		xp = gigantic_xp,
		level_id = "heat_street", 
		difficulty = { "overkill", "overkill_145" },
		session_stopped = { callback = "overkill_success" },
	}
	self.session.street_overkill_no_trade = {
		title_id = "ch_street_overkill_no_trade_hl",
		description_id = "ch_street_overkill_no_trade",
		unlock_level = 48, 
		xp = gigantic_xp,
		level_id = "heat_street", 
		difficulty = { "overkill", "overkill_145" },
		increment_counter = "dont_lose_face",
		session_stopped = { callback = "overkill_no_trade" },
	}
	self.session.street_success_overkill_145 = {
		title_id = "ch_street_on_overkill_145_hl",
		description_id = "ch_street_on_overkill_145",
		unlock_level = 145, 
		xp = gigantic_xp,
		increment_counter = "golden_boy",
		level_id = "heat_street", 
		difficulty = "overkill_145",
		session_stopped = { callback = "overkill_success" },
		--awards_achievment = "street_145"
	}]]--

	-- Diamond heist					
	--[[self.session.diamond_heist_no_civilians_hard = {			
		title_id = "ch_diamond_heist_no_civilians_hl",
		description_id = "ch_diamond_heist_no_civilians",
		unlock_level = 0, 
		xp = mid_xp,
		level_id = "mus", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "no_civilians_killed" },
	}
	self.session.diamond_heist_no_deaths_hard = {
		title_id = "ch_diamond_heist_no_deaths_hl",
		description_id = "ch_diamond_heist_no_deaths",
		unlock_level = 20,
		xp = large_xp,
		level_id = "mus", 
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "never_died" },
	}
	self.session.diamond_heist_no_bleedouts_hard = {
		title_id = "ch_diamond_heist_no_bleedouts_hl",
		description_id = "ch_diamond_heist_no_bleedouts",
		unlock_level = 20, 
		xp = huge_xp,
		level_id = "mus",
		difficulty = { "hard", "overkill", "overkill_145" },
		session_stopped = { callback = "never_bleedout" },										
	}
	self.session.diamond_heist_success_overkill = {
		title_id = "ch_diamond_heist_on_overkill_hl",
		description_id = "ch_diamond_heist_on_overkill",
		unlock_level = 48, 
		xp = gigantic_xp,
		level_id = "mus", 
		difficulty = { "overkill", "overkill_145" },
		session_stopped = { callback = "overkill_success" },
	}
	self.session.diamond_heist_overkill_no_trade = {
		title_id = "ch_diamond_heist_overkill_no_trade_hl",
		description_id = "ch_diamond_heist_overkill_no_trade",
		unlock_level = 48,
		xp = gigantic_xp,
		level_id = "mus", 
		difficulty = { "overkill", "overkill_145" },
		increment_counter = "dont_lose_face",
		session_stopped = { callback = "overkill_no_trade" },
	}
	self.session.diamond_heist_success_overkill_145 = {
		title_id = "ch_diamond_heist_on_overkill_145_hl",
		description_id = "ch_diamond_heist_on_overkill_145",
		unlock_level = 145, 
		xp = gigantic_xp,
		increment_counter = "golden_boy",
		level_id = "mus", 
		difficulty = "overkill_145",
		session_stopped = { callback = "overkill_success" },
		--awards_achievment = "diamond_heist_145"
	}]]--
end

function ChallengesTweakData:_any_weapon_challenges()
	local definition = {}
	definition.me = {}
	definition.me.vs_the_law = { 	
		{ count = 100, xp = tiny_xp, in_trial = true }, 
		{ count = 400, xp = small_xp },
		{ count = 800, xp = mid_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = huge_xp },
		{ count = 10000, xp = gigantic_xp },
	}
	definition.me.vs_the_law_head_shot = { 	
		{ count = 100, xp = tiny_xp }, 
		{ count = 300, xp = small_xp },
		{ count = 600, xp = mid_xp },
		{ count = 900, xp = large_xp },
		{ count = 1800, xp = huge_xp },
	}
	
	for i = 1, #definition.me.vs_the_law do
		local name = "me_vs_the_law_"..i
		local count = definition.me.vs_the_law[ i ].count
		local xp = definition.me.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "me_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 	title_id = "ch_me_vs_the_law_"..i.."_hl",
		 	description_id = "ch_me_vs_the_law",
		 	counter_id = "law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
			in_trial = definition.me.vs_the_law[ i ].in_trial
		}
	end
	
	for i = 1, #definition.me.vs_the_law_head_shot do
		local name = "me_vs_the_law_head_shot_"..i
		local count = definition.me.vs_the_law_head_shot[ i ].count
		local xp = definition.me.vs_the_law_head_shot[ i ].xp
		local challenges = { (i-1) > 0 and "me_vs_the_law_head_shot_"..(i-1) or "me_vs_the_law_2" }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 	title_id = "ch_me_vs_the_law_head_shot_"..i.."_hl",
		 	description_id = "ch_me_vs_the_law_head_shot",
		 	counter_id = "law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
			in_trial = definition.me.vs_the_law_head_shot[ i ].in_trial
		}
	end
	
	self.weapon.me_vs_cop = {			
		title_id = "ch_me_vs_cop_hl",
		description_id = "ch_me_vs_cop",
		counter_id = "cop_kill",
		unlock_level = 0,
		count = 100,
		xp = mid_xp,
		depends_on = { challenges = { "me_vs_the_law_3" } }
	}
	self.weapon.me_vs_swat = {			
		title_id = "ch_me_vs_swat_hl",
		description_id = "ch_me_vs_swat",
		counter_id = "swat_kill",
		unlock_level = 0,
		count = 150,
		xp = mid_xp,
		depends_on = { challenges = { "me_vs_cop" } }
	}
	self.weapon.me_vs_fbi = {			
		title_id = "ch_me_vs_fbi_hl",
		description_id = "ch_me_vs_fbi",
		counter_id = "fbi_kill",
		unlock_level = 0,
		count = 200,
		xp = mid_xp,
		depends_on = { challenges = { "me_vs_swat" } }
	}
	self.weapon.me_vs_heavy_swat = {			
		title_id = "ch_me_vs_heavy_swat_hl",
		description_id = "ch_me_vs_heavy_swat",
		counter_id = "heavy_swat_kill",
		unlock_level = 0,
		count = 250,
		xp = large_xp,
		depends_on = { challenges = { "me_vs_fbi" } }
	}
	self.weapon.me_vs_shield = {			
		title_id = "ch_me_vs_shield_hl",
		description_id = "ch_me_vs_shield",
		counter_id = "shield_kill",
		unlock_level = 0,
		count = 100,
		xp = huge_xp,
		depends_on = { challenges = { "me_vs_heavy_swat" } }
	}
	self.weapon.me_vs_taser = {			
		title_id = "ch_me_vs_taser_hl",
		description_id = "ch_me_vs_taser",
		counter_id = "taser_kill",
		unlock_level = 0,
		count = 100,
		xp = gigantic_xp,
		depends_on = { challenges = { "me_vs_shield" } }
	}
	self.weapon.me_vs_spooc = {			
		title_id = "ch_me_vs_spooc_hl",
		description_id = "ch_me_vs_spooc",
		counter_id = "spooc_kill",
		unlock_level = 0,
		count = 100,
		xp = gigantic_xp,
		depends_on = { challenges = { "me_vs_taser" } }
	}
	self.weapon.me_vs_tank = {			
		title_id = "ch_me_vs_tank_hl",
		description_id = "ch_me_vs_tank",
		counter_id = "tank_kill",
		unlock_level = 0,
		count = 100,
		xp = gigantic_xp,
		depends_on = { challenges = { "me_vs_spooc" } }
	}
end

function ChallengesTweakData:_c45_challenges()
	local definition = {}
	definition.c45 = {}
	definition.c45.vs_the_law = { 	
		{ count = 50, xp = tiny_xp }, 
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp }, 
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
	}
	definition.c45.head_shots = { 	
		{ count = 75, xp = small_xp }, 
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp }, 
		{ count = 500, xp = large_xp },
	}
	definition.c45.fbi_kill = { 	
		{ count = 60, xp = huge_xp },
	}

	for i = 1, #definition.c45.vs_the_law do
		local name = "c45_vs_the_law_"..i
		local count = definition.c45.vs_the_law[ i ].count
		local xp = definition.c45.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "c45_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "c45" } }
		self.weapon[ name ] = {
		 	title_id = "ch_c45_vs_the_law_"..i.."_hl",
		 	description_id = "ch_c45_vs_the_law",
		 	counter_id = "c45_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	
	for i = 1, #definition.c45.head_shots do
		local name = "c45_head_shots_"..i
		local count = definition.c45.head_shots[ i ].count
		local xp = definition.c45.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "c45_head_shots_"..(i-1) or "c45_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "c45" } }
		self.weapon[ name ] = {
		 	title_id = "ch_c45_head_shots_"..i.."_hl",
		 	description_id = "ch_c45_head_shots",
		 	counter_id = "c45_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	
	for i = 1, #definition.c45.fbi_kill do
		local name = "c45_fbi_kill_"..i
		local count = definition.c45.fbi_kill[ i ].count
		local xp = definition.c45.fbi_kill[ i ].xp
		local challenges = { (i-1) > 0 and "c45_fbi_kill"..(i-1) or "c45_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "c45" } }
		self.weapon[ name ] = {
		 	title_id = "ch_c45_fbi_kill_"..i.."_hl",
		 	description_id = "ch_c45_fbi_kill",
		 	counter_id = "c45_fbi_kill",
			unlock_level = 0,
			count = count, xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_beretta92_challenges()
	local definition = {}
	definition.beretta92 = {}
	definition.beretta92.vs_the_law = { { count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.beretta92.head_shots = { { count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.beretta92.taser_kill = { { count = 20, xp = huge_xp },
								}
							
	for i = 1, #definition.beretta92.vs_the_law do
		local name = "beretta92_vs_the_law_"..i
		local count = definition.beretta92.vs_the_law[ i ].count
		local xp = definition.beretta92.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "beretta92_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 								title_id = "ch_beretta92_vs_the_law_"..i.."_hl",
		 								description_id = "ch_beretta92_vs_the_law",
		 								counter_id = "beretta92_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.beretta92.head_shots do
		local name = "beretta92_head_shots_"..i
		local count = definition.beretta92.head_shots[ i ].count
		local xp = definition.beretta92.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "beretta92_head_shots_"..(i-1) or "beretta92_vs_the_law_3" }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 								title_id = "ch_beretta92_head_shots_"..i.."_hl",
		 								description_id = "ch_beretta92_head_shots",
		 								counter_id = "beretta92_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.beretta92.taser_kill do
		local name = "beretta92_taser_kill_"..i
		local count = definition.beretta92.taser_kill[ i ].count
		local xp = definition.beretta92.taser_kill[ i ].xp
		local challenges = { (i-1) > 0 and "beretta92_taser_kill"..(i-1) or "beretta92_vs_the_law_5" }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 								title_id = "ch_beretta92_taser_kill_"..i.."_hl",
		 								description_id = "ch_beretta92_taser_kill",
		 								counter_id = "beretta92_taser_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_bronco_challenges()
	local definition = {}
	definition.bronco = {}
	definition.bronco.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.bronco.head_shots = { 	{ count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.bronco.tank_kill = { 	{ count = 5, xp = huge_xp },
								}
							
	for i = 1, #definition.bronco.vs_the_law do
		local name = "bronco_vs_the_law_"..i
		local count = definition.bronco.vs_the_law[ i ].count
		local xp = definition.bronco.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "bronco_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "raging_bull" } }
		self.weapon[ name ] = {
		 								title_id = "ch_bronco_vs_the_law_"..i.."_hl",
		 								description_id = "ch_bronco_vs_the_law",
		 								counter_id = "bronco_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.bronco.head_shots do
		local name = "bronco_head_shots_"..i
		local count = definition.bronco.head_shots[ i ].count
		local xp = definition.bronco.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "bronco_head_shots_"..(i-1) or "bronco_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "raging_bull" } }
		self.weapon[ name ] = {
		 								title_id = "ch_bronco_head_shots_"..i.."_hl",
		 								description_id = "ch_bronco_head_shots",
		 								counter_id = "bronco_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.bronco.tank_kill do
		local name = "bronco_tank_kill_"..i
		local count = definition.bronco.tank_kill[ i ].count
		local xp = definition.bronco.tank_kill[ i ].xp
		local challenges = { (i-1) > 0 and "bronco_tank_kill"..(i-1) or "bronco_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "raging_bull" } }
		self.weapon[ name ] = {
		 								title_id = "ch_bronco_tank_kill_"..i.."_hl",
		 								description_id = "ch_bronco_tank_kill",
		 								counter_id = "bronco_tank_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_reinbeck_challenges()
	local definition = {}
	definition.reinbeck = {}
	definition.reinbeck.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.reinbeck.head_shots = { 	{ count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.reinbeck.spooc_kill = { 	{ count = 20, xp = huge_xp },
								}
							
	for i = 1, #definition.reinbeck.vs_the_law do
		local name = "reinbeck_vs_the_law_"..i
		local count = definition.reinbeck.vs_the_law[ i ].count
		local xp = definition.reinbeck.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "reinbeck_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "r870_shotgun" } }
		self.weapon[ name ] = {
		 								title_id = "ch_reinbeck_vs_the_law_"..i.."_hl",
		 								description_id = "ch_reinbeck_vs_the_law",
		 								counter_id = "reinbeck_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.reinbeck.head_shots do
		local name = "reinbeck_head_shots_"..i
		local count = definition.reinbeck.head_shots[ i ].count
		local xp = definition.reinbeck.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "reinbeck_head_shots_"..(i-1) or "reinbeck_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "r870_shotgun" } }
		self.weapon[ name ] = {
		 								title_id = "ch_reinbeck_head_shots_"..i.."_hl",
		 								description_id = "ch_reinbeck_head_shots",
		 								counter_id = "reinbeck_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.reinbeck.spooc_kill do
		local name = "reinbeck_spooc_kill_"..i
		local count = definition.reinbeck.spooc_kill[ i ].count
		local xp = definition.reinbeck.spooc_kill[ i ].xp
		local challenges = { (i-1) > 0 and "reinbeck_spooc_kill"..(i-1) or "reinbeck_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "r870_shotgun" } }
		self.weapon[ name ] = {
		 								title_id = "ch_reinbeck_spooc_kill_"..i.."_hl",
		 								description_id = "ch_reinbeck_spooc_kill",
		 								counter_id = "reinbeck_spooc_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_mossberg_challenges()
	local definition = {}
	definition.mossberg = {}
	definition.mossberg.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.mossberg.head_shots = { 	{ count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.mossberg.cop_kill = { 	{ count = 20, xp = huge_xp },
								}
							
	for i = 1, #definition.mossberg.vs_the_law do
		local name = "mossberg_vs_the_law_"..i
		local count = definition.mossberg.vs_the_law[ i ].count
		local xp = definition.mossberg.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "mossberg_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "mossberg" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mossberg_vs_the_law_"..i.."_hl",
		 								description_id = "ch_mossberg_vs_the_law",
		 								counter_id = "mossberg_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mossberg.head_shots do
		local name = "mossberg_head_shots_"..i
		local count = definition.mossberg.head_shots[ i ].count
		local xp = definition.mossberg.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "mossberg_head_shots_"..(i-1) or "mossberg_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "mossberg" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mossberg_head_shots_"..i.."_hl",
		 								description_id = "ch_mossberg_head_shots",
		 								counter_id = "mossberg_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mossberg.cop_kill do
		local name = "mossberg_cop_kill_"..i
		local count = definition.mossberg.cop_kill[ i ].count
		local xp = definition.mossberg.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "mossberg_cop_kill"..(i-1) or "mossberg_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "mossberg" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mossberg_cop_kill_"..i.."_hl",
		 								description_id = "ch_mossberg_cop_kill",
		 								counter_id = "mossberg_cop_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_mp5_challenges()
	local definition = {}
	definition.mp5 = {}
	definition.mp5.vs_the_law = { 		{ count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.mp5.head_shots = { 		{ count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.mp5.shield_head_shots = { 	{ count = 10, xp = huge_xp },
								}
							
	for i = 1, #definition.mp5.vs_the_law do
		local name = "mp5_vs_the_law_"..i
		local count = definition.mp5.vs_the_law[ i ].count
		local xp = definition.mp5.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "mp5_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "mp5" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mp5_vs_the_law_"..i.."_hl",
		 								description_id = "ch_mp5_vs_the_law",
		 								counter_id = "mp5_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mp5.head_shots do
		local name = "mp5_head_shots_"..i
		local count = definition.mp5.head_shots[ i ].count
		local xp = definition.mp5.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "mp5_head_shots_"..(i-1) or "mp5_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "mp5" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mp5_head_shots_"..i.."_hl",
		 								description_id = "ch_mp5_head_shots",
		 								counter_id = "mp5_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mp5.shield_head_shots do
		local name = "mp5_shield_head_shots_"..i
		local count = definition.mp5.shield_head_shots[ i ].count
		local xp = definition.mp5.shield_head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "mp5_shield_head_shots"..(i-1) or "mp5_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "mp5" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mp5_shield_head_shot_"..i.."_hl",
		 								description_id = "ch_mp5_shield_head_shot",
		 								counter_id = "mp5_shield_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_mac11_challenges()
	local definition = {}
	definition.mac11 = {}
	definition.mac11.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
										{ count = 200, xp = small_xp },
										{ count = 400, xp = mid_xp }, 
										{ count = 600, xp = large_xp },
										{ count = 800, xp = large_xp },
										{ count = 1000, xp = large_xp },
								}
	definition.mac11.head_shots = { 	{ count = 75, xp = small_xp }, 
										{ count = 200, xp = mid_xp },
										{ count = 350, xp = large_xp }, 
										{ count = 500, xp = large_xp },
								}
	definition.mac11.heavy_swat_kill = { 	{ count = 120, xp = huge_xp },
								}
							
	for i = 1, #definition.mac11.vs_the_law do
		local name = "mac11_vs_the_law_"..i
		local count = definition.mac11.vs_the_law[ i ].count
		local xp = definition.mac11.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "mac11_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "mac11" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mac11_vs_the_law_"..i.."_hl",
		 								description_id = "ch_mac11_vs_the_law",
		 								counter_id = "mac11_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mac11.head_shots do
		local name = "mac11_head_shots_"..i
		local count = definition.mac11.head_shots[ i ].count
		local xp = definition.mac11.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "mac11_head_shots_"..(i-1) or "mac11_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "mac11" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mac11_head_shots_"..i.."_hl",
		 								description_id = "ch_mac11_head_shots",
		 								counter_id = "mac11_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.mac11.heavy_swat_kill do
		local name = "mac11_heavy_swat_kill_"..i
		local count = definition.mac11.heavy_swat_kill[ i ].count
		local xp = definition.mac11.heavy_swat_kill[ i ].xp
		local challenges = { (i-1) > 0 and "mac11_heavy_swat_kill"..(i-1) or "mac11_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "mac11" } }
		self.weapon[ name ] = {
		 								title_id = "ch_mac11_heavy_swat_kill_"..i.."_hl",
		 								description_id = "ch_mac11_heavy_swat_kill",
		 								counter_id = "mac11_heavy_swat_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_m4_challenges()
	local definition = {}
	definition.m4 = {}
	definition.m4.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.m4.head_shots = { 	{ count = 75, xp = small_xp }, 
									{ count = 200, xp = mid_xp },
									{ count = 350, xp = large_xp }, 
									{ count = 500, xp = large_xp },
								}
	definition.m4.spooc_head_shot = { 	{ count = 20, xp = huge_xp },
								}
							
	for i = 1, #definition.m4.vs_the_law do
		local name = "m4_vs_the_law_"..i
		local count = definition.m4.vs_the_law[ i ].count
		local xp = definition.m4.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "m4_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = nil }
		self.weapon[ name ] = {
		 								title_id = "ch_m4_vs_the_law_"..i.."_hl",
		 								description_id = "ch_m4_vs_the_law",
		 								counter_id = "m4_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.m4.head_shots do
		local name = "m4_head_shots_"..i
		local count = definition.m4.head_shots[ i ].count
		local xp = definition.m4.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "m4_head_shots_"..(i-1) or "m4_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = nil }
		self.weapon[ name ] = {
		 								title_id = "ch_m4_head_shots_"..i.."_hl",
		 								description_id = "ch_m4_head_shots",
		 								counter_id = "m4_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.m4.spooc_head_shot do
		local name = "m4_spooc_head_shot_"..i
		local count = definition.m4.spooc_head_shot[ i ].count
		local xp = definition.m4.spooc_head_shot[ i ].xp
		local challenges = { (i-1) > 0 and "m4_spooc_head_shot"..(i-1) or "m4_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = nil }
		self.weapon[ name ] = {
		 								title_id = "ch_m4_spooc_head_shot_"..i.."_hl",
		 								description_id = "ch_m4_spooc_head_shot",
		 								counter_id = "m4_spooc_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_m14_challenges()
	local definition = {}
	definition.m14 = {}
	definition.m14.vs_the_law = { 	{ count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.m14.head_shots = { 	{ count = 75, xp = small_xp }, 
									{ count = 200, xp = mid_xp },
									{ count = 350, xp = large_xp }, 
									{ count = 500, xp = large_xp },
								}
	definition.m14.taser_head_shot = { 	{ count = 15, xp = huge_xp },
								}
							
	for i = 1, #definition.m14.vs_the_law do
		local name = "m14_vs_the_law_"..i
		local count = definition.m14.vs_the_law[ i ].count
		local xp = definition.m14.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "m14_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "m14" } }
		self.weapon[ name ] = {
		 								title_id = "ch_m14_vs_the_law_"..i.."_hl",
		 								description_id = "ch_m14_vs_the_law",
		 								counter_id = "m14_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.m14.head_shots do
		local name = "m14_head_shots_"..i
		local count = definition.m14.head_shots[ i ].count
		local xp = definition.m14.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "m14_head_shots_"..(i-1) or "m14_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "m14" } }
		self.weapon[ name ] = {
		 								title_id = "ch_m14_head_shots_"..i.."_hl",
		 								description_id = "ch_m14_head_shots",
		 								counter_id = "m14_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.m14.taser_head_shot do
		local name = "m14_taser_head_shot_"..i
		local count = definition.m14.taser_head_shot[ i ].count
		local xp = definition.m14.taser_head_shot[ i ].xp
		local challenges = { (i-1) > 0 and "m14_taser_head_shot"..(i-1) or "m14_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "m14" } }
		self.weapon[ name ] = {
		 								title_id = "ch_m14_taser_head_shot_"..i.."_hl",
		 								description_id = "ch_m14_taser_head_shot",
		 								counter_id = "m14_taser_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end

function ChallengesTweakData:_hk21_challenges()
	local definition = {}
	definition.hk21 = {}
	definition.hk21.vs_the_law = { { count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.hk21.head_shots = { 	{ count = 75, xp = small_xp }, 
									{ count = 200, xp = mid_xp },
									{ count = 350, xp = large_xp }, 
									{ count = 500, xp = large_xp },
								}
	definition.hk21.shield_kill = { 	{ count = 30, xp = huge_xp },
								}
							
	for i = 1, #definition.hk21.vs_the_law do
		local name = "hk21_vs_the_law_"..i
		local count = definition.hk21.vs_the_law[ i ].count
		local xp = definition.hk21.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "hk21_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "hk21" } }
		self.weapon[ name ] = {
		 								title_id = "ch_hk21_vs_the_law_"..i.."_hl",
		 								description_id = "ch_hk21_vs_the_law",
		 								counter_id = "hk21_law_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.hk21.head_shots do
		local name = "hk21_head_shots_"..i
		local count = definition.hk21.head_shots[ i ].count
		local xp = definition.hk21.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "hk21_head_shots_"..(i-1) or "hk21_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "hk21" } }
		self.weapon[ name ] = {
		 								title_id = "ch_hk21_head_shots_"..i.."_hl",
		 								description_id = "ch_hk21_head_shots",
		 								counter_id = "hk21_law_head_shot",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
	
	for i = 1, #definition.hk21.shield_kill do
		local name = "hk21_shield_kill_"..i
		local count = definition.hk21.shield_kill[ i ].count
		local xp = definition.hk21.shield_kill[ i ].xp
		local challenges = { (i-1) > 0 and "hk21_shield_kill"..(i-1) or "hk21_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "hk21" } }
		self.weapon[ name ] = {
		 								title_id = "ch_hk21_shield_kill_"..i.."_hl",
		 								description_id = "ch_hk21_shield_kill",
		 								counter_id = "hk21_shield_kill",
										unlock_level = 0,
										count = count, xp = xp,
										depends_on = depends_on,
		 								}
	end
end


function ChallengesTweakData:_glock_challenges()
	local definition = {}
	definition.glock = {}
	definition.glock.vs_the_law = { { count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.glock.head_shots = { { count = 75, xp = small_xp }, 
									{ count = 200, xp = mid_xp },
									{ count = 350, xp = large_xp }, 
									{ count = 500, xp = large_xp },
								}
	definition.glock.shield_body_shots = { { count = 20, xp = huge_xp },
								}
								
							
	for i = 1, #definition.glock.vs_the_law do
		local name = "glock_vs_the_law_"..i
		local count = definition.glock.vs_the_law[ i ].count
		local xp = definition.glock.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "glock_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "glock" } }
		self.weapon[ name ] = { title_id = "ch_glock_vs_the_law_"..i.."_hl",
 								description_id = "ch_glock_vs_the_law",
 								counter_id = "glock_law_kill",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.glock.head_shots do
		local name = "glock_head_shots_"..i
		local count = definition.glock.head_shots[ i ].count
		local xp = definition.glock.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "glock_head_shots_"..(i-1) or "glock_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "glock" } }
		self.weapon[ name ] = { title_id = "ch_glock_head_shots_"..i.."_hl",
 								description_id = "ch_glock_head_shots",
 								counter_id = "glock_law_head_shot",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.glock.shield_body_shots do
		local name = "glock_shield_body_shots_"..i
		local count = definition.glock.shield_body_shots[ i ].count
		local xp = definition.glock.shield_body_shots[ i ].xp
		local challenges = { (i-1) > 0 and "glock_shield_body_shots"..(i-1) or "glock_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "glock" } }
		self.weapon[ name ] = { title_id = "ch_glock_shield_body_shot_"..i.."_hl",
 								description_id = "ch_glock_shield_body_shot",
 								counter_id = "glock_shield_body_shot",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
end


	
function ChallengesTweakData:_ak47_challenges()
	local definition = {}
	definition.ak47 = {}
	definition.ak47.vs_the_law = { { count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.ak47.head_shots = { { count = 75, xp = small_xp }, 
									{ count = 200, xp = mid_xp },
									{ count = 350, xp = large_xp }, 
									{ count = 500, xp = large_xp },
								}
	definition.ak47.taser_kill = { { count = 20, xp = huge_xp },
								}
								
							
	for i = 1, #definition.ak47.vs_the_law do
		local name = "ak47_vs_the_law_"..i
		local count = definition.ak47.vs_the_law[ i ].count
		local xp = definition.ak47.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "ak47_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "ak47" } }
		self.weapon[ name ] = { title_id = "ch_ak47_vs_the_law_"..i.."_hl",
 								description_id = "ch_ak47_vs_the_law",
 								counter_id = "ak47_law_kill",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.ak47.head_shots do
		local name = "ak47_head_shots_"..i
		local count = definition.ak47.head_shots[ i ].count
		local xp = definition.ak47.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "ak47_head_shots_"..(i-1) or "ak47_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "ak47" } }
		self.weapon[ name ] = { title_id = "ch_ak47_head_shots_"..i.."_hl",
 								description_id = "ch_ak47_head_shots",
 								counter_id = "ak47_law_head_shot",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.ak47.taser_kill do
		local name = "ak47_taser_kill_"..i
		local count = definition.ak47.taser_kill[ i ].count
		local xp = definition.ak47.taser_kill[ i ].xp
		local challenges = { (i-1) > 0 and "ak47_taser_kill"..(i-1) or "ak47_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "ak47" } }
		self.weapon[ name ] = {
			title_id = "ch_ak47_taser_kill_"..i.."_hl",
 			description_id = "ch_ak47_taser_kill",
 			counter_id = "ak47_taser_kill",
			unlock_level = 0,
			count = count, xp = xp,
			depends_on = depends_on,
 		}
	end
end



function ChallengesTweakData:_m79_challenges()
	local definition = {}
	definition.m79 = {}
	definition.m79.vs_the_law = { { count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.m79.simultaneous_kills = 
								  { { count = 4, xp = small_xp }, 
									{ count = 6, xp = mid_xp },
									{ count = 8, xp = large_xp }, 
									{ count = 10, xp = large_xp },
								}
	definition.m79.simultaneous_specials = { { count = 3, xp = huge_xp },
								}
								
							
	for i = 1, #definition.m79.vs_the_law do
		local name = "m79_vs_the_law_"..i
		local count = definition.m79.vs_the_law[ i ].count
		local xp = definition.m79.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "m79_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, weapons = { "m79" } }
		self.weapon[ name ] = { title_id = "ch_m79_vs_the_law_"..i.."_hl",
 								description_id = "ch_m79_vs_the_law",
 								counter_id = "m79_law_kill",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.m79.simultaneous_kills do
		local name = "m79_simultaneous_kills_"..i
		local count = definition.m79.simultaneous_kills[ i ].count
		local xp = definition.m79.simultaneous_kills[ i ].xp
		local challenges = { (i-1) > 0 and "m79_simultaneous_kills_"..(i-1) or "m79_vs_the_law_3" }
		local depends_on = { challenges = challenges, weapons = { "m79" } }
		self.weapon[ name ] = { title_id = "ch_m79_simultaneous_kills_"..i.."_hl",
 								description_id = "ch_m79_simultaneous_kills",
 								counter_id = "m79_law_simultaneous_kills",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	for i = 1, #definition.m79.simultaneous_specials do
		local name = "m79_taser_kill_"..i
		local count = definition.m79.simultaneous_specials[ i ].count
		local xp = definition.m79.simultaneous_specials[ i ].xp
		local challenges = { (i-1) > 0 and "m79_simultaneous_specials"..(i-1) or "m79_vs_the_law_5" }
		local depends_on = { challenges = challenges, weapons = { "m79" } }
		self.weapon[ name ] = { title_id = "ch_m79_simultaneous_specials_"..i.."_hl",
 								description_id = "ch_m79_simultaneous_specials",
 								counter_id = "m79_simultaneous_specials",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
end



function ChallengesTweakData:_sentry_gun_challenges()
	local definition = {}
	definition.sentry_gun = {}
	definition.sentry_gun.vs_the_law = 
								  { { count = 50, xp = tiny_xp }, 
									{ count = 200, xp = small_xp },
									{ count = 400, xp = mid_xp }, 
									{ count = 600, xp = large_xp },
									{ count = 800, xp = large_xp },
									{ count = 1000, xp = large_xp },
								}
	definition.sentry_gun.row_kills = 
								  { { count = 5, xp = small_xp }, 
									{ count = 10, xp = mid_xp },
									{ count = 15, xp = large_xp }, 
									{ count = 20, xp = large_xp },
								}
								
							
	for i = 1, #definition.sentry_gun.vs_the_law do
		local name = "sentry_gun_vs_the_law_"..i
		local count = definition.sentry_gun.vs_the_law[ i ].count
		local xp = definition.sentry_gun.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "sentry_gun_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = { title_id = "ch_sentry_gun_vs_the_law_"..i.."_hl",
 								description_id = "ch_sentry_gun_vs_the_law",
 								counter_id = "sentry_gun_law_kill",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end
	
	--[[for i = 1, #definition.sentry_gun.row_kills do
		local name = "sentry_gun_row_kills_"..i
		local count = definition.sentry_gun.row_kills[ i ].count
		local xp = definition.sentry_gun.row_kills[ i ].xp
		local challenges = { (i-1) > 0 and "sentry_gun_row_kills_"..(i-1) or "sentry_gun_vs_the_law_3" }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = { title_id = "ch_sentry_gun_row_kills_"..i.."_hl",
 								description_id = "ch_sentry_gun_row_kills",
 								counter_id = "sentry_gun_law_row_kills",
								unlock_level = 0,
								count = count, xp = xp,
								depends_on = depends_on,
 							}
	end]]--
	
	--[[self.weapon.sentry_gun_resources = {
		title_id = "ch_sentry_gun_resources_hl",
		description_id = "ch_sentry_gun_resources",
		flag_id = "sentry_gun_resources",
		unlock_level = 0,
		xp = huge_xp,
		depends_on = { challenges = { "sentry_gun_vs_the_law_5" } },
	}]]--
end




function ChallengesTweakData:_trip_mine_challenges()
	self.weapon.plant_tripmine = {			
		title_id = "ch_plant_tripmine_hl",
		description_id = "ch_plant_tripmine",
		counter_id = "plant_tripmine",
		unlock_level = 0,
		count = 200,
		--No visible counter?
		xp = mid_xp,
		depends_on = { equipment = { "trip_mine" } }
	}
	local definition = {}
	definition.trip_mine = {}
	definition.trip_mine.vs_the_law = {
		{ count = 10, xp = tiny_xp }, 
		{ count = 20, xp = small_xp },
		{ count = 40, xp = mid_xp }, 
		{ count = 80, xp = large_xp },
	}
	for i = 1, #definition.trip_mine.vs_the_law do
		local name = "trip_mine_vs_the_law_"..i
		local count = definition.trip_mine.vs_the_law[ i ].count
		local xp = definition.trip_mine.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "trip_mine_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges, equipment = { "trip_mine" } }
		self.weapon[ name ] = {
		 	title_id = "ch_trip_mine_vs_the_law_"..i.."_hl",
			description_id = "ch_trip_mine_vs_the_law",
		 	counter_id = "trip_mine_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	
	--[[self.weapon.dual_tripmine = {			
		title_id = "ch_dual_tripmine_hl",
		description_id = "ch_dual_tripmine",
		counter_id = "dual_tripmine",
		unlock_level = 0,
		count = 1,
		--No visible counter?
		xp = mid_xp,
		depends_on = { challenges = { "trip_mine_vs_the_law_2" }, equipment = { "trip_mine" } }
	}
	self.weapon.tris_tripmine = {			
		title_id = "ch_tris_tripmine_hl",
		description_id = "ch_tris_tripmine",
		counter_id = "tris_tripmine",
		unlock_level = 0,
		count = 1,
		--No visible counter?
		xp = large_xp,
		depends_on = { challenges = { "dual_tripmine" }, equipment = { "trip_mine" } }
	}
	self.weapon.quad_tripmine = {	
		title_id = "ch_quad_tripmine_hl",
		description_id = "ch_quad_tripmine",
		counter_id = "quad_tripmine",
		unlock_level = 0,
		count = 1,
		--No visible counter?
		xp = huge_xp,
		depends_on = { challenges = { "tris_tripmine" }, equipment = { "trip_mine" } }
	}]]--
end

function ChallengesTweakData:_bleed_out_challenges()
	local definition = {}
	definition.bleed_out = {}
	definition.bleed_out.vs_the_law = {
		{ count = 10, xp = small_xp }, 
		{ count = 20, xp = small_xp },
		{ count = 40, xp = mid_xp }, 
		{ count = 80, xp = large_xp },
	}
	for i = 1, #definition.bleed_out.vs_the_law do
		local name = "bleed_out_vs_the_law_"..i
		local count = definition.bleed_out.vs_the_law[ i ].count
		local xp = definition.bleed_out.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "bleed_out_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 	title_id = "ch_bleed_out_kill_"..i.."_hl",
		 	description_id = "ch_bleed_out_kill",
			counter_id = "bleed_out_kill",
			unlock_level = 30,
			count = count,
			xp = xp,
			depends_on = depends_on,
		}
	end
	
	self.weapon.bleed_out_multikill = {			
		title_id = "ch_bleed_out_multikill_hl",
		description_id = "ch_bleed_out_multikill",
		counter_id = "bleed_out_multikill",
		unlock_level = 30,
		count = 10,
		xp = huge_xp,
		reset_criterias = { "exit_bleed_out" },
		depends_on = {challenges = { "bleed_out_vs_the_law_4" }}
	}
	self.weapon.grim_reaper = {			
		title_id = "ch_grim_reaper_hl",
		description_id = "ch_grim_reaper",
		counter_id = "grim_reaper",
		unlock_level = 30,
		count = 1,
		xp = large_xp,
		depends_on = {challenges = {"bleed_out_multikill"}}
	}
end


function ChallengesTweakData:_melee_challenges()
	local definition = {}
	definition.melee = {}
	definition.melee.vs_the_law = {
		{ count = 10, xp = tiny_xp, in_trial = true }, 
		{ count = 30, xp = small_xp },
		{ count = 60, xp = mid_xp }, 
		{ count = 120, xp = large_xp },
	}
	for i = 1, #definition.melee.vs_the_law do
		local name = "melee_vs_the_law_"..i
		local count = definition.melee.vs_the_law[ i ].count
		local xp = definition.melee.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "melee_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.weapon[ name ] = {
		 	title_id = "ch_melee_"..i.."_hl",
		 	description_id = "ch_melee",
			counter_id = "melee_law_kill",
			unlock_level = 0,
			count = count, xp = xp,
			depends_on = depends_on,
			in_trial = definition.melee.vs_the_law[ i ].in_trial
		}
	end
end

function ChallengesTweakData:_money_challenges()
	local definition = {}
	definition.money = {}
	-- Amount here must be equal to localization description
	definition.money.aquire = {
		{ amount =   20000000, xp = mid_xp, in_trial = true }, 
		{ amount =   50000000, xp = mid_xp },
		{ amount =  100000000, xp = large_xp }, 
		{ amount =  200000000, xp = large_xp },
		{ amount =  300000000, xp = large_xp },
		{ amount =  400000000, xp = huge_xp },
		{ amount =  500000000, xp = huge_xp },
		{ amount =  600000000, xp = gigantic_xp },
		{ amount =  800000000, xp = gigantic_xp },
		{ amount = 1000000000, xp = gigantic_xp },
	}
	for i = 1, #definition.money.aquire do
		local name = "aquire_money"..i
		local amount = definition.money.aquire[ i ].amount
		local xp = definition.money.aquire[ i ].xp
		local awards_achievment = definition.money.aquire[ i ].awards_achievment
		local challenges = { (i-1) > 0 and "aquire_money"..(i-1) or nil }
		local depends_on = { challenges = challenges }
		self.session[ name ] = {
		 	title_id = "ch_aquire_money_"..i.."_hl",
		 	description_id = "ch_aquire_money_"..i,
		 	--counter_id = "melee_law_kill",
			unlock_level = 0,
			amount = amount, 
			xp = xp,
			--awards_achievment = awards_achievment,
			depends_on = depends_on,
			id = "aquired_money",
			in_trial = definition.money.aquire[ i ].in_trial
		}
	end
end


function ChallengesTweakData:_shotgun_challenges()
	local definition = {}
	definition.shotgun = {}
	definition.shotgun.vs_the_law = { 	
		{ count = 50, xp = tiny_xp }, 
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp }, 
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.shotgun.head_shots = { 	
		{ count = 75, xp = small_xp }, 
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp }, 
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.shotgun.cop_kill = {
		{ count = 20, xp = huge_xp },	
	}
	for i = 1, #definition.shotgun.vs_the_law do
		local name = "shotgun_vs_the_law_"..i
		local count = definition.shotgun.vs_the_law[ i ].count
		local xp = definition.shotgun.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "shotgun_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_shotgun_vs_the_law_"..i.."_hl",
		 	description_id = "ch_shotgun_vs_the_law",
		 	counter_id = "shotgun_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.shotgun.head_shots do
		local name = "shotgun_head_shots_"..i
		local count = definition.shotgun.head_shots[ i ].count
		local xp = definition.shotgun.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "shotgun_head_shots_"..(i-1) or "shotgun_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_shotgun_head_shots_"..i.."_hl",
			description_id = "ch_shotgun_head_shots",
		 	counter_id = "shotgun_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.shotgun.cop_kill do
		local name = "shotgun_cop_kill_"..i
		local count = definition.shotgun.cop_kill[ i ].count
		local xp = definition.shotgun.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "shotgun_cop_kill"..(i-1) or "shotgun_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_shotgun_cop_kill_"..i.."_hl",
		 	description_id = "ch_shotgun_cop_kill",
		 	counter_id = "shotgun_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_assault_rifle_challenges()
	local definition = {}
	definition.assault_rifle = {}
	definition.assault_rifle.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.assault_rifle.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.assault_rifle.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.assault_rifle.vs_the_law do
		local name = "assault_rifle_vs_the_law_"..i
		local count = definition.assault_rifle.vs_the_law[ i ].count
		local xp = definition.assault_rifle.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "assault_rifle_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_assault_rifle_vs_the_law_"..i.."_hl",
		 	description_id = "ch_assault_rifle_vs_the_law",
		 	counter_id = "assault_rifle_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.assault_rifle.head_shots do
		local name = "assault_rifle_head_shots_"..i
		local count = definition.assault_rifle.head_shots[ i ].count
		local xp = definition.assault_rifle.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "assault_rifle_head_shots_"..(i-1) or "assault_rifle_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_assault_rifle_head_shots_"..i.."_hl",
			description_id = "ch_assault_rifle_head_shots",
		 	counter_id = "assault_rifle_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.assault_rifle.cop_kill do
		local name = "assault_rifle_cop_kill_"..i
		local count = definition.assault_rifle.cop_kill[ i ].count
		local xp = definition.assault_rifle.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "assault_rifle_cop_kill"..(i-1) or "assault_rifle_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_assault_rifle_cop_kill_"..i.."_hl",
		 	description_id = "ch_assault_rifle_cop_kill",
		 	counter_id = "assault_rifle_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_snp_challenges()
	local definition = {}
	definition.snp = {}
	definition.snp.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.snp.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.snp.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.snp.vs_the_law do
		local name = "snp_vs_the_law_"..i
		local count = definition.snp.vs_the_law[ i ].count
		local xp = definition.snp.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "snp_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_snp_vs_the_law_"..i.."_hl",
		 	description_id = "ch_snp_vs_the_law",
		 	counter_id = "snp_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.snp.head_shots do
		local name = "snp_head_shots_"..i
		local count = definition.snp.head_shots[ i ].count
		local xp = definition.snp.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "snp_head_shots_"..(i-1) or "snp_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_snp_head_shots_"..i.."_hl",
			description_id = "ch_snp_head_shots",
		 	counter_id = "snp_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.snp.cop_kill do
		local name = "snp_cop_kill_"..i
		local count = definition.snp.cop_kill[ i ].count
		local xp = definition.snp.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "snp_cop_kill"..(i-1) or "snp_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_snp_cop_kill_"..i.."_hl",
		 	description_id = "ch_snp_cop_kill",
		 	counter_id = "snp_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_lmg_challenges()
	local definition = {}
	definition.lmg = {}
	definition.lmg.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.lmg.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.lmg.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.lmg.vs_the_law do
		local name = "lmg_vs_the_law_"..i
		local count = definition.lmg.vs_the_law[ i ].count
		local xp = definition.lmg.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "lmg_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_lmg_vs_the_law_"..i.."_hl",
		 	description_id = "ch_lmg_vs_the_law",
		 	counter_id = "lmg_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.lmg.head_shots do
		local name = "lmg_head_shots_"..i
		local count = definition.lmg.head_shots[ i ].count
		local xp = definition.lmg.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "lmg_head_shots_"..(i-1) or "lmg_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_lmg_head_shots_"..i.."_hl",
			description_id = "ch_lmg_head_shots",
		 	counter_id = "lmg_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.lmg.cop_kill do
		local name = "lmg_cop_kill_"..i
		local count = definition.lmg.cop_kill[ i ].count
		local xp = definition.lmg.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "lmg_cop_kill"..(i-1) or "lmg_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_lmg_cop_kill_"..i.."_hl",
		 	description_id = "ch_lmg_cop_kill",
		 	counter_id = "lmg_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_akimbo_challenges()
	local definition = {}
	definition.akimbo = {}
	definition.akimbo.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.akimbo.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.akimbo.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.akimbo.vs_the_law do
		local name = "akimbo_vs_the_law_"..i
		local count = definition.akimbo.vs_the_law[ i ].count
		local xp = definition.akimbo.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "akimbo_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_akimbo_vs_the_law_"..i.."_hl",
		 	description_id = "ch_akimbo_vs_the_law",
		 	counter_id = "akimbo_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.akimbo.head_shots do
		local name = "akimbo_head_shots_"..i
		local count = definition.akimbo.head_shots[ i ].count
		local xp = definition.akimbo.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "akimbo_head_shots_"..(i-1) or "akimbo_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_akimbo_head_shots_"..i.."_hl",
			description_id = "ch_akimbo_head_shots",
		 	counter_id = "akimbo_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.akimbo.cop_kill do
		local name = "akimbo_cop_kill_"..i
		local count = definition.akimbo.cop_kill[ i ].count
		local xp = definition.akimbo.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "akimbo_cop_kill"..(i-1) or "akimbo_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_akimbo_cop_kill_"..i.."_hl",
		 	description_id = "ch_akimbo_cop_kill",
		 	counter_id = "akimbo_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end


function ChallengesTweakData:_saw_challenges()
	local definition = {}
	definition.saw = {}
	definition.saw.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.saw.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.saw.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.saw.vs_the_law do
		local name = "saw_vs_the_law_"..i
		local count = definition.saw.vs_the_law[ i ].count
		local xp = definition.saw.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "saw_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_saw_vs_the_law_"..i.."_hl",
		 	description_id = "ch_saw_vs_the_law",
		 	counter_id = "saw_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.saw.head_shots do
		local name = "saw_head_shots_"..i
		local count = definition.saw.head_shots[ i ].count
		local xp = definition.saw.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "saw_head_shots_"..(i-1) or "saw_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_saw_head_shots_"..i.."_hl",
			description_id = "ch_saw_head_shots",
		 	counter_id = "saw_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.saw.cop_kill do
		local name = "saw_cop_kill_"..i
		local count = definition.saw.cop_kill[ i ].count
		local xp = definition.saw.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "saw_cop_kill"..(i-1) or "saw_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_saw_cop_kill_"..i.."_hl",
		 	description_id = "ch_saw_cop_kill",
		 	counter_id = "saw_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_smg_challenges()
	local definition = {}
	definition.smg = {}
	definition.smg.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.smg.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.smg.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.smg.vs_the_law do
		local name = "smg_vs_the_law_"..i
		local count = definition.smg.vs_the_law[ i ].count
		local xp = definition.smg.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "smg_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_smg_vs_the_law_"..i.."_hl",
		 	description_id = "ch_smg_vs_the_law",
		 	counter_id = "smg_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.smg.head_shots do
		local name = "smg_head_shots_"..i
		local count = definition.smg.head_shots[ i ].count
		local xp = definition.smg.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "smg_head_shots_"..(i-1) or "smg_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_smg_head_shots_"..i.."_hl",
			description_id = "ch_smg_head_shots",
		 	counter_id = "smg_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.smg.cop_kill do
		local name = "smg_cop_kill_"..i
		local count = definition.smg.cop_kill[ i ].count
		local xp = definition.smg.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "smg_cop_kill"..(i-1) or "smg_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_smg_cop_kill_"..i.."_hl",
		 	description_id = "ch_smg_cop_kill",
		 	counter_id = "smg_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_pistol_challenges()
	local definition = {}
	definition.pistol = {}
	definition.pistol.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.pistol.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.pistol.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.pistol.vs_the_law do
		local name = "pistol_vs_the_law_"..i
		local count = definition.pistol.vs_the_law[ i ].count
		local xp = definition.pistol.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "pistol_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_pistol_vs_the_law_"..i.."_hl",
		 	description_id = "ch_pistol_vs_the_law",
		 	counter_id = "pistol_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.pistol.head_shots do
		local name = "pistol_head_shots_"..i
		local count = definition.pistol.head_shots[ i ].count
		local xp = definition.pistol.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "pistol_head_shots_"..(i-1) or "pistol_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_pistol_head_shots_"..i.."_hl",
			description_id = "ch_pistol_head_shots",
		 	counter_id = "pistol_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.pistol.cop_kill do
		local name = "pistol_cop_kill_"..i
		local count = definition.pistol.cop_kill[ i ].count
		local xp = definition.pistol.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "pistol_cop_kill"..(i-1) or "pistol_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_pistol_cop_kill_"..i.."_hl",
		 	description_id = "ch_pistol_cop_kill",
		 	counter_id = "pistol_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end
function ChallengesTweakData:_minigun_challenges()
	local definition = {}
	definition.minigun = {}
	definition.minigun.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.minigun.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.minigun.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.minigun.vs_the_law do
		local name = "minigun_vs_the_law_"..i
		local count = definition.minigun.vs_the_law[ i ].count
		local xp = definition.minigun.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "minigun_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_minigun_vs_the_law_"..i.."_hl",
		 	description_id = "ch_minigun_vs_the_law",
		 	counter_id = "minigun_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.minigun.head_shots do
		local name = "minigun_head_shots_"..i
		local count = definition.minigun.head_shots[ i ].count
		local xp = definition.minigun.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "minigun_head_shots_"..(i-1) or "minigun_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_minigun_head_shots_"..i.."_hl",
			description_id = "ch_minigun_head_shots",
		 	counter_id = "minigun_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	for i = 1, #definition.minigun.cop_kill do
		local name = "minigun_cop_kill_"..i
		local count = definition.minigun.cop_kill[ i ].count
		local xp = definition.minigun.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "minigun_cop_kill"..(i-1) or "minigun_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_minigun_cop_kill_"..i.."_hl",
		 	description_id = "ch_minigun_cop_kill",
		 	counter_id = "minigun_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end
function ChallengesTweakData:_rpg7_challenges()
	local definition = {}
	definition.rpg7 = {}
	definition.rpg7.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.rpg7.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.rpg7.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.rpg7.vs_the_law do
		local name = "rpg7_vs_the_law_"..i
		local count = definition.rpg7.vs_the_law[ i ].count
		local xp = definition.rpg7.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "rpg7_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_rpg7_vs_the_law_"..i.."_hl",
		 	description_id = "ch_rpg7_vs_the_law",
		 	counter_id = "rpg7_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	--[[for i = 1, #definition.rpg7.head_shots do
		local name = "rpg7_head_shots_"..i
		local count = definition.rpg7.head_shots[ i ].count
		local xp = definition.rpg7.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "rpg7_head_shots_"..(i-1) or "rpg7_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_rpg7_head_shots_"..i.."_hl",
			description_id = "ch_rpg7_head_shots",
		 	counter_id = "rpg7_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end]]--
	for i = 1, #definition.rpg7.cop_kill do
		local name = "rpg7_cop_kill_"..i
		local count = definition.rpg7.cop_kill[ i ].count
		local xp = definition.rpg7.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "rpg7_cop_kill"..(i-1) or "rpg7_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_rpg7_cop_kill_"..i.."_hl",
		 	description_id = "ch_rpg7_cop_kill",
		 	counter_id = "rpg7_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end

function ChallengesTweakData:_flamethrower_challenges()
	local definition = {}
	definition.flamethrower = {}
	definition.flamethrower.vs_the_law = {
		{ count = 50, xp = tiny_xp },
		{ count = 200, xp = small_xp },
		{ count = 400, xp = mid_xp },
		{ count = 600, xp = large_xp },
		{ count = 800, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
		{ count = 5000, xp = large_xp },
	}
	definition.flamethrower.head_shots = {
		{ count = 75, xp = small_xp },
		{ count = 200, xp = mid_xp },
		{ count = 350, xp = large_xp },
		{ count = 500, xp = large_xp },
		{ count = 1000, xp = large_xp },
		{ count = 2000, xp = large_xp },
	}
	definition.flamethrower.cop_kill = {
		{ count = 20, xp = huge_xp },
	}
	for i = 1, #definition.flamethrower.vs_the_law do
		local name = "flamethrower_vs_the_law_"..i
		local count = definition.flamethrower.vs_the_law[ i ].count
		local xp = definition.flamethrower.vs_the_law[ i ].xp
		local challenges = { (i-1) > 0 and "flamethrower_vs_the_law_"..(i-1) or nil }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_flamethrower_vs_the_law_"..i.."_hl",
		 	description_id = "ch_flamethrower_vs_the_law",
		 	counter_id = "flamethrower_law_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
	--[[for i = 1, #definition.flamethrower.head_shots do
		local name = "flamethrower_head_shots_"..i
		local count = definition.flamethrower.head_shots[ i ].count
		local xp = definition.flamethrower.head_shots[ i ].xp
		local challenges = { (i-1) > 0 and "flamethrower_head_shots_"..(i-1) or "flamethrower_vs_the_law_3" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
			title_id = "ch_flamethrower_head_shots_"..i.."_hl",
			description_id = "ch_flamethrower_head_shots",
		 	counter_id = "flamethrower_law_head_shot",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end]]--
	for i = 1, #definition.flamethrower.cop_kill do
		local name = "flamethrower_cop_kill_"..i
		local count = definition.flamethrower.cop_kill[ i ].count
		local xp = definition.flamethrower.cop_kill[ i ].xp
		local challenges = { (i-1) > 0 and "flamethrower_cop_kill"..(i-1) or "flamethrower_vs_the_law_5" }
		local depends_on = { challenges = challenges}
		self.weapon[ name ] = {
		 	title_id = "ch_flamethrower_cop_kill_"..i.."_hl",
		 	description_id = "ch_flamethrower_cop_kill",
		 	counter_id = "flamethrower_cop_kill",
			unlock_level = 0,
			count = count, 
			xp = xp,
			depends_on = depends_on,
		}
	end
end