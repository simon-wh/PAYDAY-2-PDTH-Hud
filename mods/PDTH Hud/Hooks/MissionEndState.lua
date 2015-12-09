
--LightFX stuff
local lightfx_keyframes = {
    [0] = Color(1, 0, 0, 1),
    [1] = Color(0, 0, 0, 1),
    [2] = Color(1, 0, 0, 1),
    [3] = Color(0, 0, 0, 1),
    [4] = Color(0, 0, 0, 1),
    [5] = Color(1, 1, 0, 0),
    [6] = Color(0, 1, 0, 0),
    [7] = Color(1, 1, 0, 0),
    [8] = Color(0, 1, 0, 0),
    [9] = Color(0, 1, 0, 0),
}

MissionEndState._update = MissionEndState.update
MissionEndState.update = function(self, t, dt)
    MissionEndState._update(self, t, dt)
    
    if BetterLightFX and self._type == "gameover" then
        BetterLightFX:SetCurrentState(nil)
        BetterLightFX:SetCurrentState("EndLoss")
        
        local timestamp = math.floor((t * 8) % 10) --Every 0.125 seconds
        local time_color = lightfx_keyframes[timestamp]
        
        if time_color then
            BetterLightFX:SetColor(time_color.red, time_color.green, time_color.blue, time_color.alpha, "EndLoss" )
        end
    end
    
end

MissionEndState.at_exit = function(self, next_state)
	managers.briefing:stop_event(true)
	managers.hud:hide(self.GUI_ENDSCREEN)
	managers.menu_component:hide_game_chat_gui()
	self:_clear_controller()
    
    if BetterLightFX then
        BetterLightFX:SetCurrentState(nil)
        BetterLightFX:SetColor(0, 0, 0, 0, nil)
    end
    
	if not self._debug_continue and not Application:editor() then
		managers.savefile:save_progress()
		if Network:multiplayer() then
			self:_shut_down_network()
		end
		local player = managers.player:player_unit()
		if player then
			player:camera():remove_sound_listener()
		end
		if self._sound_listener then
			self._sound_listener:delete()
			self._sound_listener = nil
		end
		if next_state:name() ~= "disconnected" then
			self:_load_start_menu(next_state)
		end
	else
		self._debug_continue = nil
		managers.groupai:state():set_AI_enabled(true)
		local player = managers.player:player_unit()
	if player then
		end
		player:character_damage():set_invulnerable(false)
	end
	managers.menu:close_menu("mission_end_menu")
end
