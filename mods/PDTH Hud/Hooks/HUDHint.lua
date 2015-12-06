if pdth_hud.loaded_options.Ingame.Interaction and not (Restoration and Restoration.options.restoration_hud_global) then
HUDHint = HUDHint or class()
function HUDHint:init(hud)
	self._hud_panel = hud.panel
	if self._hud_panel:child("hint_panel") then
		self._hud_panel:remove(self._hud_panel:child("hint_panel"))
	end
	self._hint_panel = self._hud_panel:panel({
		visible = false,
		name = "hint_panel",
		h = 30,
		y = 0,
		valign = {0.3125, 0},
		layer = 3
	})
	local y = self._hud_panel:h() / 3.8
	self._hint_panel:set_center_y(y)
	local marker = self._hint_panel:rect({
		name = "marker",
		visible = true,
		color = Color.white:with_alpha(0.75),
		layer = 2,
		h = 30,
		w = 12
	})
	marker:set_center_y(self._hint_panel:h() / 2)
	local clip_panel = self._hint_panel:panel({name = "clip_panel"})
	clip_panel:rect({
		name = "bg",
		visible = true,
		color = Color.black:with_alpha(0.25)
	})
	clip_panel:text({
		name = "hint_text",
		text = "",
		font_size = 28,
		font = tweak_data.hud.medium_font_noshadow,
		color = Color.white,
		align = "center",
		vertical = "center",
		layer = 1,
		wrap = false,
		word_wrap = false
	})
end
end