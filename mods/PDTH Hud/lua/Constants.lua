function pdth_hud:InitConstants()

    self.constants = self.constants or {}
    local const = self.constants

    local scale = self.Options.HUD.Scale
    local OGTMHealth = self.Options.HUD.OGTMHealth

    const.main_health_h = 130 * scale
    const.main_health_w = 64 * scale
    
    const.tm_health_w = 12
    const.tm_health_h = 34
    
    const.tm_condition_demultiplier = 1.25
    
    const.main_perk_multiplier = 5
    const.main_perk_gap = 5
    const.main_perk_health_gap = 2

    const.main_character_font_size = 15 * scale
    const.main_character_y_offset = 2

    const.main_equipment_size = 36 * scale
    const.main_equipment_font_size = 18 * scale
    
    const.main_equipment_y_offset_multiplier = 1.75
    
    const.main_bag_gap = 5 * scale
    
    const.main_firemode_font_size = 14 * scale
    const.main_ammo_font_size = 18 * scale
    const.main_ammo_image_gap = 5 * scale
    const.main_ammo_size_multiplier = 1.2
    const.main_firemode_gap = 3 * scale
    const.main_ammo_panel_x_offset = 5
    
    const.equipment_gap = 4

    const.num_on_right_inflation = 2

    const.tm_gap = 3 * scale
    
    const.tm_condition_font_size = (20 + (OGTMHealth and 5 or 0)) * scale
    const.tm_condition_font_size_flash = (35 + (OGTMHealth and 5 or 0)) * scale
    
    const.tm_equipment_inflation = 5

    const.tm_equipment_font_size = 16 * scale

    const.tm_name_font_size = 14 * scale

    const.tm_name_gap = 3

    const.tm_health_gap = 4 * scale

    const.tm_gradient_width = 300 * scale

end