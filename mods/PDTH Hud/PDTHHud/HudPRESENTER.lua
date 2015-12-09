if pdth_hud.loaded_options.Ingame.Objectives then

HUDPresenter = HUDPresenter or class()
function HUDPresenter:init(hud)
	local full_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	self._full_hud_panel = full_hud.panel
	--self._hud_panel = hud.panel
	self._hud_panel = managers.hud._fullscreen_workspace:panel():gui(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2, {})
	if self._hud_panel:child("present_panel") then
		self._hud_panel:remove(self._hud_panel:child("present_panel"))
	end
	local h = 68
	local w = 450
	local x = math.round(self._hud_panel:w() / 2 - w / 2)
	local y = math.round(self._hud_panel:h() / 12)
	local present_panel = self._hud_panel:panel({
		visible = false,
		name = "present_panel",
		layer = 10,
		w = self._hud_panel:w(),
		h = 38 * pdth_hud.loaded_options.Ingame.Hud_scale,
		--x = x,
		y = y
	})
	present_panel:set_center_y(self._hud_panel:center_y())

	local background = present_panel:bitmap({
		name = "background",
		visible = true,
		--texture = "guis/textures/alphawipe_test",
		layer = 0,
		color = Color(0.5, 0, 0, 0),
		blend_mode = "normal",
		w = present_panel:w(),
		h = 38 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	local title = present_panel:text({
		name = "title",
		text = "TITLE",
		vertical = "top",
		valign = "top",
		layer = 1,
		x = 80,
		color = Color(1, 1, 0.65882355, 0),
		font = tweak_data.menu.small_font_noshadow,
		font_size = 12 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	local _, _, _, h = title:text_rect()
	local text = present_panel:text({
		name = "text",
		text = "TEXT",
		layer = 1,
		x = 80,
		color = Color.white,
		font = tweak_data.menu.small_font,
		font_size = 20 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	text:set_bottom(title:bottom() + (11 * pdth_hud.loaded_options.Ingame.Hud_scale))
	local _, _, _, h = text:text_rect()
	--managers.hud:make_fine_text(title)
	--managers.hud:make_fine_text(text)
end


function HUDPresenter:_present_information(params)
	local present_panel = self._hud_panel:child("present_panel")
	local title = present_panel:child("title")
	local text = present_panel:child("text")
	local background = present_panel:child("background")
	title:set_text(utf8.to_upper(params.title or "ERROR"))
	text:set_text(utf8.to_upper(params.text))
	self._presenting = true

	if not self._hud_panel:child("test_icon") then
	
	end
	if params.icon then
	end
	if params.event then
		managers.hud._sound_source:post_event(params.event)
	end
	present_panel:animate(callback(self, self, "_animate_present_information"), {
		done_cb = callback(self, self, "_present_done"),
		seconds = params.time or 4,
		use_icon = params.icon
	})
	--self:_present_done()
end

function HUDPresenter:_animate_present_information(present_panel, params)
	--local present_panel = self._hud_panel:child("present_panel")
	local title = present_panel:child("title")
	local text = present_panel:child("text")
	local background = present_panel:child("background")
	present_panel:set_visible(true)
	present_panel:set_alpha(1)
	local function open_done()
		--title:set_visible(true)
		--text:set_visible(true)
		present_panel:set_visible(true)
		--background:set_visible(true)
		title:animate(callback(self, self, "_animate_show_text"), text, background)
		wait(params.seconds)
		title:animate(callback(self, self, "_animate_hide_text"), text, background)
		wait(0.5)
		local function close_done()
			present_panel:set_visible(false)
			--background:set_visible(false)
			self:_present_done()
		end

		present_panel:animate(close_done)
	end

	present_panel:stop()
	present_panel:animate(open_done)
end

function HUDPresenter:_animate_show_text(title, text, background)
	local TOTAL_T = 0
	local t = TOTAL_T
	while t < 1 do
		
		local dt = coroutine.yield() * 4
		t = t + dt
		--local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
		local alpha = t
		title:set_alpha(alpha)
		text:set_alpha(alpha)
		background:set_alpha(alpha)
		--wait(0.0001)
	end
	title:set_alpha(1)
	text:set_alpha(1)
	background:set_alpha(1)
end

function HUDPresenter:_animate_hide_text(title, text, background)
	local TOTAL_T = 1
	local t = TOTAL_T
	while t > 0 do
		
		local dt = coroutine.yield() * 4
		t = t - dt
		--local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
		local alpha = t
		title:set_alpha(alpha)
		text:set_alpha(alpha)
		background:set_alpha(alpha)
		--wait(0.0001)
	end
	
end

end