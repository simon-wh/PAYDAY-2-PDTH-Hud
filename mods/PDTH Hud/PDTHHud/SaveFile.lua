--[[function SavefileManager._save_cache(slot)
	cat_print("savefile_manager", "[SavefileManager] Saves slot \"" .. tostring(slot) .. "\" to cache.")
	local is_setting_slot = slot == self.SETTING_SLOT
	if is_setting_slot then
		self:_set_cache(slot, nil)
	else
		local old_slot = Global.savefile_manager.current_game_cache_slot
		if old_slot then
			self:_set_cache(old_slot, nil)
		end
		self:_set_current_game_cache_slot(slot)
	end
	local cache = {
		version = SavefileManager.VERSION,
		version_name = SavefileManager.VERSION_NAME
	}
	if is_setting_slot then
		managers.user:save(cache)
		managers.music:save_settings(cache)
	else
		managers.player:save(cache)
		managers.experience:save(cache)
		managers.upgrades:save(cache)
		managers.money:save(cache)
		managers.statistics:save(cache)
		managers.skilltree:save(cache)
		managers.blackmarket:save(cache)
		--managers.challenges:save(cache)
		managers.mission:save_job_values(cache)
		managers.job:save(cache)
		managers.dlc:save(cache)
		managers.infamy:save(cache)
		managers.features:save(cache)
		managers.gage_assignment:save(cache)
		managers.music:save_profile(cache)
	end
	if SystemInfo:platform() == Idstring("WIN32") then
		cache.user_id = self._USER_ID_OVERRRIDE or Steam:userid()
		cat_print("savefile_manager", "[SavefileManager:_save_cache] user_id:", cache.user_id)
	end
	self:_set_cache(slot, cache)
	self:_set_synched_cache(slot, false)
end

function SavefileManager:_load_cache(slot)
	cat_print("savefile_manager", "[SavefileManager] Loads cached slot \"" .. tostring(slot) .. "\".")
	local meta_data = self:_meta_data(slot)
	local cache = meta_data.cache
	local is_setting_slot = slot == self.SETTING_SLOT
	if not is_setting_slot then
		self:_set_current_game_cache_slot(slot)
	end
	if cache then
		local version = cache.version or 0
		local version_name = cache.version_name
		if version > SavefileManager.VERSION then
			return version_name
		end
		if is_setting_slot then
			managers.user:load(cache, version)
			managers.music:load_settings(cache, version)
			self:_set_setting_changed(false)
		else
			managers.blackmarket:load(cache, version)
			managers.upgrades:load(cache, version)
			managers.experience:load(cache, version)
			managers.player:load(cache, version)
			managers.money:load(cache, version)
			--managers.challenges:load(cache, version)
			managers.statistics:load(cache, version)
			managers.skilltree:load(cache, version)
			managers.mission:load_job_values(cache, version)
			managers.job:load(cache, version)
			managers.dlc:load(cache, version)
			managers.infamy:load(cache, version)
			managers.features:load(cache, version)
			managers.gage_assignment:load(cache, version)
			managers.music:load_profile(cache, version)
		end
	else
		Application:error("[SavefileManager] Unable to load savefile from slot \"" .. tostring(slot) .. "\".")
		Application:stack_dump("error")
	end
end]]--
