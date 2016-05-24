if not _G.pdth_hud then
	_G.pdth_hud = ModCore:new(ModPath .. "main_config.xml")
	local self = pdth_hud

	--self.Options = {}

	self.AddonPath = self.ModPath .. "addons/"
	self.ClassPath = self.ModPath .. "Classes/"
	self.HooksPath = self.ModPath .. "Hooks/"
    self.Classes = {
		"Definitions.lua",
        "Constants.lua",
        "PDTHTextures.lua",
        "PDTHEquipment.lua",
		"OptionsCallbacks.lua",
        --"DefaultOptions.lua",
        --"Options.lua",
        "ChallengesManager.lua",
        "ChallengesTweakData.lua",
		"Menu.lua",
		"Hooks.lua",

    }

    self.Hooks = {
        ["lib/units/weapons/newraycastweaponbase"] = "GadgetState.lua",
        ["lib/managers/hud/hudhint"] = "HudHint.lua",
        ["lib/managers/menu/items/menuitemchallenge"] = "CoreItemChallenges.lua",
        ["lib/managers/hud/hudtemp"] = "HudTemp.lua",
        ["lib/managers/hud/hudassaultcorner"] = "HudAssaultCorner.lua",
        ["lib/managers/hud/hudinteraction"] = "HudInteraction.lua",
        ["lib/managers/hudmanager"] = "HudManager.lua",
        ["lib/managers/statisticsmanager"] = "StatsManager.lua",
        ["lib/managers/hudmanagerpd2"] = "HudManagerPD2.lua",
        ["lib/managers/hud/hudteammate"] = "HudTeammate.lua",
        ["lib/managers/hud/hudpresenter"] = "HudPresenter.lua",
        ["lib/tweak_data/tweakdata"] = "TweakData.lua",
		["lib/managers/menu/menucomponentmanager"] = "MenuComponentManager.lua",
		["lib/managers/menu/textboxgui"] = "PortraitPreviewGUI.lua"
    }

	self._post_hooks_path = self.ClassPath .. "PostHooks.lua"

    self.colour_gradings = {
        "color_payday",
        "color_heat",
        "color_nice",
        "color_sin",
        "color_bhd",
        "color_xgen",
        "color_xxxgen",
        "color_matrix",
    }
    self.heist_colour_gradings = {
        "color_main",
        "color_payday",
        "color_heat",
        "color_nice",
        "color_sin",
        "color_bhd",
        "color_xgen",
        "color_xxxgen",
        "color_matrix"
    }

    self.portrait_options = {}

	self.portrait_value_options = {}

    self.bullet_style_options = {
        "off",
        "normal",
        "coloured"
    }

	self.weapon_icon_style_options = {
		"default",
		"coloured"
	}
end

function pdth_hud:_init()
	for p, d in pairs(pdth_hud.Classes) do
		dofile(pdth_hud.ClassPath .. d)
	end
	log("init modules")
	self:init_modules()
	--self:LoadOptions()
	pdth_hud.textures:refresh_portrait_order()
    self:InitConstants()
end

function pdth_hud:LoadAddons()
    local addons = file.GetFiles(self.AddonPath)
    for _, path in pairs(addons) do
        if string.ends(path, "json") then
            local file = io.open(self.AddonPath .. path, "r")
            local file_contents = file:read("*all")
            local data = json.decode( file_contents )
            pdth_hud.textures:ProcessAddon(data, self.portrait_options)
            file:close()
        end
    end


    for i, portait in pairs(self.portrait_options) do
        pdth_hud.portrait_value_options[i] = "portrait_value_" .. i
    end
	local portrait_tbl = {}
	for i, portrait in pairs(self.portrait_options) do
		portrait_tbl[i] = { name = portrait, title_id = "pdth_" .. portrait, default_value = i }
	end

	return portrait_tbl
end

local level_blacklist = {
	"mia2_new",
	"driving_escapes_industry_day",
	"driving_escapes_city_day"
}
function pdth_hud:GetLevels()
	local level_tbl = {}
	for _, level in pairs(tweak_data.levels._level_index) do
		if tweak_data.levels[level] ~= nil and not table.contains(level_blacklist, level) then
			local suffix = ""
            if string.ends(level, "_night") then
                suffix = " Night"
            end
            if string.ends(level, "_day") then
                suffix = " Day"
            end

			local is_current_level = not Global.load_start_menu and Global.game_settings and level == Global.game_settings.level_id
			table.insert(level_tbl, {
				name = level,
				title_id = function() return managers.localization:exists(tweak_data.levels[level].name_id) and managers.localization:text(tweak_data.levels[level].name_id) .. suffix or level end,
				default_value = 1,
				merge_data = is_current_level and {
					row_item_color = Color.yellow,
                    hightlight_color = Color.yellow,
				} or nil
			})
		end
	end

	return level_tbl
end

if not pdth_hud.setup then
	pdth_hud:_init()
	pdth_hud.setup = true
end

if RequiredScript then
	local requiredScript = RequiredScript:lower()
	if pdth_hud.Hooks[requiredScript] then
		dofile( pdth_hud.HooksPath .. pdth_hud.Hooks[requiredScript] )
	end

	dofile(pdth_hud._post_hooks_path)
end
