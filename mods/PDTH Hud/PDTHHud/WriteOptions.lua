pdth_hud.loaded_options = pdth_hud.loaded_options or {}
pdth_hud.loaded_options.Ingame = pdth_hud.loaded_options.Ingame or {}
pdth_hud.loaded_options.Menu = pdth_hud.loaded_options.Menu or {}
pdth_hud.loaded_options.Grading = pdth_hud.loaded_options.Grading or {}

pdth_hud.loaded_options.Ingame.CameraGrading = pdth_hud.loaded_options.Ingame.CameraGrading == nil and true or pdth_hud.loaded_options.Ingame.CameraGrading
pdth_hud.loaded_options.portraits = pdth_hud.loaded_options.portraits or {}
for i, portrait in pairs(pdth_hud.portrait_options) do
	pdth_hud.loaded_options.portraits[portrait] = pdth_hud.loaded_options.portraits[portrait] or i
end

pdth_hud.loaded_options.Ingame.Coloured = pdth_hud.loaded_options.Ingame.Coloured == nil and true or pdth_hud.loaded_options.Ingame.Coloured
pdth_hud.loaded_options.Ingame.Cameras = pdth_hud.loaded_options.Ingame.Cameras == nil and true or pdth_hud.loaded_options.Ingame.Cameras
pdth_hud.loaded_options.Ingame.Assault = pdth_hud.loaded_options.Ingame.Assault == nil and true or pdth_hud.loaded_options.Ingame.Assault
pdth_hud.loaded_options.Ingame.Gadget = pdth_hud.loaded_options.Ingame.Gadget == nil and true or pdth_hud.loaded_options.Ingame.Gadget
pdth_hud.loaded_options.Ingame.Bullet = pdth_hud.loaded_options.Ingame.Bullet or 2
pdth_hud.loaded_options.Ingame.Objectives = pdth_hud.loaded_options.Ingame.Objectives == nil and true or pdth_hud.loaded_options.Ingame.Objectives
pdth_hud.loaded_options.Ingame.Fireselector = pdth_hud.loaded_options.Ingame.Fireselector == nil and true or pdth_hud.loaded_options.Ingame.Fireselector
pdth_hud.loaded_options.Ingame.Interaction = pdth_hud.loaded_options.Ingame.Interaction == nil and true or pdth_hud.loaded_options.Ingame.Interaction
pdth_hud.loaded_options.Ingame.Swansong = pdth_hud.loaded_options.Ingame.Swansong == nil and true or pdth_hud.loaded_options.Ingame.Swansong
pdth_hud.loaded_options.Ingame.MainHud = pdth_hud.loaded_options.Ingame.MainHud == nil and true or pdth_hud.loaded_options.Ingame.MainHud
pdth_hud.loaded_options.Ingame.Hud_scale = pdth_hud.loaded_options.Ingame.Hud_scale or 1
pdth_hud.loaded_options.Ingame.spooky_ammo = pdth_hud.loaded_options.Ingame.spooky_ammo == nil and false or pdth_hud.loaded_options.Ingame.spooky_ammo

pdth_hud.loaded_options.Menu.Grading = pdth_hud.loaded_options.Menu.Grading or 8
pdth_hud.loaded_options.Menu.Autonotif = pdth_hud.loaded_options.Menu.Autonotif == nil and true or pdth_hud.loaded_options.Ingame.Autonotif

if tweak_data then
	log("tweak_data")
	for i = 1, #tweak_data.levels._level_index do
		pdth_hud.loaded_options.Grading[tweak_data.levels._level_index[i]] = pdth_hud.loaded_options.Grading[tweak_data.levels._level_index[i]] or 2
	end
else
	pdth_hud._level_index = {
		"welcome_to_the_jungle_1",
		"welcome_to_the_jungle_1_night",
		"welcome_to_the_jungle_2",
		"framing_frame_1",
		"framing_frame_2",
		"framing_frame_3",
		"election_day_1",
		"election_day_2",
		"election_day_3",
		"election_day_3_skip1",
		"election_day_3_skip2",
		"watchdogs_1",
		"watchdogs_2",
		"watchdogs_1_night",
		"watchdogs_2_day",
		"alex_1",
		"alex_2",
		"alex_3",
		"firestarter_1",
		"firestarter_2",
		"firestarter_3",
		"ukrainian_job",
		"jewelry_store",
		"four_stores",
		"mallcrasher",
		"nightclub",
		"branchbank",
		"escape_cafe",
		"escape_park",
		"escape_cafe_day",
		"escape_park_day",
		"escape_street",
		"escape_overpass",
		"escape_garage",
		"escape_overpass_night",
		"safehouse",
		"arm_fac",
		"arm_par",
		"arm_hcm",
		"arm_cro",
		"arm_und",
		"arm_for",
		"family",
		"big",
		"mia_1",
		"mia_2",
		"mia2_new",
		"kosugi",
		"gallery",
		"hox_1",
		"hox_2",
		"pines",
		"cage",
		"hox_3",
		"mus",
		"crojob2",
		"crojob3",
		"crojob3_night",
		"rat",
		"shoutout_raid",
		"arena",
		"kenaz",
		"roberts"
	}
	for i = 1, #pdth_hud._level_index do
		pdth_hud.loaded_options.Grading[pdth_hud._level_index[i]] = pdth_hud.loaded_options.Grading[pdth_hud._level_index[i]] or 2
	end
end
