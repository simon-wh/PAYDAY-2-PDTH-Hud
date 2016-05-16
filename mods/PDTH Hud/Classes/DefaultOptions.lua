local options = pdth_hud.Options

options.HUD = {}
options.Menu = {}
options.portraits = {}

for i, portrait in pairs(pdth_hud.portrait_options) do
	options.portraits[portrait] = i
end

options.HUD.CameraGrading = true
options.HUD.Coloured = true
options.HUD.OGTMHealth = true
options.HUD.Cameras = true
options.HUD.Assault = true
options.HUD.Gadget = true
options.HUD.Bullet = 2
options.HUD.Objectives = true
options.HUD.Fireselector = true
options.HUD.Interaction = true
options.HUD.Swansong = true
options.HUD.MainHud = true
options.HUD.Scale = 1
options.HUD.spooky_ammo = false
options.HUD.Equipment = true

options.Grading = 8
