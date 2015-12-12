if pdth_hud.loaded_options.Ingame.Assault and not (Restoration and Restoration.options.restoration_assault_global) then
HUDAssaultCorner = HUDAssaultCorner or class()
function HUDAssaultCorner:init(hud, full_hud)
	self._hud_panel = hud.panel
	self._full_hud_panel = full_hud.panel
	local size = 200
    self._assault_color = Color.red / 2
	self._vip_assault_color = Color(1, 1, 1, 0)
    --LightFX
    self._assault_color_fx = Color.red
    self._vip_assault_color_fx = Color(1, 1, 1, 0)
    self._fx_color =Color.red
    
    self._is_casing_mode = false
    
	local assault_panel = self._hud_panel:panel({
		visible = false,
		name = "assault_panel",
		w = 100 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 100 * pdth_hud.loaded_options.Ingame.Hud_scale,
		layer = 4
	})
	assault_panel:set_bottom(self._hud_panel:bottom() / 1)
	assault_panel:set_center_x(self._hud_panel:center_x())
	local icon_assaultbox = assault_panel:bitmap({
		name = "icon_assaultbox",
		blend_mode = "normal",
		visible = true,
		layer = 0,
		texture = "guis/textures/hud_icons",
		texture_rect = {
			276,
			192,
			108,
			96
		},
		x = 7 * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 6 * pdth_hud.loaded_options.Ingame.Hud_scale,
		w = (108 / 1.25) * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = (96 / 1.25) * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	--icon_assaultbox:set_center_x(icon_assaultbox:parent():w() / 1.99)
	--icon_assaultbox:set_bottom(assault_panel:bottom())
	local control_assault_title = assault_panel:text({
		name = "control_assault_title",
		text = managers.localization:text("menu_assault"),
		blend_mode = "normal",
		layer = 1,
		x = 12.5 * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 42 * pdth_hud.loaded_options.Ingame.Hud_scale,
		color = Color.red / 2,
		font_size = 22 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.menu.small_font,
		visible = true
	})
	local hostages_panel = self._hud_panel:panel({
		name = "hostages_panel",
		w = 75 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 30 * pdth_hud.loaded_options.Ingame.Hud_scale,
		layer = 5
	})
	hostages_panel:set_bottom(self._hud_panel:bottom())
	hostages_panel:set_center_x(self._hud_panel:center_x())
	if self._hud_panel:child("point_of_no_return_panel") then
		self._hud_panel:remove(self._hud_panel:child("point_of_no_return_panel"))
	end
	local size = 300
	local point_of_no_return_panel = self._hud_panel:panel({
		visible = false,
		name = "point_of_no_return_panel",
		w = size * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 40 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0, --(self._hud_panel:w() - size - 15) * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 0 --20 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	point_of_no_return_panel:set_right(self._hud_panel:right())
	point_of_no_return_panel:set_top(self._hud_panel:top())
	self._noreturn_color = Color(1, 1, 0, 0)
	local icon_noreturnbox = point_of_no_return_panel:bitmap({
		halign = "right",
		valign = "top",
		color = self._noreturn_color,
		name = "icon_noreturnbox",
		blend_mode = "normal",
		visible = false,
		layer = 0,
		texture = "guis/textures/pd2/hud_icon_noreturnbox",
		x = 0,
		y = 0,
		w = 24 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 24 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	icon_noreturnbox:set_right(icon_noreturnbox:parent():w())
	self._noreturn_bg_box = HUDBGBox_create(point_of_no_return_panel, {
		w = 242 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 48 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 0,
		y = 0,
		visible = false
	}, {
		--color = self._noreturn_color,
		blend_mode = "remove"
	})
	self._noreturn_bg_box:set_right(icon_noreturnbox:left() + 400)
	local w = point_of_no_return_panel:w()
	local size = 200 - tweak_data.hud.location_font_size
	local point_of_no_return_text = point_of_no_return_panel:text({
		name = "point_of_no_return_text",
		text = "",
		blend_mode = "normal",
		layer = 1,
		align = "right",
		halign = "right",
		vertical = "top",
		hvertical = "top",
		x = 0,
		y = 0,
		color = self._noreturn_color,
		font_size = (tweak_data.hud_corner.noreturn_size - 5) * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.menu.small_font
	})
	point_of_no_return_text:set_text(utf8.to_upper("TIME TO ESCAPE", {time = ""}))
	--point_of_no_return_text:set_size(self._noreturn_bg_box:w() * pdth_hud.loaded_options.Ingame.Hud_scale, self._noreturn_bg_box:h() * pdth_hud.loaded_options.Ingame.Hud_scale)
	local point_of_no_return_timer = point_of_no_return_panel:text({
		name = "point_of_no_return_timer",
		text = "",
		blend_mode = "normal",
		layer = 1,
		align = "right",
		halign = "right",
		vertical = "bottom",
		hvertical = "bottom",
		x = 0,
		y = 0,
		color = self._noreturn_color,
		font_size = tweak_data.hud_corner.noreturn_size * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.menu.small_font
	})
	local _, _, w, h = point_of_no_return_timer:text_rect()
	--[[point_of_no_return_timer:set_size(56 * pdth_hud.loaded_options.Ingame.Hud_scale, self._noreturn_bg_box:h() * pdth_hud.loaded_options.Ingame.Hud_scale)
	point_of_no_return_timer:set_right((point_of_no_return_timer:parent():w() - 10) * pdth_hud.loaded_options.Ingame.Hud_scale)
	point_of_no_return_timer:set_bottom((point_of_no_return_timer:parent():h() + 10) * pdth_hud.loaded_options.Ingame.Hud_scale)
	point_of_no_return_text:set_right((math.round(point_of_no_return_timer:left()) + 50) * pdth_hud.loaded_options.Ingame.Hud_scale)
	point_of_no_return_text:set_bottom((point_of_no_return_timer:parent():h() - 11) * pdth_hud.loaded_options.Ingame.Hud_scale)]]--
	
	
	
	if self._hud_panel:child("casing_panel") then
		self._hud_panel:remove(self._hud_panel:child("casing_panel"))
	end
	local size = 300
	local casing_panel = self._hud_panel:panel({
		visible = false,
		name = "casing_panel",
		w = 100 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 100 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	casing_panel:set_center_x(self._hud_panel:center_x())
	casing_panel:set_bottom(self._hud_panel:bottom())
	--self._casing_color = Color.white
	local icon_casingbox = casing_panel:bitmap({
		align = "center",
		halign = "center",
		vertical = "top",
		hvertical = "top",
		--color = self._casing_color,
		name = "icon_casingbox",
		blend_mode = "add",
		visible = true,
		layer = 0,
		texture = "guis/textures/pd2/icon_detection",
		x = 0,
		y = 0,
		w = 100 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 100 * pdth_hud.loaded_options.Ingame.Hud_scale
	})
	icon_casingbox:set_right(icon_casingbox:parent():w())
	self._casing_bg_box = HUDBGBox_create(casing_panel, {
		w = 242 * pdth_hud.loaded_options.Ingame.Hud_scale,
		h = 38 * pdth_hud.loaded_options.Ingame.Hud_scale,
		x = 900 * pdth_hud.loaded_options.Ingame.Hud_scale,
		y = 900 * pdth_hud.loaded_options.Ingame.Hud_scale,
		visible = false
	}, {
		color = self._casing_color,
		blend_mode = "add"
	})
	--self._casing_bg_box:set_right(icon_casingbox:left() - 3)
	--[[local w = casing_panel:w()
	local size = 200 - tweak_data.hud.location_font_size
	casing_panel:panel({
		name = "text_panel",
		layer = 1,
		
	})]]--
	
	
	
	local num_hostages = self._hud_panel:text({
		name = "num_hostages",
		text = managers.localization:text("pdth_hud_hostages") .. " 0",
		blend_mode = "normal",
		align = "center",
		halign = "center",
		vertical = "bottom",
		hvertical = "bottom",
		layer = 2,
		--x = 4,
		--y = 0,
		color = Color.white ,
		font_size = 13 * pdth_hud.loaded_options.Ingame.Hud_scale,
		font = tweak_data.menu.small_font_noshadow
	})
	--num_hostages:set_center_y(num_hostages:parent():h() / 2)
	--num_hostages:set_x(77)
	--num_hostages:set_bottom(assault_panel:bottom() / 2)
	--num_hostages:set_center_x(assault_panel:center_x())	
end

function HUDAssaultCorner:sync_start_assault(data)
	if self._point_of_no_return or self._casing then
		return
	end
	--self._start_assault_after_hostage_offset = true
    self:_start_assault()
	self:_set_hostage_offseted(true)
end

function HUDAssaultCorner:set_buff_enabled(buff_name, enabled)

end

function HUDAssaultCorner:_start_assault(text_list)
    log("start assault")
	--local putang = 5
	--text_list = text_list or {""}
	local assault_panel = self._hud_panel:child("assault_panel")
	local control_assault_title = assault_panel:child("control_assault_title")
	local icon_assaultbox = assault_panel:child("icon_assaultbox")
	local num_hostages = self._hud_panel:child("num_hostages")
	local casing_panel = self._hud_panel:child("casing_panel")
	self._assault = true
	--icon_assaultbox:set_visible(true)
	assault_panel:set_visible(true)
	num_hostages:set_alpha(0.5)
	--icon_assaultbox:animate(callback(self, self, ""))
	--control_assault_title:set_visible(true)
	--control_assault_title:animate(callback(self, self, "_animate_show_texts"))
	--icon_assaultbox:animate(callback(self, self, "_animate_assault"))
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	casing_panel:set_visible(false)
    self._is_casing_mode = false
    icon_assaultbox:set_color(self._assault_color)
    control_assault_title:set_color(self._assault_color)
	icon_assaultbox:animate(callback(self, self, "flash_assault_title"))
	--control_assault_title:animate(callback(self, self, "flash_assault_title"))
	
end

function HUDAssaultCorner:sync_set_assault_mode(mode)
	if self._assault_mode == mode then
		return
	end
	self._assault_mode = mode
	local color = self._assault_color
    self._fx_color = self._assault_color_fx
	if mode == "phalanx" then
		color = self._vip_assault_color
        self._fx_color = self._vip_assault_color_fx
	end
	self._current_assault_color = color
	--self._bg_box:child("left_top"):set_color(color)
	--self._bg_box:child("left_bottom"):set_color(color)
	--self._bg_box:child("right_top"):set_color(color)
	--self._bg_box:child("right_bottom"):set_color(color)
	--self:_set_text_list(self:_get_assault_strings())
	local assault_panel = self._hud_panel:child("assault_panel")
	local control_assault_title = assault_panel:child("control_assault_title")
	local icon_assaultbox = assault_panel:child("icon_assaultbox")
	local num_hostages = self._hud_panel:child("num_hostages")
	local casing_panel = self._hud_panel:child("casing_panel")
	--local image = mode == "phalanx" and "guis/textures/pd2/hud_icon_padlockbox" or "guis/textures/pd2/hud_icon_assaultbox"
	--icon_assaultbox:set_image(image)
	icon_assaultbox:set_color(color)
	control_assault_title:set_color(color)
end

function HUDAssaultCorner:_end_assault()
	local assault_panel = self._hud_panel:child("assault_panel")
	local control_assault_title = assault_panel:child("control_assault_title")
	local icon_assaultbox = assault_panel:child("icon_assaultbox")
	local num_hostages = self._hud_panel:child("num_hostages")
	num_hostages:set_alpha(1)
	if not self._assault then
		do return end
	end
	self._assault = false
	local function close_done()
		local icon_assaultbox = self._hud_panel:child("assault_panel"):child("icon_assaultbox")
		icon_assaultbox:stop()
		icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))
	end
    
	--control_assault_title:set_visible(false)
	control_assault_title:stop()
	--icon_assaultbox:set_visible(false)
	assault_panel:set_visible(false)
	icon_assaultbox:stop()
end
	
function HUDAssaultCorner:set_control_info(data)
	local hostages_panel = self._hud_panel:child("hostages_panel")
	local num_hostages = self._hud_panel:child("num_hostages")
	num_hostages:set_text(managers.localization:text("pdth_hud_hostages") .. " " .. data.nr_hostages)
	--local bg = self._hostages_bg_box:child("bg")
	--bg:stop()
end

function HUDAssaultCorner:_hide_hostages()

end

function HUDAssaultCorner:show_casing()
	local delay_time = self._assault and 1.2 or 0
	self:_end_assault()
	local casing_panel = self._hud_panel:child("casing_panel")
	--[[local text_panel = casing_panel:child("text_panel")
	text_panel:script().text_list = {}
	self._casing_bg_box:script().text_list = {}
	for _, text_id in ipairs({
		"hud_casing_mode_ticker",
		"hud_assault_end_line",
		"hud_casing_mode_ticker",
		"hud_assault_end_line"
	}) do
		table.insert(text_panel:script().text_list, text_id)
		table.insert(self._casing_bg_box:script().text_list, text_id)
	end
	if self._casing_bg_box:child("text_panel") then
		self._casing_bg_box:child("text_panel"):stop()
		self._casing_bg_box:child("text_panel"):clear()
	else
		self._casing_bg_box:panel({name = "text_panel"})
	end
	self._casing_bg_box:child("bg"):stop()]]--
	casing_panel:stop()
	casing_panel:animate(callback(self, self, "_animate_show_casing"), delay_time)
	--casing_panel:set_visible(true)
	self._casing = true
end

function HUDAssaultCorner:_animate_show_casing(casing_panel, delay_time)
	local icon_casingbox = casing_panel:child("icon_casingbox")
	wait(delay_time)
	casing_panel:set_visible(true)
    self._is_casing_mode = true
	icon_casingbox:stop()
	icon_casingbox:animate(callback(self, self, "_show_icon_assaultbox"))
	local open_done = function()
	end

	self._casing_bg_box:stop()
	self._casing_bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_left"), 0.75, 242, open_done, {
		attention_color = self._casing_color,
		attention_forever = true
	})
	--[[local text_panel = self._casing_bg_box:child("text_panel")
	text_panel:stop()
	text_panel:animate(callback(self, self, "_animate_text"), self._casing_bg_box, Color.white)]]--
end

function HUDAssaultCorner:_animate_text(text_panel, bg_box, color, color_function)

end

function HUDAssaultCorner:_show_icon_assaultbox(icon_assaultbox)
	local TOTAL_T = 2
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs((math.sin(t * 360 * 2))))
		icon_assaultbox:set_alpha(alpha)
	end
	icon_assaultbox:set_alpha(1)
	icon_assaultbox:animate(callback(self, self, "flash_assault_title"))
end

function HUDAssaultCorner:_hide_icon_assaultbox(icon_assaultbox)
	local TOTAL_T = 1
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs((math.cos(t * 360 * 2))))
		icon_assaultbox:set_alpha(alpha)
	end
	icon_assaultbox:set_alpha(0)
    
	self:_show_hostages()
	icon_assaultbox:stop()
end

function HUDAssaultCorner:show_point_of_no_return_timer()
	local delay_time = self._assault and 1.2 or 0
	--self:_end_assault()
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	--self._hud_panel:child("hostages_panel"):set_visible(false)
	point_of_no_return_panel:stop()
	point_of_no_return_panel:animate(callback(self, self, "_animate_show_noreturn"), delay_time)
	self._point_of_no_return = true
end

function HUDAssaultCorner:_animate_show_noreturn(point_of_no_return_panel, delay_time)
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	local icon_noreturnbox = point_of_no_return_panel:child("icon_noreturnbox")
	local point_of_no_return_text = point_of_no_return_panel:child("point_of_no_return_text")
	point_of_no_return_text:set_visible(false)
	local point_of_no_return_timer = point_of_no_return_panel:child("point_of_no_return_timer")
	point_of_no_return_timer:set_visible(false)
	wait(delay_time)
	point_of_no_return_panel:set_visible(true)
    self._PoNR_flashing = true
	icon_noreturnbox:stop()
	icon_noreturnbox:animate(callback(self, self, "_show_icon_assaultbox"))
	local function open_done()
		point_of_no_return_text:animate(callback(self, self, "_animate_show_texts"), {point_of_no_return_text, point_of_no_return_timer})
	end
	self._noreturn_bg_box:stop()
	self._noreturn_bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_left"), 0.75, 242, open_done, {
		attention_color = self._casing_color,
		attention_forever = true
	})
	self._noreturn_bg_box:set_visible(false)
end

function HUDAssaultCorner:feed_point_of_no_return_timer(time, is_inside)
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	time = math.floor(time)
	local minutes = math.floor(time / 60)
	local seconds = math.round(time - minutes * 60)
	local text = (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)
	point_of_no_return_panel:child("point_of_no_return_timer"):set_text(text)
end

function HUDAssaultCorner:flash_point_of_no_return_timer(beep)
    self._PoNR_flashing = true
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	local function flash_timer(o)
		local t = 0
		while t < 0.5 do
			t = t + coroutine.yield()
			local n = 1 - math.sin(t * 180)
			local r = math.lerp(1 or self._point_of_no_return_color.r, 1, n)
			local g = math.lerp(0 or self._point_of_no_return_color.g, 0.8, n)
			local b = math.lerp(0 or self._point_of_no_return_color.b, 0.2, n)
			o:set_color(Color(r, g, b))
            
            if BetterLightFX then
                BetterLightFX:StartEvent("PointOfNoReturn")
                BetterLightFX:SetColor(r, g, b, 1, "PointOfNoReturn")
            end
            
			o:set_font_size(math.lerp(tweak_data.hud_corner.noreturn_size * pdth_hud.loaded_options.Ingame.Hud_scale , (tweak_data.hud_corner.noreturn_size * pdth_hud.loaded_options.Ingame.Hud_scale) * 1.25, n))
		end
        if BetterLightFX then
            BetterLightFX:EndEvent("PointOfNoReturn")
        end
	end

	local point_of_no_return_timer = point_of_no_return_panel:child("point_of_no_return_timer")
	point_of_no_return_timer:animate(flash_timer)
end


function HUDAssaultCorner:flash_assault_title(o)
    
    log("Assault Fashing Started")
    local assault_panel = nil
    local control_assault_title = nil
    
    assault_panel = self._hud_panel:child("assault_panel")
    if assault_panel then
        control_assault_title = assault_panel:child("control_assault_title")
    end
    local current_fx_alpha = 255
    
	while true do
        local alpha_d = 0.5 + (math.sin( Application:time()*750 )+1)/4  
        local new_fx = math.floor((alpha_d) * 255)
		o:set_color( o:color():with_alpha( alpha_d ) )
        if control_assault_title then
            control_assault_title:set_color( o:color():with_alpha( alpha_d ) )
        end
        
        if BetterLightFX and self._assault then
            BetterLightFX:StartEvent("AssaultIndicator")
            BetterLightFX:SetColor(self._fx_color.red, self._fx_color.green, self._fx_color.blue, current_fx_alpha ,"AssaultIndicator")
        end
        
        current_fx_alpha = new_fx
		coroutine.yield()
        --wait(0.3)
	end
end
  	
function HUDAssaultCorner:flash_assault_rect(o)
	while true do
		local r = 0.5 + (math.sin( Application:time()*750 )+1)/4
		o:set_color( Color( 0.75, r, 0, 0 ) )
		coroutine.yield()
	end
end
end

