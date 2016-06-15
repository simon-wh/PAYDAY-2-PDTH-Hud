HUDAmmoHandlerFlamethrower = HUDAmmoHandlerFlamethrower or class(HUDAmmoHandlerSaw)

function HUDAmmoHandlerFlamethrower:update_ammo_icons(previous_current_clip)
    if not self._parent._weapon_details then
        return
    end

    if not self._parent._created_ammo then
        self:create_ammo_icons()
        return
    end

    local icon, details = unpack(self._parent._weapon_ammo_details)
    local bullet = self._ammo_panel:child("bullet")
    local bullet_bg = self._ammo_panel:child("bg")
    local diff = self._parent._current_ammo.current_clip / self._parent._current_ammo.max_clip
    local new_w = diff * bullet_bg:w()
    bullet:set_texture_rect(details.texture_rect[1] + ((1 - diff) * details.texture_rect[3]), details.texture_rect[2], diff * details.texture_rect[3], details.texture_rect[4])
    bullet:set_w(new_w)
    bullet:set_right(self._ammo_panel:w())
end

function HUDAmmoHandlerFlamethrower:create_ammo_icons()
    self:destroy_ammo_icons()

    if not self._parent._weapon_ammo_details or not self._parent._current_ammo then
        return
    end
    self._parent._created_ammo = true

    local icon, details = unpack(self._parent._weapon_ammo_details)

    local h = self._ammo_panel:h()
    local w = (h / details.texture_rect[4]) * details.texture_rect[3]

    local r, g, b = 1, 1, 1
    if self._parent._current_ammo.current_clip <= math.round(self._parent._current_ammo.max_clip / 4) then
        g = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
        b = self._parent._current_ammo.current_clip / (self._parent._current_ammo.max_clip / 2)
    end

    local bullet_bg = self._ammo_panel:bitmap({
        name = "bg",
        layer = 1,
        blend_mode = "normal",
        w = w,
        h = h,
        alpha = 0.5
    })
    bullet_bg:set_right(self._ammo_panel:w())
    bullet_bg:set_center_y(self._ammo_panel:h() / 2)
    bullet_bg:set_image(icon, unpack(details.texture_rect))

    local bullet = self._ammo_panel:bitmap({
        name = "bullet",
        layer = 2,
		blend_mode = "normal"
    })
    bullet:set_shape(bullet_bg:shape())
    bullet:set_image(icon, unpack(details.texture_rect))
end
