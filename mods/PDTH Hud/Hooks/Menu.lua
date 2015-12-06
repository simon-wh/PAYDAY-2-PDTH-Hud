local updater = NewsFeedGui.update
function NewsFeedGui:update(t, dt)
	self.active_menu = managers.menu:active_menu().logic:selected_node():parameters().name

	if self.active_menu ~= "main" then	
		pdth_hud.show_thing = false
	else	
		pdth_hud.show_thing = true
	end
	
	if alive(self._PDTHpanel) and not pdth_hud.show_thing then
		self._PDTHpanel:set_visible(false)	
	elseif alive(self._PDTHpanel) then
		self._PDTHpanel:set_visible(true)	
	end
	return updater(self, t, dt)
end

local result_news = NewsFeedGui.news_result
function NewsFeedGui:news_result(success, body)
	pdth_hud:make_version_request(false)
	return result_news(self, success, body)
end

local gui_create = NewsFeedGui._create_gui
function NewsFeedGui:_create_gui()
	self._PDTHpanel = self._ws:panel():panel({
		name = "PDTHPanel",
		w = 175,
		layer = 0,
		h = 44
	})
	local PDTHHUD = self._PDTHpanel:text({
		visible = true,
		rotation = 360,
		name = "PDTHHud",
		text = "PDTH HUD V " .. pdth_hud.VERSION,
		layer = 0,
		font = tweak_data.menu.small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		align = "right",
		halign = "right",
		vertical = "center",
		hvertical = "center",
		color = Color.white
	})
	local w = 192
	local h = 130
	local LBG = self._PDTHpanel:bitmap({
		visible = true,
		name = "LBGLOGO",
		texture = "guis/textures/pd2/weapons",
		layer = 0,
		blend_mode = "normal",
		w = w / 3.9,
		h = h / 3.9
	})
	LBG:set_bottom(self._PDTHpanel:bottom() / 1.15)
	self._PDTHpanel:set_right(self._PDTHpanel:parent():w() + 0.5)
	self._PDTHpanel:set_bottom(self._PDTHpanel:parent():h() - 6)
	return gui_create(self)
end

local move_mouse = NewsFeedGui.mouse_moved
function NewsFeedGui:mouse_moved(x, y)
	local LBG = self._PDTHpanel:child("LBGLOGO")
	local PDTHHUD = self._PDTHpanel:child("PDTHHud")
	local inside = self._panel:inside(x, y)
	local insidelogo = LBG:inside(x, y)
	local insidetext = PDTHHUD:inside(x, y)
	self._mouse_over = inside
	if insidelogo and pdth_hud.show_thing then
		return insidelogo, insidelogo and "link"
	elseif insidetext and pdth_hud.show_thing then
		return insidetext, insidetext and "link"
	else
		return move_mouse(self, x, y)
	end
end

local mouse_press = NewsFeedGui.mouse_pressed
function NewsFeedGui:mouse_pressed(button, x, y)
	local LBG = self._PDTHpanel:child("LBGLOGO")
	local PDTHHUD = self._PDTHpanel:child("PDTHHud")
	
	if button == Idstring("0") and LBG:inside(x, y) and pdth_hud.show_thing then
		self:Dialog()
		return true
	end
	
	if button == Idstring("0") and PDTHHUD:inside(x, y) and pdth_hud.show_thing then
		self:TextDialog()
		return true
	end
	return mouse_press(self, button, x, y)
end

function NewsFeedGui:Dialog()
	local dialog_data = {}
	dialog_data.title = "Last Bullet"
	dialog_data.text = "To see more mods visit our Website!"
	local no_button = {}
	no_button.text = "Ok"
	no_button.callback_func = callback(self, self, "_ok_button")
	local website_button = {}
	website_button.text = "Visit Website"
	website_button.callback_func = callback(self, self, "_open_website")
	local group_button = {}
	group_button.text = "Visit Steam Group"
	group_button.callback_func = callback(self, self, "_open_group")
	dialog_data.button_list = {website_button, group_button, no_button}
	dialog_data.title_font = tweak_data.menu.small_font
	dialog_data.title_font_size = tweak_data.menu.pd2_medium_font_size
	dialog_data.font = tweak_data.menu.small_font
	dialog_data.font_size = tweak_data.menu.pd2_small_font_size
	dialog_data.texture = "guis/textures/pd2/weapons"
	dialog_data.text_blend_mode = "add"
	--dialog_data.use_text_formating = true
	dialog_data.w = 600
	--dialog_data.h = 532
	dialog_data.image_w = 192 / 2.8
	dialog_data.image_h = 130 / 2.8
	dialog_data.image_valign = "top"
	managers.system_menu:show_new_unlock(dialog_data)
end

function NewsFeedGui:_ok_button()
end

function NewsFeedGui:_open_website()
	Steam:overlay_activate("url", pdth_hud.LOGO_LINK)
end

function NewsFeedGui:_open_group()
	Steam:overlay_activate("url", pdth_hud.STEAM_GROUP_LINK)
end

function NewsFeedGui:TextDialog()
	local dialog_data = {}
	dialog_data.title = "PDTH HUD"
	dialog_data.text = " VERSION: V" .. pdth_hud.VERSION .. "\n Created By: LASTBULLET_GREAT BIG BUSHY BEARD" .. "\n " .. "\n Special Credits:" .. "\n Tatsuto" .. "\n AJValentine" .. "\n Zeroalias" .. "\n Peasemaker" .. "\n SaryDragon" .. "\n Dougley" .. "\n and all the testers :D"
	dialog_data.w = 600
	dialog_data.h = 600
	local no_button = {}
	no_button.text = "Ok"
	no_button.callback_func = callback(self, self, "TEXT_ok_button")
	local website_button = {}
	website_button.text = "Visit Download Page"
	website_button.callback_func = callback(self, self, "TEXT_open_website")
	local test_button = {}
	test_button.text = "Check for updates"
	test_button.callback_func = callback(self, self, "test_button")
	dialog_data.button_list = {website_button, test_button, no_button}
	managers.system_menu:show_new_unlock(dialog_data)
end

function NewsFeedGui:TEXT_ok_button()
end

function NewsFeedGui:TEXT_open_website()
	Steam:overlay_activate("url", pdth_hud.TEXT_LINK)
end

function NewsFeedGui:test_button()
	pdth_hud:make_version_request(true)
end

local closer = NewsFeedGui.close
function NewsFeedGui:close()
	if alive(self._PDTHpanel) then
		self._ws:panel():remove(self._PDTHpanel)
	end
	return closer(self)
end