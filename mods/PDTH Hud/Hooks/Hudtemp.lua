if pdth_hud.loaded_options.Ingame.MainHud and not (Restoration and Restoration.options.restoration_bagpanel_global) then
HUDTemp = HUDTemp or class()
function HUDTemp:_animate_show_bag_panel(bag_panel)
	local w, h = self._bag_panel_w, self._bag_panel_h
	local scx = self._temp_panel:w() / 2
	local ecx = self._temp_panel:w() - w / (not Restoration and 1.365 or 1.2)
	local scy = self._temp_panel:h() / 2
	local ecy = self:_bag_panel_bottom() + 34
	local bottom = bag_panel:bottom()
	local center_y = bag_panel:center_y()
	local bag_text = self._bg_box:child("bag_text")
	if not self.first_placing then
		self._temp_panel:child("throw_instruction"):set_bottom(bag_panel:top() + 60)
		self._temp_panel:child("throw_instruction"):set_right(self._temp_panel:right() - 46)
		self.first_placing = true
	end
	local function open_done()
		bag_text:stop()
		bag_text:set_visible(true)
		bag_text:animate(callback(self, self, "_animate_show_text"))
	end

	self._bg_box:stop()
	self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_center"), nil, w, open_done)
	bag_panel:set_size(w, h)
	bag_panel:set_center_x(scx)
	bag_panel:set_center_y(scy)
	wait(1)
	local TOTAL_T = 0.5
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		bag_panel:set_center_x(math.lerp(scx, ecx, 1 - t / TOTAL_T))
		bag_panel:set_center_y(math.lerp(scy, ecy, 1 - t / TOTAL_T))
	end
	self._temp_panel:child("throw_instruction"):set_visible(true)
	bag_panel:set_size(w, h)
	bag_panel:set_center_x(ecx)
	bag_panel:set_center_y(ecy)
end
end