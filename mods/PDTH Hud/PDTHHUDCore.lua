if not _G.pdth_hud then
	_G.pdth_hud = {}
	local self = pdth_hud
    self.name = "PDTHHudReborn"
	self.Options = {}

	self.ModPath = ModPath
	self.AddonPath = self.ModPath .. "addons/"
	self.ClassPath = self.ModPath .. "Classes/"
	self.HooksPath = self.ModPath .. "Hooks/"
	self.SavePath = SavePath
    self.Classes = {
        "Constants.lua",
        "PDTHTextures.lua",
        "PDTHEquipment.lua",
        "DefaultOptions.lua",
        "Options.lua",
        "ChallengesManager.lua",
        "ChallengesTweakData.lua",
		"Menu.lua",
		"Hooks.lua"
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
        ["lib/tweak_data/tweakdata"] = "TweakData.lua"
    }

	self._post_hooks_path = self.ClassPath .. "PostHooks.lua"

    self.colour_gradings = {
        [1] = "color_payday",
        [2] = "color_heat",
        [3] = "color_nice",
        [4] = "color_sin",
        [5] = "color_bhd",
        [6] = "color_xgen",
        [7] = "color_xxxgen",
        [8] = "color_matrix",
    }
    self.heist_colour_gradings = {
        [1] = "color_main",
        [2] = "color_payday",
        [3] = "color_heat",
        [4] = "color_nice",
        [5] = "color_sin",
        [6] = "color_bhd",
        [7] = "color_xgen",
        [8] = "color_xxxgen",
        [9] = "color_matrix",
    }

    self.portrait_options = {}

    self.bullet_style_options = {
        [1] = "off",
        [2] = "normal",
        [3] = "coloured"
    }
end

function pdth_hud:_init()
	for p, d in pairs(pdth_hud.Classes) do
		dofile(pdth_hud.ClassPath .. d)
	end
	self:LoadOptions()
    self:InitConstants()
	self:LoadAddons()
end

function pdth_hud:LoadAddons()
    local addons = file.GetFiles(self.AddonPath)
    for _, path in pairs(addons) do
        if string.ends(path, "json") then
            local file = io.open(self.AddonPath .. path, "r")
            local file_contents = file:read("*all")
            local data = json.decode( file_contents )
            pdth_hud.textures:ProcessAddon(data)
            file:close()
        end
    end

    pdth_hud.portrait_value_options = pdth_hud.portrait_value_options or {}
    for i, portait in pairs(pdth_hud.portrait_options) do
        pdth_hud.portrait_value_options[i] = "portrait_value_" .. i
    end
end

function pdth_hud:log(string)
	log("PDTH Hud: " .. string)
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
