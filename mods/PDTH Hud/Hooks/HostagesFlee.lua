CloneClass(CivilianLogicFlee)

function CivilianLogicFlee.update(self, data)
	
    local unit = data.unit
    local my_data = data.internal_data
    local objective = data.objective
    local t = data.t
    if my_data.coarse_path then
        if not my_data.advancing and data.t > my_data.next_action_t then
            local cur_index = my_data.coarse_path_index
            local total_nav_points = #coarse_path
            if cur_index == total_nav_points then
				managers.hint:show_hint("civilian_escaped")
			end
		end
    end
	self.orig.update(self, data)
end