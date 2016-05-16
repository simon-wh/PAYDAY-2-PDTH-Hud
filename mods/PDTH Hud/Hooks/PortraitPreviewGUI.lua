PortraitPreviewGUI = PortraitPreviewGUI or class(TextBoxGui)

PortraitPreviewGUI.portrait_w = 64
PortraitPreviewGUI.portrait_h = 130
PortraitPreviewGUI.portrait_x_gap = 20
PortraitPreviewGUI.portrait_y_gap = 20

function PortraitPreviewGUI:init(ws)
    self._ws = ws
    self:_create_gui()
end

function PortraitPreviewGUI:_create_gui()
    local size = managers.gui_data:scaled_size()

    local columns = math.floor(((size.width / 2) + self.portrait_x_gap) / (self.portrait_w + self.portrait_x_gap))
    local raw_rows = (#tweak_data.criminals.characters / columns)
    local rows = math.floor(raw_rows + 1)
    local remainder = rows ~= raw_rows
    local remaining_chars = (raw_rows - math.floor(raw_rows)) * columns
	self._panel = self._ws:panel():panel({
		name = "main",
		w = (columns * self.portrait_w) + ((columns - 1) * self.portrait_x_gap),
		h = (rows * self.portrait_h) + ((rows - 1) * self.portrait_y_gap)
	})
    self._panel:set_center_y(self._ws:panel():center_y())

    self._portraits = {}
    local cur_char = 1
    --for i, char_tbl in pairs(tweak_data.criminals.characters) do
    for j = 0, rows - 1 do
        local row_panel = self._panel:panel({
            name = "row"..j,
            layer = 1,
            y = (j * self.portrait_h) + (j * self.portrait_y_gap),
            w = (remainder and  j == (rows - 1)) and ((remaining_chars * self.portrait_w) + ((remaining_chars - 1) * self.portrait_x_gap)) or self._panel:w(),
            h = self.portrait_h
        })
        row_panel:set_center_x(self._panel:center_x())

        for i = 0, columns - 1 do
            if cur_char > #tweak_data.criminals.characters then
                break
            end
            local char_tbl = tweak_data.criminals.characters[cur_char]
            local portrait_panel = row_panel:panel({
                name = char_tbl.name,
                layer = 1,
                x = (i * self.portrait_w) + (i * self.portrait_x_gap),
                w = self.portrait_w,
                h = self.portrait_h
            })

            portrait_panel:bitmap({
                name = "bg",
                texture = "",
                align = "bottom",
                blend_mode = "normal",
                w = portrait_panel:w(),
                h = portrait_panel:h(),
                layer = 0
            })

            portrait_panel:bitmap({
                name = "health",
                texture = "",
                color = Color(0.5, 0.8, 0.4),
                blend_mode = "normal",
                w = portrait_panel:w(),
                h = portrait_panel:h(),
                layer = 1
            })
            portrait_panel:bitmap({
                name = "shield",
                texture = "",
                blend_mode = "normal",
                w = portrait_panel:w(),
                h = portrait_panel:h(),
                layer = 3
            })

            self._portraits[cur_char] = portrait_panel
            cur_char = cur_char + 1
        end
    end

    self:refresh()
end

function PortraitPreviewGUI:refresh()
    for i, char_tbl in pairs(tweak_data.criminals.characters) do
        local portrait_panel = self._portraits[i]
        local bg = portrait_panel:child("bg")
        local health = portrait_panel:child("health")
        local shield = portrait_panel:child("shield")

        local texture, rect = pdth_hud.textures:get_portrait_texture(char_tbl.name, "health", true)
        --local y_offset = rect[4] * (1 - self.health_amount)
        --local h_offset = self.health_h * (1 - self.health_amount)

        --health:set_image(texture, rect[1], rect[2] + y_offset, rect[3], rect[4] - y_offset)
        health:set_image(texture, rect[1], rect[2], rect[3], rect[4])
        --health:set_h(self.portrait_h - h_offset)
        health:set_bottom(bg:bottom())

        texture, rect = pdth_hud.textures:get_portrait_texture(char_tbl.name, "armor", true)
        --y_offset = rect[4] * (1 - self.armor_amount)
        --h_offset = self.health_h * (1 - self.armor_amount)
        --shield:set_image(texture, rect[1], rect[2] + y_offset, rect[3], rect[4] - y_offset)
        shield:set_image(texture, rect[1], rect[2], rect[3], rect[4])
        --shield:set_h(self.portrait_h - h_offset)
        shield:set_bottom(bg:bottom())

        texture, rect = pdth_hud.textures:get_portrait_texture(char_tbl.name, "bg", true)
        bg:set_image(texture, unpack(rect))
    end
end

function PortraitPreviewGUI:update(t, dt)

end

function PortraitPreviewGUI:mouse_moved(x, y)
	local inside = self._panel:inside(x, y)
	self._mouse_over = inside
	return inside, inside and "link"
end
function PortraitPreviewGUI:mouse_pressed(button, x, y)
	if button == Idstring("0") and self._panel:inside(x, y) then

		return true
	end
end

function PortraitPreviewGUI:close()
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
	end
end
