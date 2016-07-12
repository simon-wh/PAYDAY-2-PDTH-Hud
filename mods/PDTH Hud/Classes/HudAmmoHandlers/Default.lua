HUDAmmoHandler = HUDAmmoHandler or class()

function HUDAmmoHandler:init(parent, panel)
    self._parent = parent
    self._ammo_panel = panel
    self:create_ammo_icons()
end

function HUDAmmoHandler:update_ammo_icons(previous_current_clip)
    if not self._parent._weapon_details then
        return
    end

    local const = pdth_hud.constants

    if self._parent._current_ammo.max_clip > const.main_ammo_max then
        self:destroy_ammo_icons()
        return
    end

    if not self._parent._created_ammo then
        self:create_ammo_icons()
    end

    if self._ammo_panel:num_children() > self._parent._current_ammo.max_clip then
        for i = self._parent._current_ammo.max_clip + 1, self._ammo_panel:num_children() do
            local bullet = self._ammo_panel:child(tostring(i))
            if bullet then
                self._ammo_panel:remove(bullet)
            end
        end
    end

    if pdth_hud.Options:GetValue("HUD/BulletGradualColour") then
        if self._parent._current_ammo.current_clip < previous_current_clip then
            self:refresh_ammo_colour(self._parent._current_ammo.current_clip + 1, previous_current_clip)
        elseif self._parent._current_ammo.current_clip > previous_current_clip then
            self:refresh_ammo_colour(previous_current_clip + 1, self._parent._current_ammo.current_clip)
        end
    else
        self:refresh_ammo_colour()
    end
end

function HUDAmmoHandler:refresh_ammo_colour(start, end_point)
    if not self._parent._current_ammo then
        return
    end
    local const = pdth_hud.constants

    start = start or 1
    end_point = end_point or self._parent._current_ammo.max_clip
    local gradual = pdth_hud.Options:GetValue("HUD/BulletGradualColour")

    local max_clip_rat = math.round(self._parent._current_ammo.max_clip * (gradual and const.main_ammo_empty_gradual_threshold_multiplier or const.main_ammo_empty_threshold_multiplier))

    local ammo_colour = pdth_hud.constants.main_ammo_colour
    if not gradual and self._parent._current_ammo.current_clip <= max_clip_rat then
        local c = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
        ammo_colour = Color(ammo_colour.r, c, c)
    end
    local empty_colour = const.main_ammo_empty_colour
    for i = start, end_point do
        local bullet = self._ammo_panel:child(tostring(i))
        if bullet then
            local empty = i > self._parent._current_ammo.current_clip

            if gradual and i <= max_clip_rat and empty then
                ammo_colour = const.main_ammo_colour
                local clip_ratio = 1 - (i / max_clip_rat)
                ammo_colour = Color(math.lerp(ammo_colour.r, empty_colour.r, clip_ratio), math.lerp(ammo_colour.g, empty_colour.g, clip_ratio), math.lerp(ammo_colour.b, empty_colour.b, clip_ratio))
            end

            bullet:set_color(ammo_colour:with_alpha(empty and const.main_ammo_colour_empty_alpha or const.main_ammo_colour_alpha))
        end
    end
end

function HUDAmmoHandler:refresh()
    local icon, details = unpack(self._parent._weapon_ammo_details)

    for i = 1, self._ammo_panel:num_children() do
        local ammo = self._ammo_panel:child(tostring(i))
        if ammo then
            ammo:set_image(self._parent._weapon_ammo_details[1], unpack(details.texture_rect))
        end
    end
    self:refresh_ammo_colour()
end

function HUDAmmoHandler:create_ammo_icons()
    self:destroy_ammo_icons()

    if not self._parent._weapon_ammo_details or not self._parent._current_ammo then
        return
    end
    local const = pdth_hud.constants

    if self._parent._current_ammo.max_clip > const.main_ammo_max then
        return
    end

    self._parent._created_ammo = true

    local icon, details = unpack(self._parent._weapon_ammo_details)

    local h = self._ammo_panel:h() * (details.h_multi and details.h_multi or 1)
    local w = (h / details.texture_rect[4]) * details.texture_rect[3]

    local prev_bullet
    for i = 1, self._parent._current_ammo.max_clip do
        bullet = self._ammo_panel:bitmap({
            name = tostring(i),
            layer = 1,
            blend_mode = "normal",
            w = w,
            h = h,
            alpha = const.main_ammo_alpha,
            color = const.main_ammo_colour:with_alpha(const.main_ammo_colour_alpha)
            --rotation = details.rotation
        })
        bullet:set_right(prev_bullet and prev_bullet:left() - (details.gap and details.gap or 0) or self._ammo_panel:w())
        bullet:set_center_y(self._ammo_panel:h() / 2)
        bullet:set_image(icon, unpack(details.texture_rect))
        prev_bullet = bullet
    end
end

function HUDAmmoHandler:destroy_ammo_icons()
    self._parent._created_ammo = false
    self._ammo_panel:clear()
end
