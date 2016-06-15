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

    if self._parent._current_ammo.max_clip > 200 then
        self:destroy_ammo_icons()
        return
    end

    if not self._parent._created_ammo then
        self:create_ammo_icons()
        return
    end

    local r, g, b = 1, 1, 1
    if self._parent._current_ammo.current_clip <= math.round(self._parent._current_ammo.max_clip / 4) then
        g = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
        b = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
    end

    if self._ammo_panel:num_children() > self._parent._current_ammo.max_clip then
        for i = max_clip + 1, self._ammo_panel:num_children() do
            local bullet = self._ammo_panel:child(tostring(i))
            if bullet then
                self._ammo_panel:remove(bullet)
            end
        end
    end

    if self._parent._current_ammo.current_clip < previous_current_clip then
        for i = self._parent._current_ammo.current_clip + 1, previous_current_clip do
            local bullet = self._ammo_panel:child(tostring(i))
            if bullet then
                bullet:set_alpha(0.5)
                bullet:set_color(Color(0.2, r, g, b))
            end
        end
    elseif self._parent._current_ammo.current_clip > previous_current_clip then
        for i = previous_current_clip + 1, self._parent._current_ammo.current_clip do
            local bullet = self._ammo_panel:child(tostring(i))
            if bullet then
                bullet:set_alpha(1)
                bullet:set_color(Color(0.8, r, g, b))
            end
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
end

function HUDAmmoHandler:create_ammo_icons()
    self:destroy_ammo_icons()

    if not self._parent._weapon_ammo_details or not self._parent._current_ammo then
        return
    end

    self._parent._created_ammo = true

    local icon, details = unpack(self._parent._weapon_ammo_details)

    --local rotated = details.rotation and (details.rotation == 90 or details.rotation == 270)
    local w, h

    --[[if rotated then
        w = self._ammo_panel:h()
        h = (w / details.texture_rect[3]) * details.texture_rect[4]
    else]]--
        h = self._ammo_panel:h()
        w = (h / details.texture_rect[4]) * details.texture_rect[3]
    --end

    local r, g, b = 1, 1, 1
    if self._parent._current_ammo.current_clip <= math.round(self._parent._current_ammo.max_clip / 4) then
        g = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
        b = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
    end

    local prev_bullet
    for i = 1, self._parent._current_ammo.max_clip do
        bullet = self._ammo_panel:bitmap({
            name = tostring(i),
            layer = 1,
            blend_mode = "normal",
            w = w,
            h = h,
            --rotation = details.rotation
        })
        bullet:set_right(prev_bullet and prev_bullet:left() - (details.gap and details.gap or 0) or self._ammo_panel:w())
        bullet:set_center_y(self._ammo_panel:h() / 2)
        bullet:set_image(icon, unpack(details.texture_rect))
        prev_bullet = bullet

        if i <= self._parent._current_ammo.current_clip then
            bullet:set_alpha(1)
            bullet:set_color(Color(0.8, r, g, b))
        else
            bullet:set_alpha(0.5)
            bullet:set_color(Color(0.2, r, g, b))
        end
    end
end

function HUDAmmoHandler:destroy_ammo_icons()
    self._parent._created_ammo = false
    self._ammo_panel:clear()
end
